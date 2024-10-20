# Validated on Python 3.8.10
# To run manually through MatLab:
#   path(path, 'code/code_python')
#   pyrunfile('#FILE_NAME#.py')
# If not working:
# _Make sure that Python 3.8 is installed properly
# _Verify that the Matlab version is compatible with Python 3.8
# _Verify that Matlab is using the proper Python environment (i.e: Python 3.8). If not, set it up.
# _Tk and Tcl may need to be copied to the 'Lib' file of the Python 3.8 installation folder

import numpy as np
import tkinter
from math import sqrt
from tkinter import ttk
from PIL import Image, ImageFont, ImageDraw
from copy import copy
from coloraide import Color


def draw_dotted_line(image, origin=[int, int], dest=[int, int], tick_length=30, tick_interval=10):
    # Draws a dotted line between two points on an image. Currently not in use
    dot_pos = copy(origin)

    dist_x = dest[0] - origin[0]
    dist_y = dest[1] - origin[1]

    dist_remaining = sqrt((dest[0] - dot_pos[0]) ** 2 + (dest[1] - dot_pos[1]) ** 2)
    true_tick_length = sqrt(tick_length ** 2 + tick_length ** 2)  # Workaround for easier implementation at the cost of
    # oversized ticks

    if dist_x > 0 and dist_y > 0:
        while dist_remaining >= true_tick_length:
            image.line(xy=[dot_pos, (dot_pos[0] + tick_length, dot_pos[1] + tick_length)], width=5)
            dot_pos[0] = dot_pos[0] + tick_length + tick_interval
            dot_pos[1] = dot_pos[1] + tick_length + tick_interval
    elif dist_x > 0:
        while dist_remaining >= true_tick_length:
            image.line(xy=[dot_pos, (dot_pos[0] + tick_length, dot_pos[1] - tick_length)], width=5)
            dot_pos[0] = dot_pos[0] + tick_length + tick_interval
            dot_pos[1] = dot_pos[1] - tick_length - tick_interval
    elif dist_y > 0:
        while dist_remaining >= true_tick_length:
            image.line(xy=[dot_pos, (dot_pos[0] - tick_length, dot_pos[1] + tick_length)], width=5)
            dot_pos[0] = dot_pos[0] - tick_length - tick_interval
            dot_pos[1] = dot_pos[1] + tick_length + tick_interval

    if dist_remaining > 0:
        image.line([dot_pos, dest], width=5)


