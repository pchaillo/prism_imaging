import cv2 as cv
from matplotlib import pyplot as plt
from math import pi
import numpy as np
from picamera2 import Picamera2, Preview
from PIL import Image
import struct
import time

lcol_list = ["red", "green", "blue"] # Three main laser types 

def get_picture(delay = 5, name="test.png"):
	picam = Picamera2()
	config = picam.create_preview_configuration({"size":(1920, 1080)})
	picam.configure(config)
	picam.set_controls({"ExposureTime":33, "AnalogueGain":10.0})
	picam.start(show_preview=True)
	time.sleep(delay)

	image = picam.capture_image()
	image = image.convert("RGB")
	image.save(name)

	picam.close()

def process_saved_picture(image_path, lcol = "red", show=True, debug=False):
	# Inspired by https://github.com/SSSongHuanan/laser-pointer-detection/blob/main/laser-pointer-detection.py
	# Will only support RGB images for now
	
	image = cv.imread(image_path)
	area, roundness, centroid = process_picture(image, "red", show, debug)
	
	return area, roundness, centroid
		
def process_picture(image, lcol="red", show=False, debug=False):
	# Inspired by https://github.com/SSSongHuanan/laser-pointer-detection/blob/main/laser-pointer-detection.py
	# Will only support RGB images for now
	if debug:
		start_time = time.time()
		
	if show:
		image_rgb = cv.cvtColor(image, cv.COLOR_BGR2RGB)
	
	col_dict = {"red":[np.array([0, 100, 100]), 
					   np.array([10, 255, 255]),
					   np.array([160, 100, 100]),
					   np.array([179, 255, 255])],
				"green":[np.array([90, 70, 80]), np.array([145, 100, 100])],
				"green2":[np.array([29, 45, 195]), np.array([45, 255, 255])]
			    }
		
	image = cv.cvtColor(image, cv.COLOR_BGR2HSV)
	image = cv.GaussianBlur(image, (3,3), 0)
	h, s, v = cv.split(image)
	
	if show:
		plt.subplot(131), plt.imshow(h, cmap = "viridis"), plt.title("Hue")
		plt.subplot(132), plt.imshow(s, cmap = "viridis"), plt.title("Saturation")
		plt.subplot(133), plt.imshow(v, cmap = "viridis"), plt.title("Value")
		plt.show()
	
	if lcol not in col_dict.keys():
		raise ValueError("Undefined target colour")
	
	col = col_dict.get(lcol)
	if lcol == "red":
		# Define the color range in HSV space by assembling two spaces due to how HSV is represented
		lower_col1 = np.array([0, 100, 100])
		upper_col1 = np.array([10, 255, 255])
			
		lower_col2 = np.array([160, 100, 100])
		upper_col2 = np.array([179, 255, 255])

		# Create masks for the red color range (handling the circular nature of HSV hue)
		mask1 = cv.inRange(image, lower_col1, upper_col1)
		mask2 = cv.inRange(image, lower_col2, upper_col2)
		mask = cv.bitwise_or(mask1, mask2)
	else:
		lower_col, upper_col = col
		mask = cv.inRange(image, lower_col, upper_col)
		
	contours, _ = cv.findContours(mask, cv.RETR_TREE, cv.CHAIN_APPROX_SIMPLE)
	area, roundness, [cX, cY] = -1, -1, [-1, -1]
		
	if contours:
		# Assume the largest contour is the laser spot
		largest_contour = max(contours, key=cv.contourArea)
		area = cv.contourArea(largest_contour)
            
		if area > 30:
			# Calculate the moments of the contour to get the centroid
			M = cv.moments(largest_contour)
			if M["m00"] != 0:
				cX = int(M["m10"] / M["m00"])
				cY = int(M["m01"] / M["m00"])
				perimeter = cv.arcLength(largest_contour, True)
				roundness = (4*pi*area)/(perimeter**2) # https://en.wikipedia.org/wiki/Roundness 1 = Perfect Circle 
				if debug:
					end_time = time.time() - start_time
					print(f"Execution time: {end_time}s")
				if show:
					for i in range(len(largest_contour)):
						cv.drawContours(image_rgb, largest_contour, i, [255, 255, 0], 4)
					# Draw a circle around the detected laser spot
					# cv.circle(image_rgb, (cX, cY), 15, (0, 0, 255), 2)
					plt.imshow(image_rgb)
					plt.show()
				
	return area, roundness, [cX, cY]

def start_camera_stream(cam:Picamera2):
	# Initialize the camera if none is provided
	if not cam:
		cam = Picamera2()
	config = cam.create_video_configuration()
	cam.configure(config)
	cam.start()	

def process_stream(cam:Picamera2, col:str="red"):
	if not isinstance(cam, Picamera2):
		raise TypeError(f"Unsupported camera object: {type(cam)}")
	# Grab the latest image on the stack
	img = cam.capture_array()
	area, roundness, centroid = process_picture(img, lcol=col, show=False)
	return area, roundness, centroid
	
if __name__ == "__main__":
	tests = ["OnePic", "Video"]
	test = "Video"
	
	if test in tests:
		if test == "OnePic":
			image = r"/home/prism/Documents/Depth_Sensor/test_files/test4.png"
			new_img = "test4.png"
			show = True
			print(process_saved_picture(image, "red", show, False))
			#get_picture(10, new_img)
		elif test == "Video":
			import socket
			
			cam = Picamera2()
			print("Starting server...")
			server = socket.socket()
			server.bind(("192.168.0.5", 5000))
			server.listen(1)
			conn, addr = server.accept()
			print(f"Client connected from {addr}")

			start_camera_stream(cam)
			old_area, old_roundness, old_centroid = -1, -1, [-1, -1]
			MAGIC_BYTE = b'\xFE\xED'

			while True:
				area, roundness, centroid = process_stream(cam, "green2")
				if area is None:
					area, roundness, centroid = old_area, old_roundness, old_centroid
				#print(f"Area: {area}, Roundness: {roundness}, Centroid: {centroid}\n")

				packet = MAGIC_BYTE + struct.pack('<ffii', np.float32(area), np.float32(roundness), np.int32(centroid[0]), np.int32(centroid[1]))
				conn.sendall(packet)

				old_area, old_roundness, old_centroid = area, roundness, centroid
				print(f"{[area, roundness, centroid]}\n") # Helps with debugging
			cam.close()
	else:
		raise ValueError("Select a pre-existent test and try again.")
