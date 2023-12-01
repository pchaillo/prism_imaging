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

obj = 'C:/Users/guiot/Documents/PRISM/Thèse/Photogrammetry/Rock_trim.obj'
ply = 'C:/Users/guiot/Documents/PRISM/Thèse/Photogrammetry/Rock_trim.ply'
bounds_min = [0, 0]
bounds_max = [1.5, 1.5]
mapping_res = 0.1
focal = 800


def extract_pcd(pcd, normals_flag):
    pcd_coords = pd.DataFrame()
    pos = 0
    for line in pcd[0]:  # Very slow, avoid recording normals if at all possible
        if line == "v":
            pcd_coords._append(pcd.iloc[pos, 1:4])
        pos = pos + 1


def display_pcd(pcd):
    fig = plt.figure().add_subplot(projection='3d')
    fig.scatter(pcd[1], pcd[2], pcd[3])
    plt.show()


def pcd_to_pixel(pcd, xmin, ymin, res):  # Returns every point in a given pixel
    pixel_pcd = pcd.loc[(xmin <= pcd[1]) & (pcd[1] <= xmin + res) & (ymin <= pcd[2]) & (pcd[2] <= ymin + res)]
    return pixel_pcd


pcd = pd.read_table(obj,sep=' ', header=None)

# Check whether normals are stored in file
if pcd.iloc[1, 0] == "v":
    normals_flag = 0
else:
    normals_flag = 1
    print("Normals detected. Initiating parsing. This may take a while.")

if normals_flag == 1:
    extract_pcd(pcd, normals_flag)

pcd = pcd.iloc[:, 1:4]

img_zone = pcd.loc[(bounds_min[0] <= pcd[1])
                   & (pcd[1] <= bounds_max[0])
                   & (bounds_min[1] <= pcd[2])
                   & (pcd[2] <= bounds_max[1])]

# for line in pcd.index:  # Horribly inefficient, deprecated
#    if np.all(bounds_min <= pcd.iloc[line, :2]) and np.all(pcd.iloc[line,:2] <= bounds_max):
#        img_zone.append(line)

limits = [min(img_zone[1]), max(img_zone[1]), min(img_zone[2]), max(img_zone[2]), min(img_zone[3]), max(img_zone[3])]

path_x = np.arange(bounds_min[0], bounds_max[0], mapping_res)
path_y = np.arange(bounds_min[1], bounds_max[1], mapping_res)

x_bins = pd.cut(img_zone[1], bins=len(path_x), labels=range(len(path_x)))  # change bins and labels as needed
y_bins = pd.cut(img_zone[2], bins=len(path_y), labels=range(len(path_y)))  # change bins and labels as needed

img_zone['region'] = ['{}_{}'.format(x, y) for x, y in zip(x_bins, y_bins)]  # Region in x_y bin format

qdt_thresholds = img_zone.groupby('region')[[1, 2]].transform('median')  # Done with median for now, good candidate
# for new methods
img_zone['quadrant_x'] = (img_zone[1] > qdt_thresholds[1]).astype(int)
img_zone['quadrant_y'] = (img_zone[2] > qdt_thresholds[2]).astype(int)
img_zone['quadrant'] = img_zone['quadrant_y']*2 + img_zone['quadrant_x']
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
# Note: df.index.get_level_values is needed to get 'quadrant' values out of a MultIndex Df like this one. Alternatively,
# df.reset_index() restores 'quadrant' and 'region' as columns and allows for df['quadrant'] and similar queries.
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
normals = (normal_012 + normal_123)/2

robot_pos = img_zone.groupby(['region']).mean()
robot_pos.drop('quadrant', axis=1, inplace=True)
robot_pos = robot_pos + normals * focal

fig = plt.figure().add_subplot(projection='3d')
fig.scatter(qdt_avg[1], qdt_avg[2], qdt_avg[3], c='b')
fig.scatter(robot_pos[1], robot_pos[2], robot_pos[3], c='r')
plt.show()

display_pcd(pcd)
display_pcd(qdt_avg)

print("Done!")
