# This version requires normals to be precomputed
# Only works with OBJ pointclouds
############################# GENERAL IDEA
# 1. ASSIGN EVERY POINT TO A PIXEL
# 2. SEPARATE EACH PIXEL IN FOUR QUADRANTS
# 3. AVERAGE PIXEL COORDINATES IN EACH QUADRANT
# Note: Median could be more robust to outliers (i.e., points cropped from unintended part of the figure)
# 4. CALCULATE SLOPE BETWEEN THE FOUR QUADRANTS
# Note: this can also be done using PCA to calculate the normal vector of each region

import numpy as np
import copy
import pandas as pd
import matplotlib.pyplot as plt
import tkinter as tk
from tkinter.filedialog import askopenfilename
from tkinter import ttk


##################DEBUG######################
# obj = 'C:/Users/guiot/Documents/PRISM/Thèse/Photogrammetry/Rock_trim_norm.obj'
# ply = 'C:/Users/guiot/Documents/PRISM/Thèse/Photogrammetry/Rock_trim_norm.ply'
# bounds_min = [2, 1, -7.8]  # In meters, XYZ
# bounds_max = [2.1, 1.1, -7]
# mapping_res = 0.0005
# focal = 0.08  # Standoff between origin points and robot coordinates
##############################################


def uploadaction():
    global file
    file = tk.filedialog.askopenfilename(defaultextension='.obj')
    return file


def load_pcd(file):  # Loads the pointcloud and verifies normals
    global pcd, normals_flag
    pcd = pd.read_table(file, sep=' ', header=None)
    # Check whether normals are stored in file
    if pcd.iloc[1, 0] == "v":
        normals_flag = 0
        pcd = pcd.iloc[:, 1:4]
    else:
        normals_flag = 1
        pcd_coords = pcd.loc[pcd[0] == 'v'].reset_index().drop([0, "index"], axis=1)
        pcd_norm = pcd.loc[pcd[0] == 'vn'].reset_index().drop([0, 'index'], axis=1)
        pcd = pcd_coords
        pcd[['norm_x', 'norm_y', 'norm_z']] = pcd_norm
    print('File successfully loaded.')
    return pcd, normals_flag


def display_pcd(pcd):
    fig = plt.figure().add_subplot(projection='3d')
    fig.scatter(pcd[1], pcd[2], pcd[3])
    print("Displaying the plot.")
    plt.show()


def extract_pcd(pcd):
    pcd_coords = pd.DataFrame()
    pos = 0
    for line in pcd[0]:  # Very slow, avoid recording normals if at all possible
        if line == "v":
            pcd_coords._append(pcd.iloc[pos, 1:4])
        pos = pos + 1


def pcd_to_pixel(pcd, xmin, ymin, res):  # Returns every point in a given pixel
    pixel_pcd = pcd.loc[(xmin <= pcd[1]) & (pcd[1] <= xmin + res) & (ymin <= pcd[2]) & (pcd[2] <= ymin + res)]
    return pixel_pcd


def compute_distance(p1_x, p1_y, p1_z, p2_x, p2_y, p2_z):
    distance = np.sqrt((p1_x - p2_x) ** 2 + (p1_y - p2_y) ** 2 + (p1_z - p2_z) ** 2)
    return distance


def zone_selector(pcd, bounds_min, bounds_max):
    img_zone = pcd.loc[(bounds_min[0] <= pcd[1])
                       & (pcd[1] <= bounds_max[0])
                       & (bounds_min[1] <= pcd[2])
                       & (pcd[2] <= bounds_max[1])
                       & (bounds_min[2] <= pcd[3])
                       & (pcd[3] <= bounds_max[2])]
    img_zone = img_zone.reset_index()
    img_zone.drop("index", axis=1)
    return img_zone


