# This program's purpose is to allow coregistration of molecular data onto corresponding optical images
# It does so by performing a perspective transformation on two sets of four keypoints via a homography matrix
# Matrices can be recovered and reused for shunting the coregistration process. This is intended for mass coregistration
# of molecular images on a single optical image
# Obtained images should be sent back to the PLY converter to obtain coregistered topographical data
# Please note that it is CRUCIAL to be pixel accurate during the coregistration process. Do not hesitate to zoom and pan
# on images to ease the process.
# I advise picking four points as far apart from each other as possible in order to get the best results

import cv2  # opencv
import numpy as np
import os
import pandas
import sys
import tkinter
from tkinter import ttk
from tkinter.filedialog import askopenfilename

# Creation of global variables
image_1 = None
image_2 = None
merge = None


# Define the name fetching function
def file_name_recovery(filepath):
    # This function returns a file's name and its extension as two separate entities in order to allow for easier
    # manipulation
    global tgtnamefin, tgtext
    tgtname = ''
    rvstgtname = ''
    tgtnamefin = ''
    tgtext = ''
    rvstgtext = ''
    for i in reversed(filepath):
        if i != "/":
            rvstgtname = rvstgtname + i
        else:
            break

    for i in reversed(rvstgtname):
        tgtname = tgtname + i

    for i in tgtname:
        if i != '.':
            tgtnamefin = tgtnamefin + i  # Target name
        else:
            break

    for i in reversed(filepath):
        if i != '.':
            rvstgtext = rvstgtext + i
        else:
            break

    for i in reversed(rvstgtext):
        tgtext = tgtext + i  # Target extension
    return tgtnamefin, tgtext


gui = tkinter.Tk()
gui.title("Manual Picture Coregistration")
gui.resizable(False, False)
frm = ttk.Frame(gui, padding=10, height=180, width=220)
frm.grid()


def bt1_upload():
    global image_1
    image_1 = askopenfilename()


bt1 = ttk.Button(frm, text="Target", command=bt1_upload)
bt1.place(x=120, y=0)
ttk.Label(frm, text="Optical image").place(x=0, y=3)


def bt2_upload():
    global image_2
    image_2 = askopenfilename()


bt2 = ttk.Button(frm, text="Target", command=bt2_upload)
bt2.place(x=120, y=27)
ttk.Label(frm, text="Molecular 2D image").place(x=0, y=30)


def matrix_removal():
    file_name_recovery(image_1)
    try:
        os.remove('code\\code_python\\settings\\' + tgtnamefin + '-matrix.txt')
    except FileNotFoundError:
        print('No transformation matrix was found. Initiating manual coregistration.')

ttk.Label(frm, text="New manual coregistration").place(x=0, y=60)
bt3 = ttk.Button(frm, text="Start", command=lambda: [matrix_removal(), set_merge(), gui.destroy()])
bt3.place(x=0, y=80)


def set_merge():
    global merge
    merge = (sldr1.get())/100
    merge = float(merge)

ttk.Label(frm, text="Optical image opacity").place(x=0, y=105)
sldr1 = tkinter.Scale(frm, from_=0, to=100, orient=tkinter.HORIZONTAL)
sldr1.place(x=0, y=125)
sldr1.set(50)

bt_quit = ttk.Button(frm, text="Quit", command=lambda: [set_merge(), gui.destroy()])
bt_quit.place(x=120, y=140)

gui.mainloop()

# Selection of images
img1 = cv2.imread(image_1)  # Optical image
img2 = cv2.imread(image_2)  # Molecular image

# Initialize global variables
clicked_points = []
M = np.identity(3)
img_display = None

# Define the zoom level and pan offset
zoom_level = 1.0
pan_offset = (0, 0)


# Define mouse callback function to get clicked points and move image
def mouse_callback(event, x, y, flags, params):
    global clicked_points, M, img_display, pan_offset, zoom_level
    if event == cv2.EVENT_LBUTTONUP:
        # Adjust the mouse click coordinates for zoom and pan
        adjusted_x = int((x + pan_offset[0]) / zoom_level)
        adjusted_y = int((y + pan_offset[1]) / zoom_level)
        clicked_points.append((adjusted_x, adjusted_y))
        cv2.circle(img_display, (adjusted_x, adjusted_y), 5, (0, 200, 255), 2)
        if len(clicked_points) % 4 == 0 and len(clicked_points) != 0:
            cv2.destroyAllWindows()


