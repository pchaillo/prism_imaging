import numpy as np
import pandas as pd
import plotly.graph_objs as go
import dash
from dash import dcc
from dash import html
from dash.dependencies import Input, Output, State
from dash_extensions import EventListener


#points_nb = 50
#test_matrix = pd.DataFrame()
#test_matrix[1] = np.random.rand(points_nb)
#test_matrix[2] = np.random.rand(points_nb)
#test_matrix[3] = np.random.randn(points_nb)

test_matrix = pd.read_csv("Rock_trim_norm.csv", sep=" ")
test_matrix = test_matrix.loc[:, ["X", "Y", "Z"]]
test_matrix.columns = [1, 2, 3]

initial_colours = ['rgba(50, 30, 230, 0.8)'] * len(test_matrix[1])

focal = 80  # Robot arm referential-dependent, values in mm for our purposes
initial_x = 150
initial_y = 0
initial_z = 0 + focal  # Currently assumes that the first point is on ground level

# Functions

# Calculate the euclidian distance in n-space of the route r traversing cities c, ending at the path start.
path_distance = lambda r, c: np.sum([np.linalg.norm(c[r[p + 1]] - c[r[p]]) for p in range(len(r) - 1)])
# Reverse the order of all elements from element i to element k in array r.
two_opt_swap = lambda r, i, k: np.concatenate((r[0:i], r[k:-len(r) + i - 1:-1], r[k + 1:len(r)]))

def two_opt(cities, improvement_threshold):  # 2-opt Algorithm adapted from https://en.wikipedia.org/wiki/2-opt
    route = np.arange(cities.shape[0])  # Make an array of row numbers corresponding to cities.
    improvement_factor = 1  # Initialize the improvement factor.
    best_distance = path_distance(route, cities)  # Calculate the distance of the initial path.
    while improvement_factor > improvement_threshold:  # If the route is still improving, keep going!
        distance_to_beat = best_distance  # Record the distance at the beginning of the loop.
        for swap_first in range(1, len(route) - 2):  # From each city except the first and last,
            for swap_last in range(swap_first + 1, len(route)):  # to each of the cities following,
                new_route = two_opt_swap(route, swap_first, swap_last)  # try reversing the order of these cities
                new_distance = path_distance(new_route, cities)  # and check the total distance with this modification.
                if new_distance < best_distance:  # If the path distance is an improvement,
                    route = new_route  # make this the accepted best route
                    best_distance = new_distance  # and update the distance corresponding to this route.
            improvement_factor = 1 - best_distance / distance_to_beat  # Calculate how much the route has improved.
    return route  # When the route is no longer improving substantially, stop searching and return the route.


##################DASH######################

app = dash.Dash(__name__)

keydown_event = EventListener(id='keydown_event', events=[{"event": "keydown", "props": ["key"]}])
keyup_event = EventListener(id="keyup_event", events=[{"event": "keyup", "props": ["key"]}])

app.layout = html.Div([
    html.H1(children='LClick: Select point\nW: Reset selection\nS: Save and export selection'),
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
    dcc.Store(id='store-colors', data=initial_colours),
    dcc.Store(id='store_pos'),
    dcc.Store(id='convert-ref'),
    html.Pre(id='keydown-data', style={'padding': '10px'}),
    keydown_event,
    keyup_event
])


@app.callback(
    [Output('store-points', 'data'), Output('store-colors', 'data')],
    [Input('3d_scat', 'clickData'), Input('keydown_event', 'event')],
    [State('store-points', 'data'), State('store-colors', 'data')])
def update_store(clickData, event, points, colours):
    triggered_id = dash.ctx.triggered_id
    if clickData is None:
        return [], colours
    elif triggered_id == '3d_scat':
        point_number = clickData['points'][0]['pointNumber']
        if points is None:
            points = []  # Initialize points list
        elif point_number in points:
            raise dash.exceptions.PreventUpdate
        elif len(points) == 0:
            points.append(point_number)
            colours[point_number] = 'rgba(165, 95, 250, 0.8)'  # Changes the colour of the clicked point
        elif len(points) == 1:
            points.append(point_number)
            colours[point_number] = 'rgba(120, 180, 130, 0.8)'
        elif len(points) == 2:
            points.append(point_number)
            colours[point_number] = 'rgba(85, 210, 180, 0.8)'
        else:
            print('Three points have already been selected. Please undo your selection if you wish to pick another point.')
            raise dash.exceptions.PreventUpdate
        return points, colours
    elif triggered_id == 'keydown_event':
        if event is None:
            raise dash.exceptions.PreventUpdate
        if event.get('key') == 'w':
            points = []
            colours = initial_colours
            return points, colours
    else:
        raise dash.exceptions.PreventUpdate


@app.callback(
    Output('3d_scat', 'figure'),
    [Input('store-colors', 'data'), Input('keydown_event', 'event')],
    [State('3d_scat', 'figure')])
def update_colours(data, event, figure):  # Updates the figure dictionary to change the appearance of the plot
    triggered_id = dash.ctx.triggered_id
    if triggered_id == 'store-colors':
        figure['data'][0]['marker']['color'] = data
    elif triggered_id == 'keydown_event':
        if event is None:
            raise dash.exceptions.PreventUpdate  # Unaltered figure in case keydown event is flushed
        if event.get('key') == 'w':
            figure['data'][0]['marker']['color'] = initial_colours
    else:
        raise dash.exceptions.PreventUpdate
    return figure


@app.callback(
    Output('click-data', 'children'),
    [Input('store-points', 'data')])
def display_click_data(data):
    if data is None:
        return 'Click on the plot to see the point ID.'
    else:
        return f'You clicked on point IDs: {data}'


@app.callback(
    Output('store_pos', 'data'),
    [Input('keydown_event', 'event')],
    [State('store-points', 'data')])
def compute_route(event, data):
    if event is None:
        raise dash.exceptions.PreventUpdate
    if event.get('key') == 's':
        print("Starting point successfully obtained! Now computing the shortest path.")
        points_matrix = test_matrix.copy()
        point_start = points_matrix.iloc[data, :]
        points_matrix.drop(data[0], axis=0, inplace=True)
        points_matrix = pd.concat([point_start, points_matrix], axis=0)
        points_matrix.reset_index(inplace=True)
        points_array = points_matrix.iloc[:, 1:4].to_numpy()

        route = two_opt(points_array, improvement_threshold=0.01)

        points_ordered = points_matrix.copy()
        n = 0
        for point in route:
            points_ordered.iloc[n] = points_matrix.loc[point]
            n += 1
        points_ordered.drop('index', axis=1, inplace=True)
        points_ordered = points_ordered * 1000  # Converts coordinates from meters to mm
        print("Path computed! Now matching to robot referential.")

        factor_x = points_ordered.iloc[0, 0] - initial_x
        factor_y = points_ordered.iloc[0, 1] - initial_y
        factor_z = points_ordered.iloc[0, 2] - initial_z
        norm = [factor_x, factor_y, factor_z]
        refmatch_data = points_ordered - norm

        return refmatch_data
    else:
        # print(event, ' Non-S input or something weird happened')  # debug
        raise dash.exceptions.PreventUpdate


@app.callback(
    [Output('keydown-data', 'children'), Output('keydown_event', 'event'), Output('keyup_event', 'event')],
    [Input('keyup_event', 'event')])
def flush_keydown(event):
    if event is None:
        sentence = 'No keydown event recorded yet'
        return sentence, dash.no_update, None
    else:
        sentence = ('Keydown event is: ' + event.get('key'))
        return sentence, None, None


if __name__ == '__main__':
    app.run_server(debug=True)


