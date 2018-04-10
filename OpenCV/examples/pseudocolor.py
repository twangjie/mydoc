#!/usr/bin/env python
# encoding: utf-8

import cv2
import numpy as np

im_ori = cv2.imread("resframe.jpg", cv2.IMREAD_COLOR)
im_gray = cv2.imread("resframe.jpg", cv2.IMREAD_GRAYSCALE)
cv2.imshow("Original", im_ori)
cv2.imshow("gray", im_gray)

cv2.imshow("COLORMAP_AUTUMN", cv2.applyColorMap(im_gray, cv2.COLORMAP_AUTUMN))
cv2.imshow("COLORMAP_BONE", cv2.applyColorMap(im_gray, cv2.COLORMAP_BONE))
cv2.imshow("COLORMAP_JET", cv2.applyColorMap(im_gray, cv2.COLORMAP_JET))
cv2.imshow("COLORMAP_WINTER", cv2.applyColorMap(im_gray, cv2.COLORMAP_WINTER))
cv2.imshow("COLORMAP_RAINBOW", cv2.applyColorMap(im_gray, cv2.COLORMAP_RAINBOW))
cv2.imshow("COLORMAP_OCEAN", cv2.applyColorMap(im_gray, cv2.COLORMAP_OCEAN))
cv2.imshow("COLORMAP_SUMMER", cv2.applyColorMap(im_gray, cv2.COLORMAP_SUMMER))
cv2.imshow("COLORMAP_SPRING", cv2.applyColorMap(im_gray, cv2.COLORMAP_SPRING))
cv2.imshow("COLORMAP_COOL", cv2.applyColorMap(im_gray, cv2.COLORMAP_COOL))
cv2.imshow("COLORMAP_HSV", cv2.applyColorMap(im_gray, cv2.COLORMAP_HSV))
cv2.imshow("COLORMAP_PINK", cv2.applyColorMap(im_gray, cv2.COLORMAP_PINK))
cv2.imshow("COLORMAP_HOT", cv2.applyColorMap(im_gray, cv2.COLORMAP_HOT))


cv2.waitKey(0)
