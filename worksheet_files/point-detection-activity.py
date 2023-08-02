import numpy as np
import cv2 as cv
from matplotlib import pyplot as plt
 
# Read the image from disk
img = cv.imread('flower.jpg', cv.IMREAD_GRAYSCALE)
 
# Initiate ORB detector with custom parameters
orb = cv.ORB_create(nfeatures=5000, scoreType=cv.ORB_FAST_SCORE, patchSize=3)
 
# Find the keypoints with ORB
kp = orb.detect(img, None)
 
# Compute the descriptors with ORB
kp, des = orb.compute(img, kp)
 
# Draw only keypoints location, not size and orientation
img_with_keypoints = cv.drawKeypoints(img, kp, None, color=(0, 255, 0), flags=0)
 
# Create a subplot to display both images
plt.figure(figsize=(10, 10))
 
# Display the original grayscale image on the left subplot
plt.subplot(1, 2, 1)
plt.imshow(img, cmap='gray')
plt.title('Original Image')
plt.axis('off')
 
# Display the image with keypoints on the right subplot
plt.subplot(1, 2, 2)
plt.imshow(img_with_keypoints, cmap='gray')
plt.title('Image with Keypoints')
plt.axis('off')
 
# Show the plot with both images
plt.show()
