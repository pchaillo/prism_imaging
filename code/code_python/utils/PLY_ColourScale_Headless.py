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
from PIL.ImageQt import ImageQt
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


def generate_scale(name, gradient, intensities_min, intensities_max, min_cutoff, max_cutoff, export_path_scale , save=False, **kwargs):
    bar_width = 1200
    bar_height = 100
    padding_x = 800
    padding_x_offset = 100 # Gives leeway for annotations to extend away from the image
    padding_y = 250
    txt_y_padding = 110
    alpha = 50
    font_size = 80

    #kwargs central_mz and tolerance are needed to bake the mz of interest in the scale
    if kwargs:
        central_mz = kwargs.get("central_mz")
        tolerance = kwargs.get("tolerance")
        mask = [val is None for val in [central_mz, tolerance]]
        if not any(mask):
            offset = 100
            padding_y += offset
            txt_y_padding += offset/2

    scale = np.zeros((bar_height + padding_y, bar_width + padding_x, 4))

    if min_cutoff != intensities_min:
        scale[int(padding_y / 2):int(bar_height + padding_y / 2), padding_x_offset:int(padding_x / 2), 0] = 200
        scale[int(padding_y / 2):int(bar_height + padding_y / 2), padding_x_offset:int(padding_x / 2), 1] = 200
        scale[int(padding_y / 2):int(bar_height + padding_y / 2), padding_x_offset:int(padding_x / 2), 2] = 200
        scale[int(padding_y / 2):int(bar_height + padding_y / 2), padding_x_offset:int(padding_x / 2), 3] = alpha

    if max_cutoff != intensities_max:
        scale[int(padding_y / 2):int(bar_height + padding_y / 2),
        int(padding_x / 2):bar_width + padding_x - padding_x_offset, 0] = 200
        scale[int(padding_y / 2):int(bar_height + padding_y / 2),
        int(padding_x / 2):bar_width + padding_x - padding_x_offset, 1] = 200
        scale[int(padding_y / 2):int(bar_height + padding_y / 2),
        int(padding_x / 2):bar_width + padding_x - padding_x_offset, 2] = 200
        scale[int(padding_y / 2):int(bar_height + padding_y / 2),
        int(padding_x / 2):bar_width + padding_x - padding_x_offset, 3] = alpha

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
        # Minimum Absolute Intensity
        scale_legend.text((padding_x_offset, txt_y_padding), f"{intensities_min}%", font_size=font_size, anchor="ls")
        # Minimum Cutoff
        scale_legend.text((padding_x / 2 + 100, txt_y_padding), f"{min_cutoff}%", font_size=font_size, anchor="rs")
        # Padding lines
        scale_legend.line(
            xy=[(padding_x / 2, (bar_height + padding_y) / 2), ((padding_x / 2) - 50, (bar_height + padding_y) / 2)],
            width=5)
        scale_legend.line(
            xy=[((padding_x / 2) - 70, (bar_height + padding_y) / 2),
                ((padding_x / 2) - 120, (bar_height + padding_y) / 2)],
            width=5)
        scale_legend.line(
            xy=[((padding_x / 2) - 140, (bar_height + padding_y) / 2),
                ((padding_x / 2) - 190, (bar_height + padding_y) / 2)],
            width=5)
        scale_legend.line(
            xy=[((padding_x / 2) - 210, (bar_height + padding_y) / 2),
                ((padding_x / 2) - 260, (bar_height + padding_y) / 2)],
            width=5)
        scale_legend.line(
            xy=[((padding_x / 2) - 280, (bar_height + padding_y) / 2),
                ((padding_x / 2) - 300, (bar_height + padding_y) / 2)],
            width=5)
        scale_legend.line(xy=[(padding_x_offset, bar_height + padding_y / 2), (padding_x_offset, (padding_y / 2) - 5)],
                          width=5)
    else:
        scale_legend.text((padding_x / 2 + 50, txt_y_padding), f"{intensities_min}%", font_size=font_size, anchor="rs")

    if max_cutoff != intensities_max:
        # Maximum Absolute Intensity
        scale_legend.text((bar_width + padding_x - padding_x_offset, txt_y_padding), f"{intensities_max}%",
                          font_size=font_size, anchor="rs")
        # Maximum Cutoff
        scale_legend.text((bar_width + padding_x / 2 - 100, txt_y_padding), f"{max_cutoff}%", font_size=font_size,
                          anchor="ls")
        # Padding lines
        scale_legend.line(
            xy=[(bar_width + padding_x / 2, (bar_height + padding_y) / 2),
                (bar_width + (padding_x / 2) + 50, (bar_height + padding_y) / 2)],
            width=5)
        scale_legend.line(
            xy=[(bar_width + (padding_x / 2) + 70, (bar_height + padding_y) / 2),
                (bar_width + (padding_x / 2) + 120, (bar_height + padding_y) / 2)],
            width=5)
        scale_legend.line(
            xy=[(bar_width + (padding_x / 2) + 140, (bar_height + padding_y) / 2),
                (bar_width + (padding_x / 2) + 190, (bar_height + padding_y) / 2)],
            width=5)
        scale_legend.line(
            xy=[(bar_width + (padding_x / 2) + 210, (bar_height + padding_y) / 2),
                (bar_width + (padding_x / 2) + 260, (bar_height + padding_y) / 2)],
            width=5)
        scale_legend.line(
            xy=[(bar_width + (padding_x / 2) + 280, (bar_height + padding_y) / 2),
                (bar_width + (padding_x / 2) + 300, (bar_height + padding_y) / 2)],
            width=5)
        scale_legend.line(xy=[(bar_width + padding_x - padding_x_offset, bar_height + padding_y / 2),
                              (bar_width + padding_x - padding_x_offset, (padding_y / 2) - 5)], width=5)
    else:
        scale_legend.text((bar_width + padding_x / 2 - 50, txt_y_padding), f"{intensities_max}%", font_size=font_size,
                          anchor="ls")


    scale_legend.line(xy=[(padding_x / 2, bar_height + padding_y / 2), (padding_x / 2, (padding_y / 2) - 5)], width=5)
    scale_legend.line(
        xy=[(bar_width + padding_x / 2, bar_height + padding_y / 2), (bar_width + padding_x / 2, (padding_y / 2) - 5)],
        width=5)

    if not any(mask):
        # Draw the mz and tolerance
        scale_legend.text((bar_width + padding_x - padding_x_offset, 80),
                          f"{round(central_mz, 3)} +/- {tolerance} m/Z", font_size=font_size, anchor="rs")

    scale_qt = ImageQt(scale_save)
    if save:
        scale_save.save(f"{export_path_scale}{name}-legend.png", mode="SRGB")
    # scale_save.show()
    return scale_qt

