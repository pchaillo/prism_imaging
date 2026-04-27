from coloraide import Color
from PIL import Image
import numpy as np
from tkinter import ttk
import tkinter

# Tkinter Interface for colour gathering

gui = tkinter.Tk()
gui.title("Colour Scale Exporter")
gui.resizable(False, False)
frm = ttk.Frame(gui, padding=10, height=180, width=180)
frm.grid()

ttk.Label(frm, text="Choose your gradient:").place(x=0, y=0)
col_box = ttk.Combobox(frm, state='readonly',
                   values=('Viridian', 'Fusion', 'Halloween', 'Easter', 'Magic', 'Rainbow'),
                   width=13)
col_box.place(x=30, y=30)
col_box.set('Viridian')


def set_gradient_type():
    global gradient_type
    gradient_type = col_box.get()


col_box.bind('<<ComboboxSelected>>', set_gradient_type())

ttk.Label(frm, text="Choose your interpolation:").place(x=0, y=70)
cb2 = ttk.Combobox(frm, state='readonly',
                   values=('linear', 'natural', 'bspline', 'continuous', 'monotone'),
                   width=13)
cb2.place(x=30, y=100)
cb2.set('linear')


def set_itp_type():
    global itp_type
    itp_type = cb2.get()


cb2.bind('<<ComboboxSelected>>', set_itp_type())
ttk.Button(frm, text="Proceed", command=lambda: [set_gradient_type(), set_itp_type(), gui.destroy()]).place(x=55, y=140)
gui.mainloop()
#####

width = 2500
height = 100

colours_dict = {"Viridian": [Color("srgb", [0, 0.25, 1]), Color("srgb", [1, 0.7, 0]), Color("srgb", [0, 1, 0])],
                "Fusion": [Color("srgb", [1, 1, 0]), Color("srgb", [0, 0.25, 1]), Color("srgb", [1, 0, 0])],
                "Halloween": [Color("srgb", [1, 0.4, 0]), Color("srgb", [0.2, 0.1, 0.8]), Color("srgb", [0.3, 1, 0.2])],
                "Easter": [Color("srgb", [0, 0, 1]), Color("srgb", [1, 0.6, 0.8]), Color("srgb", [1, 0.6, 0])],
                "Magic": [Color("srgb", [0.2, 0.1, 0.66]), Color("srgb", [0, 1, 0]), Color("srgb", [1, 0.8, 0])],
                "Rainbow": [Color("srgb", [0, 0, 0]), Color("srgb", [0.9, 0, 0.9]), Color("srgb", [0, 0, 1]),
                            Color("srgb", [1, 0, 0]), Color("srgb", [0, 1, 0]), Color("srgb", [0.8, 0.8, 1])]}
# We could potentially bake the interpolation type into the colours dictionary
# Viridian works with: Linear, Bspline, Continuous
# Fusion works with: Linear, Bspline, Continuous
# Halloween works with: Linear, Bspline, Continuous
# Easter works with: Linear, Bspline, Continuous
# Magic works with: Linear, Bspline, Continuous, Monotone

colours = colours_dict.get(gradient_type)
gradient = Color.interpolate(colours, space='oklab', method=itp_type)

scale = np.zeros((height, width, 3))
rank_list = np.arange(0, width)
for rank in rank_list:  # Replace with a list of ranks that ranges from 0 to 255 (see numpy.range)
    current_colour = Color.convert(gradient(rank/width), "srgb")
    # current_colour = gradient(rank/width)
    scale[:, rank, 0] = current_colour[0] * 255
    scale[:, rank, 1] = current_colour[1] * 255
    scale[:, rank, 2] = current_colour[2] * 255

# scale = scale.astype(int)

scale_save = Image.fromarray(scale.astype('uint8'))
scale_save.save('3d_export/colour_scale/' + gradient_type + '-' + itp_type + '.png', mode="SRGB")

print('The colour scale was successfully saved in 3d_export/colour_scale/')
