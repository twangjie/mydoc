#!/usr/bin/env python
# encoding: utf-8
# -*- coding: utf-8 -*-


'''
 Based on the following tutorial:
   http://docs.opencv.org/3.0-beta/doc/py_tutorials/py_imgproc/py_histograms/py_histogram_equalization/py_histogram_equalization.html
'''

import numpy as np
import cv2
from matplotlib import pyplot as plt

img = cv2.imread("images/backlight3.jpg")
lab = cv2.cvtColor(img, cv2.COLOR_BGR2LAB)
yuv = cv2.cvtColor(img, cv2.COLOR_BGR2YUV)

# Equalize the image
yuv[:,:,0] = cv2.equalizeHist(yuv[:,:,0])

# Use instead Contrast Limited Adaptive Histogram Equalization (CLAHE)
# 限制对比度自适应直方图均衡，可用于图像去雾
gridsize=8
clahe = cv2.createCLAHE(clipLimit=20.0, tileGridSize=(gridsize, gridsize))
lab[:,:,0] = clahe.apply(lab[:,:,0])

# Display the results
plt.subplot(221)
plt.title('original')
plt.imshow(cv2.cvtColor(img, cv2.COLOR_BGR2RGB))
plt.xticks([])
plt.yticks([])

plt.subplot(222)
plt.title('equalized')
plt.imshow(cv2.cvtColor(yuv, cv2.COLOR_YUV2RGB))
plt.xticks([])
plt.yticks([])

plt.subplot(223)
plt.title('CLAHE')
plt.imshow(cv2.cvtColor(lab, cv2.COLOR_LAB2RGB))
plt.xticks([])
plt.yticks([])

plt.show()