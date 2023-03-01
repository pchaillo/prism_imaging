import pandas
import numpy
from coloraide import Color
from easygui import *
filename = fileopenbox("Please open the biomap file of interest", title="Biomap to PLY converter", filetypes=["*.biomap"])
biomap = pandas.read_csv(filename, sep=' ', header=None, names=['X','Y','Z','Time','N.A']) #Reads the opened biomap

#Header Generation
vertices = len(biomap)-1
dimX = biomap.iloc[0][1]
dimY = biomap.iloc[0][0]
edges = 2*dimX*dimY-dimX-dimY #See Grid Graphs properties, seems wrong
faces = (dimX-1)*(dimY-1)
faces = int(faces) #Conversion to integer is necessary for PLY files
headertp = "ply\nformat ascii 1.0\nelement vertex ", vertices, "\nproperty float64 x\nproperty float64 y\nproperty float64 z\nproperty uchar red\nproperty uchar green\nproperty uchar blue\nelement face ", faces,"\nproperty list uchar int vertex_indices""\nend_header\n"
header = ""
header = header.join(map(str, headertp))

#Vertices recovery
coords = biomap.iloc[:,0:3]
coordsfinal = coords.drop(0) #Grabs vertices coordinates without the header

#MS info extraction and colouring
intensities = biomap.iloc[:,3]
intensities = intensities.drop(0) #Grabs intensities without the header
intensities = intensities.fillna(0)
imax = max(intensities)
itstlst = []
for i in intensities:
    itstlst.append(int(i)) #Creates a list of intensities converted to integers

#Colours with ColorAide
r1 = integerbox("Pick a low-intensity color RED value between 0 and 255", title="Biomap to PLY converter", lowerbound=0, upperbound=255)
g1 = integerbox("Pick a low-intensity color GREEN value between 0 and 255", title="Biomap to PLY converter", lowerbound=0, upperbound=255)
b1 = integerbox("Pick a low-intensity color BLUE value between 0 and 255", title="Biomap to PLY converter", lowerbound=0, upperbound=255)
r2 = integerbox("Pick a high-intensity color RED value between 0 and 255", title="Biomap to PLY converter", lowerbound=0, upperbound=255)
g2 = integerbox("Pick a high-intensity color GREEN value between 0 and 255", title="Biomap to PLY converter", lowerbound=0, upperbound=255)
b2 = integerbox("Pick a high-intensity color BLUE value between 0 and 255", title="Biomap to PLY converter", lowerbound=0, upperbound=255)
c1 = Color("srgb", [r1/255,g1/255,b1/255])
c2 = Color("srgb",[r2/255,g2/255,b2/255])
col = Color.interpolate([c1,c2],space="srgb")
colours = numpy.zeros(shape=(vertices,3))
rank=0

for i in itstlst:
    hue=col(i/imax)
    colours[rank] = ([hue['r']*255, hue['g']*255, hue['b']*255])
    rank = rank + 1
coloursdf = pandas.DataFrame(colours)
coloursdf = coloursdf.astype(int)

#Faces calculation
vtx = numpy.arange(1, vertices) #Generates a numbered list corresponding to vertices
fcs = numpy.zeros(shape=(vertices,5))
for i in vtx:
    if (i % dimX) != 0 and i + dimX <= vertices and ((i + dimX) % dimX) != 0 and i + dimX + 1 <= vertices:
        #fcs[i - 1] = ([4, i-1, i, i+dimX, i+dimX-1])
        fcs[i - 1] = ([4, i+dimX-1, i+dimX, i, i-1])
fcsdf = pandas.DataFrame(fcs)
fcsdf = fcsdf.astype(int)
fcsdf = fcsdf[fcsdf[0] != 0]

#Export file name recovery
tgtname = ''
rvstgtname = ''
for i in reversed(filename):
    if i != "/":
        rvstgtname = rvstgtname + i
    else:
        break
for i in reversed(rvstgtname):
    tgtname = tgtname + i
tgtname = tgtname.replace("biomap","ply")
with open(tgtname,"w") as plyfile:
    plyfile.write(header)
counter = numpy.arange(1,(vertices+0.5)*2)
countervtx = 0
countercol = 0
for i in counter: #Fills a buffer with either vertices or colours and writes it to target file
    if i%2!=0:
        buffertp = (coordsfinal.iloc[countervtx,0], " ", coordsfinal.iloc[countervtx,1], " ", coordsfinal.iloc[countervtx,2]," \n")
        buffer = ""
        buffer = buffer.join(map(str, buffertp))
        with open(tgtname, "a") as plyfile:
            plyfile.write(buffer)
        countervtx = countervtx + 1
    else:
        buffertp = (coloursdf.iloc[countercol, 0], " ", coloursdf.iloc[countercol, 1], " ", coloursdf.iloc[countercol, 2], " \n")
        buffer = ""
        buffer = buffer.join(map(str, buffertp))
        with open(tgtname, "a") as plyfile:
            plyfile.write(buffer)
        countercol = countercol + 1
fcsdf.to_csv(path_or_buf=tgtname, sep=" ", header=False, index=False, mode="a") #Write faces to target file