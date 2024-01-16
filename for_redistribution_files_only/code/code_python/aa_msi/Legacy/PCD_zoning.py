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
import open3d as o3d
import pandas as pd
import matplotlib.pyplot as plt
import tkinter as tk
from tkinter.filedialog import askopenfilename
from tkinter import ttk

##################DEBUG######################
obj = 'C:/Users/guiot/Documents/PRISM/Thèse/Photogrammetry/Rock_trim_norm.obj'
ply = 'C:/Users/guiot/Documents/PRISM/Thèse/Photogrammetry/Rock_trim_norm.ply'
bounds_min = [2, 1, -7.8]  # In meters, XYZ
bounds_max = [2.1, 1.1, -7]
mapping_res = 0.0005
focal = 0.08  # Standoff between origin points and robot coordinates
##############################################


def display_pcd(pcd):
    fig = plt.figure().add_subplot(projection='3d')
    fig.scatter(pcd[1], pcd[2], pcd[3])
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


gui = tk.Tk()
gui.title("PCD Trajectory Computer")
gui.resizable(False, False)
frm = ttk.Frame(gui, padding=10, height=400, width=300)
frm.grid()

baseX = 30
baseY = 30

bt1 = tk.Button(frm, text="PointCloud", command=lambda: (tk.filedialog.askopenfilename(defaultextension='.obj')))
bt1.place(x=30, y=25)

xmin = tk.Entry(frm, width=5).place(x=30, y=60)
xmax = tk.Entry(frm, width=5).place(x=150, y=60)

ymin = tk.Entry(frm, width=5).place(x=30, y=90)
ymax = tk.Entry(frm, width=5).place(x=150, y=90)

zmin = tk.Entry(frm, width=5).place(x=30, y=120)
zmax = tk.Entry(frm, width=5).place(x=150, y=120)

ttk.Label(frm, text="Resolution (m)").place(x=30, y=150)
res = tk.Entry(frm, width=10).place(x=150, y=150)

ttk.Label(frm, text="Focal Length (m)").place(x=30, y=180)
foc = tk.Entry(frm, width=10).place(x=150, y=180)

view_raw = tk.Button(frm, text="Raw PointCloud")

view_zone = tk.Button(frm, text="Viewfinder")

bt2 = tk.Button(frm, text="Compute", command=lambda: (gui.destroy())).place(x=150, y=220)

gui.mainloop()


pcd = pd.read_table(obj, sep=' ', header=None)

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

img_zone = pcd.loc[(bounds_min[0] <= pcd[1])
                   & (pcd[1] <= bounds_max[0])
                   & (bounds_min[1] <= pcd[2])
                   & (pcd[2] <= bounds_max[1])
                   & (bounds_min[2] <= pcd[3])
                   & (pcd[3] <= bounds_max[2])]

# for line in pcd.index:  # Horribly inefficient, deprecated
#    if np.all(bounds_min <= pcd.iloc[line, :2]) and np.all(pcd.iloc[line,:2] <= bounds_max):
#        img_zone.append(line)

path_x = np.arange(bounds_min[0], bounds_max[0], mapping_res)
path_y = np.arange(bounds_min[1], bounds_max[1], mapping_res)

x_bins = pd.cut(img_zone[1], bins=len(path_x), labels=range(len(path_x)))
y_bins = pd.cut(img_zone[2], bins=len(path_y), labels=range(len(path_y)))

img_zone['region'] = ['{}_{}'.format(x, y) for x, y in zip(x_bins, y_bins)]  # Region in x_y bin format

if normals_flag == 0:
    qdt_thresholds = img_zone.groupby('region')[[1, 2]].transform('median')  # Done with median for now, good candidate
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

    # angle_map = img_zone[['region', 'quadrant']].copy()  # Deprecated, turned into qdt_avg
    # angle_map = angle_map.drop_duplicates()
    # angle_map = angle_map.sort_values(['region', 'quadrant'])

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

    AC_012 = qdt_avg.loc[qdt_avg.index.get_level_values('quadrant').isin([0, 1, 2])].groupby('region').diff(periods=2)
    AC_012.drop([0, 1], level=1, axis=0, inplace=True)  # Retains only AC distances

    # As a convention, for 123, A = 1, B = 2, C = 3
    AB_123 = qdt_avg.loc[qdt_avg.index.get_level_values('quadrant').isin([1, 2, 3])].groupby('region').diff()
    AB_123.drop([1, 3], level=1, axis=0, inplace=True)

    AC_123 = qdt_avg.loc[qdt_avg.index.get_level_values('quadrant').isin([1, 2, 3])].groupby('region').diff(periods=2)
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

# Compute the angle of the robot arm
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

######################################### Kind of sort of not working
# Compute the magnitude of normals
# robot_angle['magnitude_normal'] = np.sqrt(robot_pos['norm_x']**2 + robot_pos['norm_y']**2 + robot_pos['norm_z']**2)
# Normalize normals to get unit vectors
# robot_pos[1] = robot_pos[1]/robot_angle['magnitude_normal']  # Doesn't work
# robot_pos[2] = robot_pos[2]/robot_angle['magnitude_normal']  # Doesn't work
# robot_pos[3] = robot_pos[3]/robot_angle['magnitude_normal']  # Doesn't work
# Recompute the magnitude of normals
# robot_angle['magnitude_normal'] = np.sqrt(robot_pos['norm_x']**2 + robot_pos['norm_y']**2 + robot_pos['norm_z']**2)
# Compute the dot product of the normal vector and the camera to origin vector
# robot_angle['dot_product'] = robot_pos['norm_x']*(robot_pos[1] - origin[1]) + robot_pos['norm_y'] *\
#                             (robot_pos[2] - origin[2]) + robot_pos['norm_z']*(robot_pos[3] - origin[3])
# Compute the length of normals
# robot_angle['magnitude_normal'] = np.sqrt(robot_pos['norm_x']**2 + robot_pos['norm_y']**2 + robot_pos['norm_z']**2)
# Compute the direction of normals
# robot_angle['magnitude_direction'] = np.sqrt((origin[1] - robot_pos[1])**2 + (origin[2] - robot_pos[2])**2 +\
#                                      (origin[3] - robot_pos[3])**2)
# Compute the cosine, radians, and degree angle of each robot position
# robot_angle['cos_angle'] = robot_angle['dot_product'] / (robot_angle['magnitude_normal'] *
#                                                          robot_angle['magnitude_direction'])
# robot_angle['angle_radians'] = np.arccos(robot_angle['cos_angle'])
# robot_angle['angle_degrees'] = np.degrees(robot_angle['angle_radians'])


fig = plt.figure().add_subplot(projection='3d')
fig.scatter(origin[1], origin[2], origin[3], c='b')
fig.scatter(robot_pos[1], robot_pos[2], robot_pos[3], c='r')
fig.quiver(robot_pos[1], robot_pos[2], robot_pos[3], -robot_pos["norm_x"], -robot_pos["norm_y"], -robot_pos["norm_z"],
           color='m', length=0.03)
# fig.quiver(origin[1], origin[2], origin[3], robot_pos["norm_x"], robot_pos["norm_y"], robot_pos["norm_z"],
#           color='y', length=0.03)
plt.show()

print("Done!")
