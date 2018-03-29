#!/usr/bin/env python    
# encoding: utf-8
# findContours.py

import numpy as np
import cv2

img = cv2.imread('resframe.jpg')

# 转换为灰度图
imgray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)

# 二值化
ret,im_bw = cv2.threshold(imgray,127,255,0)

# 查找轮廓
im2, contours, hierarchy = cv2.findContours(im_bw,cv2.RETR_TREE,cv2.CHAIN_APPROX_SIMPLE)

cv2.drawContours(img,contours,-1,(0,0,255),1)
cv2.imshow("im", img)    

cv2.waitKey(0)    