def set_boundaries():
    global bounds_min, bounds_max
    bounds_min = [float(xmin.get()), float(ymin.get()), float(zmin.get())]
    bounds_max = [float(xmax.get()), float(ymax.get()), float(zmax.get())]
    for val in bounds_min:
        index = bounds_min.index(val)
        if bounds_max[index] < bounds_min[index]:
            buffer = bounds_max[index]
            bounds_max[index] = bounds_min[index]
            bounds_min[index] = buffer
            print('A minimum value was set higher than its corresponding maximum value. Reversing.')
    print('Boundaries set.')
    return bounds_min, bounds_max


def set_mapping_params():
    global focal, res
    res = float(resolution.get())
    focal = float(foc.get())
    print('Mapping parameters set.')
    return focal, res


def pcd_binning(img_zone, bounds_min, bounds_max, res):
    path_x = np.arange(bounds_min[0], bounds_max[0], res)
    path_y = np.arange(bounds_min[1], bounds_max[1], res)

    x_bins = pd.cut(img_zone[1], bins=len(path_x), labels=range(len(path_x)))
    y_bins = pd.cut(img_zone[2], bins=len(path_y), labels=range(len(path_y)))

    img_zone['region'] = ['{}_{}'.format(x, y) for x, y in zip(x_bins, y_bins)]  # Region in x_y bin format
    return img_zone


def normals_compute(img_zone, normals_flag):
    # Calculation of normals, several methods will be implemented
    if normals_flag == 0:
        qdt_thresholds = pcd.groupby('region')[[1, 2]].transform('median')  # Done with median for now, good candidate
        # for new methods
        img_zone['quadrant_x'] = (img_zone[1] > qdt_thresholds[1]).astype(int)
        img_zone['quadrant_y'] = (img_zone[2] > qdt_thresholds[2]).astype(int)
        img_zone['quadrant'] = img_zone['quadrant_y'] * 2 + img_zone['quadrant_x']
        img_zone = img_zone.drop('quadrant_x', axis=1)
        img_zone = img_zone.drop('quadrant_y', axis=1)

        # Note on quadrants
        # 0: < threshold_x, < threshold_y
        # 1: > threshold_x, < threshold_y
        # 2: < threshold_x, > threshold_y
        # 3: > threshold_y, > threshold_y

        qdt_avg = img_zone.groupby(['region', 'quadrant']).mean()
        qdt_avg = qdt_avg.sort_values(['region', 'quadrant'])

        # Calculate distances in both the 0/1/2 and 1/2/3 quadrants
        # Note: df.index.get_level_values is needed to get 'quadrant' values out of a MultIndex Df like this one.
        # Alternatively, df.reset_index() restores 'quadrant' and 'region' as columns and allows for df['quadrant'] and
        # similar queries.
        # As a convention, for 012, A = 0, B = 1, C = 2
        # AB is found in AB_012, 'quadrant' = 1
        # AC is found in AC_012, 'quadrant' = 2
        AB_012 = qdt_avg.loc[qdt_avg.index.get_level_values('quadrant').isin([0, 1, 2])].groupby('region').diff()
        AB_012.drop([0, 2], level=1, axis=0, inplace=True)  # Retains only AB distances

        AC_012 = qdt_avg.loc[qdt_avg.index.get_level_values('quadrant').isin([0, 1, 2])].groupby('region').diff(
            periods=2)
        AC_012.drop([0, 1], level=1, axis=0, inplace=True)  # Retains only AC distances

        # As a convention, for 123, A = 1, B = 2, C = 3
        AB_123 = qdt_avg.loc[qdt_avg.index.get_level_values('quadrant').isin([1, 2, 3])].groupby('region').diff()
        AB_123.drop([1, 3], level=1, axis=0, inplace=True)

        AC_123 = qdt_avg.loc[qdt_avg.index.get_level_values('quadrant').isin([1, 2, 3])].groupby('region').diff(
            periods=2)
        AC_123.drop([1, 2], level=1, axis=0, inplace=True)

        # Calculate normals for each plane
        normal_012 = np.cross(AB_012, AC_012)
        normal_123 = np.cross(AB_123, AC_123)
        normals = (normal_012 + normal_123) / 2
    robot_pos = img_zone.groupby(['region']).mean()  # Other methods are possible (median...)
    origin = robot_pos.copy().drop(['norm_x', 'norm_y', 'norm_z'], axis=1)
    if normals_flag == 0:
        robot_pos.drop('quadrant', axis=1, inplace=True)
        robot_pos = robot_pos + normals * focal  # Computes positions for the robot arm
    else:
        robot_pos[1] = robot_pos[1] + robot_pos["norm_x"] * focal
        robot_pos[2] = robot_pos[2] + robot_pos["norm_y"] * focal
        robot_pos[3] = robot_pos[3] + robot_pos["norm_z"] * focal
    return robot_pos, origin