# Define the window resizing and panning capabilities, as well as proper offsets of clicked points
def window_resize():
    global zoom_level, pan_offset, clicked_points
    clicks_ini = len(clicked_points)
    while True:
        # Apply the zoom and pan transformation to the image
        zoomed_img = cv2.resize(img_display, None, fx=zoom_level, fy=zoom_level)
        pan_x, pan_y = pan_offset
        translated_img = zoomed_img[pan_y:pan_y + img_display.shape[0], pan_x:pan_x + img_display.shape[1]]

        # Show the image and wait for user input
        cv2.imshow(selected_image, translated_img)
        key = cv2.waitKey(1)

        # Handle user input
        if key == ord('='):
            zoom_level *= 1.1
        elif key == ord('-'):
            zoom_level /= 1.1
        elif key == ord('w') or key == ord('z'):
            pan_offset = (pan_offset[0], pan_offset[1] - 10)
        elif key == ord('a') or key == ord('q'):
            pan_offset = (pan_offset[0] - 10, pan_offset[1])
        elif key == ord('s'):
            pan_offset = (pan_offset[0], pan_offset[1] + 10)
        elif key == ord('d'):
            pan_offset = (pan_offset[0] + 10, pan_offset[1])
        elif len(clicked_points) % 4 == 0 and len(clicked_points) != clicks_ini:
            break


if img1.shape[0] < img2.shape[0] or img1.shape[1] < img2.shape[1]:
    print("Error: Please try again with a higher resolution reference image")
    sys.exit()

# Export file name recovery
file_name_recovery(image_1)
tgtname = tgtnamefin + '-coreg.' + tgtext

# Matrix recovery
try:
    M = pandas.read_csv('code\\code_python\\settings\\' + tgtnamefin + '-matrix.txt', sep=' ', header=None)
    M = M.to_numpy()
    M = M.reshape((3, 3))
except:
    M = None

# Display first image
if M is None:
    selected_image = 'Image 1'
    cv2.namedWindow(selected_image)
    img_display = img1.copy()
    cv2.imshow(selected_image, img_display)
    cv2.setMouseCallback(selected_image, mouse_callback)
    window_resize()

# Display second image
if M is None:
    selected_image = 'Image 2'
    cv2.namedWindow(selected_image)
    img_display = img2.copy()
    cv2.imshow(selected_image, img_display)
    cv2.setMouseCallback(selected_image, mouse_callback)
    window_resize()

# Calculate transformation matrix
if M is None:
    clicked_points = np.array(clicked_points)
    src_pts = clicked_points[4:8]
    dst_pts = clicked_points[0:4]
    M = cv2.findHomography(src_pts, dst_pts)[0]

# Warp image and overlay on first image
img1_display = img1.copy()
img2_warped = cv2.warpPerspective(src=img2, M=M, dsize=(img1.shape[1], img1.shape[0]))
# cv2.imshow("Warped", img2_warped)
merged_img = cv2.addWeighted(img1_display, merge, img2_warped, 1-merge, 0)
# cv2.imshow('Merge', merged_img)  # Kept for debugging/verbose behaviour

# Save the matrix
matrix = open('code\\code_python\\settings\\' + tgtnamefin + '-matrix.txt', 'w')
M.tofile(matrix, sep=' ')

# Create a mask of the pixels that originally belonged to Image 2 in the merge
img2_merged = np.zeros_like(img1)
img2_merged[img2_warped != 0] = merged_img[img2_warped != 0]

# Reverse transformation to obtain original img2
M_inv = np.linalg.inv(M)
img2_reconstructed = cv2.warpPerspective(img2_merged, M_inv, (img2.shape[1], img2.shape[0]))

# Save the reconstructed Image 2
file_name_recovery(image_2)
cv2.imwrite('3d_export\\coregistered_images\\' + tgtnamefin + '-coreg.png', img2_reconstructed)

# Destroy all windows
cv2.destroyAllWindows()

print(tgtnamefin, '-coreg.png', 'was properly saved in 3d_export/coregistered_images/')