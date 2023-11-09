import numpy as np
import pandas as pd
import plotly.graph_objs as go
import dash
from dash import dcc
from dash import html
from dash.dependencies import Input, Output, State

points_nb = 50
test_matrix = pd.DataFrame()
test_matrix[1] = np.random.rand(points_nb)
test_matrix[2] = np.random.rand(points_nb)
test_matrix[3] = np.random.randn(points_nb)
initial_colours = ['rgba(50, 30, 230, 0.8)'] * len(test_matrix[1])
##################DASH######################

app = dash.Dash(__name__)

app.layout = html.Div([
    dcc.Graph(
        id='3d_scat',
        figure={
            'data': [
                go.Scatter3d(
                    x=test_matrix[1],
                    y=test_matrix[2],
                    z=test_matrix[3],
                    mode='markers',
                    marker=dict(
                        size=12,
                        line=dict(
                            color=initial_colours,
                            width=0.5
                        ),
                        opacity=0.8
                    )
                )
            ],
            'layout': go.Layout(
                margin=dict(
                    l=0,
                    r=0,
                    b=0,
                    t=0
                )
            )
        }
    ),
    html.Pre(id='click-data', style={'padding': '10px'}),
    dcc.Store(id='store-points'),
    dcc.Store(id='store-colors', data=initial_colours)
])

@app.callback(
    [Output('store-points', 'data'), Output('store-colors', 'data')],
    [Input('3d_scat', 'clickData')],
    [State('store-points', 'data'), State('store-colors', 'data')])
def update_store(clickData, points, colours):
    if clickData is None:
        return [], colours
    else:
        point_number = clickData['points'][0]['pointNumber']
        if points is None:
            points = []  # Initialize points list
        if point_number not in points:
            points.append(point_number)
            colours[point_number] = 'rgba(165, 95, 250, 0.8)'  # Changes the colour of the clicked point
        return points, colours

@app.callback(
    Output('3d_scat', 'figure'),
    [Input('store-colors', 'data')],
    [State('3d_scat', 'figure')])
def update_colours(data, figure):  # Updates the figure dictionary to change the appearance of the plot
    figure['data'][0]['marker']['color'] = data
    return figure


@app.callback(
    Output('click-data', 'children'),
    [Input('store-points', 'data')])
def display_click_data(data):
    if data is None:
        return 'Click on the plot to see the point ID.'
    else:
        return f'You clicked on point IDs: {data}'

if __name__ == '__main__':
    app.run_server(debug=True)