def generate_scale(name, gradient, intensities_min, intensities_max, min_cutoff, max_cutoff):
    bar_width = 2500
    bar_height = 100
    padding_x = int(300)
    padding_y = int(100)
    alpha = 50

    scale = np.zeros((bar_height + padding_y, bar_width + padding_x, 4))

    if min_cutoff != intensities_min:
        scale[int(padding_y / 2):int(bar_height + padding_y / 2), 0:int(padding_x / 2), 0] = 200
        scale[int(padding_y / 2):int(bar_height + padding_y / 2), 0:int(padding_x / 2), 1] = 200
        scale[int(padding_y / 2):int(bar_height + padding_y / 2), 0:int(padding_x / 2), 2] = 200
        scale[int(padding_y / 2):int(bar_height + padding_y / 2), 0:int(padding_x / 2), 3] = alpha

    if max_cutoff != intensities_max:
        scale[int(padding_y / 2):int(bar_height + padding_y / 2), int(padding_x / 2):, 0] = 200
        scale[int(padding_y / 2):int(bar_height + padding_y / 2), int(padding_x / 2):, 1] = 200
        scale[int(padding_y / 2):int(bar_height + padding_y / 2), int(padding_x / 2):, 2] = 200
        scale[int(padding_y / 2):int(bar_height + padding_y / 2), int(padding_x / 2):, 3] = alpha

    rank_list = np.arange(0, bar_width)

    for rank in rank_list:  # Replace with a list of ranks that ranges from 0 to 255 (see numpy.range)
        current_colour = Color.convert(gradient(rank / bar_width), "srgb")
        scale[int(padding_y / 2):int(bar_height + padding_y / 2), int(padding_x / 2 + rank), 0] = current_colour[
                                                                                                      0] * 255
        scale[int(padding_y / 2):int(bar_height + padding_y / 2), int(padding_x / 2 + rank), 1] = current_colour[
                                                                                                      1] * 255
        scale[int(padding_y / 2):int(bar_height + padding_y / 2), int(padding_x / 2 + rank), 2] = current_colour[
                                                                                                      2] * 255
        scale[int(padding_y / 2):int(bar_height + padding_y / 2), int(padding_x / 2 + rank), 3] = 255

    scale_save = Image.fromarray(scale.astype('uint8'))

    scale_legend = ImageDraw.Draw(scale_save)

    # font = ImageFont.truetype(font="Agency FB", size=10)

    if min_cutoff != intensities_min:
        scale_legend.text((10, 0), str(intensities_min), font_size=35)
        scale_legend.line(
            xy=[(padding_x / 2, (bar_height + padding_y) / 2), ((padding_x / 2) - 30, (bar_height + padding_y) / 2)],
            width=5)
        scale_legend.line(
            xy=[((padding_x / 2) - 40, (bar_height + padding_y) / 2),
                ((padding_x / 2) - 70, (bar_height + padding_y) / 2)],
            width=5)
        scale_legend.line(
            xy=[((padding_x / 2) - 80, (bar_height + padding_y) / 2),
                ((padding_x / 2) - 110, (bar_height + padding_y) / 2)],
            width=5)
        scale_legend.line(
            xy=[((padding_x / 2) - 120, (bar_height + padding_y) / 2),
                ((padding_x / 2) - 150, (bar_height + padding_y) / 2)],
            width=5)
        scale_legend.line(xy=[(0, bar_height + padding_y / 2), (0, (padding_y / 2) - 5)], width=5)
    if max_cutoff != intensities_max:
        scale_legend.text((bar_width - 30 + padding_x * (3 / 4), 0), str(intensities_max), font_size=35)
        scale_legend.line(
            xy=[(bar_width + padding_x / 2, (bar_height + padding_y) / 2),
                (bar_width + (padding_x / 2) + 30, (bar_height + padding_y) / 2)],
            width=5)
        scale_legend.line(
            xy=[(bar_width + (padding_x / 2) + 40, (bar_height + padding_y) / 2),
                (bar_width + (padding_x / 2) + 70, (bar_height + padding_y) / 2)],
            width=5)
        scale_legend.line(
            xy=[(bar_width + (padding_x / 2) + 80, (bar_height + padding_y) / 2),
                (bar_width + (padding_x / 2) + 110, (bar_height + padding_y) / 2)],
            width=5)
        scale_legend.line(
            xy=[(bar_width + (padding_x / 2) + 120, (bar_height + padding_y) / 2),
                (bar_width + (padding_x / 2) + 150, (bar_height + padding_y) / 2)],
            width=5)
        scale_legend.line(xy=[(bar_width + padding_x, bar_height + padding_y / 2),
                              (bar_width + padding_x, (padding_y / 2) - 5)], width=5)
    scale_legend.text((padding_x / 2, 0), str(min_cutoff), font_size=35)
    scale_legend.text((bar_width - 60 + padding_x / 2, 0), str(max_cutoff), font_size=35)

    scale_legend.line(xy=[(padding_x / 2, bar_height + padding_y / 2), (padding_x / 2, (padding_y / 2) - 5)], width=5)
    scale_legend.line(
        xy=[(bar_width + padding_x / 2, bar_height + padding_y / 2), (bar_width + padding_x / 2, (padding_y / 2) - 5)],
        width=5)

    scale_save.save('files/colour_scales/' + name + '-legend' + '.png', mode="SRGB")

    # scale_save.show()
