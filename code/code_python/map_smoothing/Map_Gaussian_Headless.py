# Validated on Python 3.8.11
# To run manually through MatLab:
#   path(path, 'code/code_python')
#   pyrunfile('#SCRIPT_NAME#.py')



from matplotlib import pyplot as plt
import copy
import os
import pandas as pd
from scipy.ndimage import gaussian_filter
import sys
sys.path.insert(0, os.getcwd() + "\code\code_python") # Needed so that MatLab can actually find the dependency
from utils.utils import file_name_recovery


filename = sys.argv[1]

map_file = pd.read_csv(filename, sep=' ', index_col=None, header=None, low_memory=False)  # Reads the opened map

map_file = map_file.drop(4, axis=1)

coordinates = copy.copy(map_file.iloc[1:, :3])

#fig = plt.figure()
#ax1 = fig.add_subplot(projection='3d')
#ax1.scatter(coordinates.loc["x"], coordinates.loc["y"], coordinates.loc["z"])

coordinates_processed = coordinates.pivot(index=0, columns=1, values=2)

coordinates_smoothed = gaussian_filter(coordinates_processed, sigma=1)
coordinates_smoothed = coordinates_smoothed.ravel()
map_export = copy.copy(map_file)
map_export.iloc[1:, 2] = coordinates_smoothed

#coordinates_smoothed = pd.DataFrame(coordinates_smoothed).T
#coordinates_smoothed.columns = np.arange(2, len(head.loc['x']) + 2)


#ax2 = fig.add_subplot(projection='3d')
#ax2.scatter(coordinates.loc["x"], coordinates.loc["y"], coordinates_smoothed)
#plt.show()

# Export the TIC-normalized data
in_filename, in_filename_ext, project = file_name_recovery(filepath=filename)
tgtname = sys.argv[2]
map_export.to_csv(path_or_buf=(f"files/{project}/map_files/{tgtname}"), index=False, header=False)

print(f"{tgtname} was properly saved in files/{project}/map files/")