def angle_compute(robot_pos, origin):  # Computes the angle of the robot arm, requires prior computation of positions
    robot_angle = pd.DataFrame()
    trigo_data = pd.DataFrame()  # A is the origin, B the camera position, C/D/E are projection of B on the three planes
    trigo_data['AB'] = compute_distance(robot_pos[1], robot_pos[2], robot_pos[3], origin[1], origin[2], origin[3])
    trigo_data['BC'] = compute_distance(robot_pos[1], robot_pos[2], robot_pos[3], robot_pos[1], robot_pos[2],
                                        0)  # C is the projection of B on the XY plane
    trigo_data['AC'] = compute_distance(origin[1], origin[2], origin[3], robot_pos[1], robot_pos[2], 0)

    trigo_data['BD'] = compute_distance(robot_pos[1], robot_pos[2], robot_pos[3], 0, robot_pos[2],
                                        robot_pos[3])  # D is the projection of B in the YZ plane
    trigo_data['AD'] = compute_distance(origin[1], origin[2], origin[3], 0, robot_pos[2], robot_pos[3])

    trigo_data['BE'] = compute_distance(robot_pos[1], robot_pos[2], robot_pos[3], robot_pos[1], 0,
                                        robot_pos[3])  # E is the projection of B in the XZ plane
    trigo_data['AE'] = compute_distance(origin[1], origin[2], origin[3], robot_pos[1], 0, robot_pos[3])

    robot_angle["pitch_rad"] = np.arccos((trigo_data["AB"] ** 2 + trigo_data['BC'] ** 2 - (trigo_data['AC']) ** 2) /
                                         (2 * trigo_data['AB'] * trigo_data['BC']))
    robot_angle["pitch_dg"] = np.degrees(robot_angle["pitch_rad"])

    robot_angle["yaw_rad"] = np.arccos((trigo_data["AB"] ** 2 + trigo_data['BD'] ** 2 - (trigo_data['AD']) ** 2) /
                                       (2 * trigo_data['AB'] * trigo_data['BD']))
    robot_angle["yaw_dg"] = np.degrees(robot_angle["yaw_rad"])

    robot_angle["roll_rad"] = np.arccos((trigo_data["AB"] ** 2 + trigo_data['BE'] ** 2 - (trigo_data['AE']) ** 2) /
                                        (2 * trigo_data['AB'] * trigo_data['BE']))
    robot_angle["roll_dg"] = np.degrees(robot_angle["roll_rad"])
    return robot_angle


def plot_normals(origin, robot_pos):
    fig = plt.figure().add_subplot(projection='3d')
    fig.scatter(origin[1], origin[2], origin[3], c='b')
    fig.scatter(robot_pos[1], robot_pos[2], robot_pos[3], c='r')
    fig.quiver(robot_pos[1], robot_pos[2], robot_pos[3], -robot_pos["norm_x"], -robot_pos["norm_y"],
               -robot_pos["norm_z"],
               color='m', length=0.03)
    # fig.quiver(origin[1], origin[2], origin[3], robot_pos["norm_x"], robot_pos["norm_y"], robot_pos["norm_z"],
    #           color='y', length=0.03)
    plt.show()


