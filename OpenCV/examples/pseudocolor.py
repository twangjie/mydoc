#!/usr/bin/env python
# encoding: utf-8

import cv2
import numpy as np
import matplotlib.pyplot as plt

im_bgr = cv2.imread("resframe.jpg", cv2.IMREAD_COLOR)
im_rgb = cv2.cvtColor(im_bgr, cv2.COLOR_BGR2RGB)
im_gray = cv2.cvtColor(im_bgr, cv2.COLOR_BGR2GRAY)
ret, thresh = cv2.threshold(im_gray, 127, 255,cv2.THRESH_BINARY)

titles = [
    'bgr','rgb','gray','binary',
    'COLORMAP_AUTUMN','COLORMAP_BONE','COLORMAP_JET','COLORMAP_WINTER','COLORMAP_RAINBOW','COLORMAP_OCEAN',
    'COLORMAP_SUMMER','COLORMAP_SPRING','COLORMAP_COOL','COLORMAP_HSV','COLORMAP_PINK','COLORMAP_HOT'
]

coloredImgs=[
    cv2.applyColorMap(im_gray, cv2.COLORMAP_AUTUMN),
    cv2.applyColorMap(im_gray, cv2.COLORMAP_BONE),
    cv2.applyColorMap(im_gray, cv2.COLORMAP_JET),
    cv2.applyColorMap(im_gray, cv2.COLORMAP_WINTER),
    cv2.applyColorMap(im_gray, cv2.COLORMAP_RAINBOW),
    cv2.applyColorMap(im_gray, cv2.COLORMAP_OCEAN),
    cv2.applyColorMap(im_gray, cv2.COLORMAP_SUMMER),
    cv2.applyColorMap(im_gray, cv2.COLORMAP_SPRING),
    cv2.applyColorMap(im_gray, cv2.COLORMAP_COOL),
    cv2.applyColorMap(im_gray, cv2.COLORMAP_HSV),
    cv2.applyColorMap(im_gray, cv2.COLORMAP_PINK),
    cv2.applyColorMap(im_gray, cv2.COLORMAP_HOT)
]

images = [im_bgr,im_rgb,im_gray,thresh]
for i in range(12):
    images.append(cv2.cvtColor(coloredImgs[i], cv2.COLOR_BGR2RGB))

for i in range(16):
    plt.subplot(4,4,i+1),plt.imshow(images[i],'gray')
    plt.title(titles[i])
    plt.xticks([]),plt.yticks([])
    
plt.show()

