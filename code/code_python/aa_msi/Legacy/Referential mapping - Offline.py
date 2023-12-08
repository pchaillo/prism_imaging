import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import plotly.graph_objs as go

test_matrix = pd.DataFrame()
test_matrix[1] = np.random.rand(50)
test_matrix[2] = np.random.rand(50)
test_matrix[3] = np.random.randn(50)


def onclick():
    print('Click')


def display_pcd_mpl(pcd):  # Limited use for 3D plots, 3D focused libraries like plotly or mayavi are advised
    fig = plt.figure()
    ax = fig.add_subplot(projection='3d')

    fig.canvas.mpl_connect('button_press_event', onclick)


    ax.scatter(pcd[1], pcd[2], pcd[3])
    plt.title("Q = Select\n S = Save\nW = Wipe points")

    print("Displaying the plot.")
    plt.show()


def display_pcd(pcd):
    trace = go.Scatter3d(
        x=pcd[1],
        y=pcd[2],
        z=pcd[3],
        mode='markers',
        marker=dict(
            size=12,
            line=dict(
                color='rgba(217, 217, 217, 0.14)',
                width=0.5
            ),
            opacity=0.8
        )
    )

    trace.on_click(callback=onclick())

    data = [trace]
    layout = go.Layout(
        margin=dict(
            l=0,
            r=0,
            b=0,
            t=0
        )
    )

    fig = go.Figure(data=data, layout=layout)
    fig.show()