def pos_compute(img_zone, *args, **kwargs):
    global robot_pos, robot_angle
    img_zone = pcd_binning(img_zone, bounds_min, bounds_max, res)
    print('1/4')
    robot_pos, origin = normals_compute(img_zone, normals_flag)
    print('2/4')
    robot_angle = angle_compute(robot_pos, origin)
    print('3/4')
    plot_normals(origin, robot_pos)
    print('4/4')
    return robot_pos, robot_angle


def export_pos(robot_pos, robot_angle, file):
    exp_name = copy.copy(file)
    char_bgn = max([i for i, ltr in enumerate(exp_name) if ltr == '/'])
    exp_name = exp_name[(char_bgn + 1):exp_name.index('.')]
    export_file = open((exp_name + '.csv'), 'x')
    export_data = pd.concat([robot_pos, robot_angle], axis=1)
    export_data.drop(columns='index', inplace=True)
    export_data.rename(columns={1: "X", 2: "Y", 3: "Z"}, inplace=True)
    export_data.to_csv(export_file, sep=' ')
    print('File successfully exported.')


gui = tk.Tk()
gui.title("PCD Trajectory Computer")
gui.resizable(False, False)
frm = ttk.Frame(gui, padding=10, height=400, width=300)
frm.grid()

bt1 = tk.Button(frm, text="PointCloud", command=lambda: (load_pcd(uploadaction())))
bt1.place(x=30, y=10)

ttk.Label(frm, text="Min").place(x=30, y=40)
ttk.Label(frm, text="Max").place(x=150, y=40)

ttk.Label(frm, text="X").place(x=10, y=60)
xmin = tk.StringVar(value="0")
xmin_input = tk.Entry(frm, textvariable=xmin, width=5).place(x=30, y=60)
xmax = tk.StringVar(value="0.1")
xmax_input = tk.Entry(frm, textvariable=xmax, width=5).place(x=150, y=60)

ttk.Label(frm, text="Y").place(x=10, y=90)
ymin = tk.StringVar(value="0")
ymin_input = tk.Entry(frm, textvariable=ymin, width=5).place(x=30, y=90)
ymax = tk.StringVar(value="0.1")
ymax_input = tk.Entry(frm, textvariable=ymax, width=5).place(x=150, y=90)

ttk.Label(frm, text="Z").place(x=10, y=120)
zmin = tk.StringVar(value="0")
zmin_input = tk.Entry(frm, textvariable=zmin, width=5).place(x=30, y=120)
zmax = tk.StringVar(value="0.1")
zmax_input = tk.Entry(frm, textvariable=zmax, width=5).place(x=150, y=120)

ttk.Label(frm, text="Resolution (m)").place(x=30, y=150)
resolution = tk.StringVar(value="0.0005")
res_input = tk.Entry(frm, textvariable=resolution, width=10).place(x=150, y=150)

ttk.Label(frm, text="Focal Length (m)").place(x=30, y=180)
foc = tk.StringVar(value="0.08")
foc_input = tk.Entry(frm, textvariable=foc, width=10).place(x=150, y=180)

view_raw = tk.Button(frm, text="Raw PointCloud", command=lambda: (display_pcd(pcd)))
view_raw.place(x=30, y=210)

view_zone = tk.Button(frm, text="Viewfinder", command=lambda: (set_boundaries(),
                                                               display_pcd(zone_selector(pcd, bounds_min, bounds_max))))
view_zone.place(x=150, y=210)

bt2 = tk.Button(frm, text="Compute Positions", command=lambda: (set_boundaries(),
                                                                set_mapping_params(),
                                                                pos_compute(
                                                                    zone_selector(pcd, bounds_min, bounds_max))))
bt2.place(x=150, y=240)

bt3 = tk.Button(frm, text="Export", command=lambda: (export_pos(robot_pos, robot_angle, file))).place(x=150, y=270)

gui.mainloop()

print("Done!")


# Translation layer needed to be in the robot's referential
