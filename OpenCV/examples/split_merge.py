#!/usr/bin/env python
# encoding: utf-8
  
import cv2
import numpy as np
  
image = cv2.imread("resframe.jpg",cv2.IMREAD_COLOR)

cv2.imshow("Original(BGR)", image)

# 通道分离，注意顺序是BGR
# (B, G, R) = cv2.split(image)
# 通过索引方式分离
B = image[:,:,0]
G = image[:,:,1]
R = image[:,:,2]

# 显示各个分离出的通道
cv2.imshow("Red - single", R)
cv2.imshow("Green - single", G)
cv2.imshow("Blue - single", B)

# 生成一个值为0的单通道数组
zeros = np.zeros(image.shape[:2], dtype = "uint8")

# 分别扩展B、G、R成为三通道。另外两个通道用上面的值为0的数组填充
cv2.imshow("Blue", cv2.merge([B, zeros, zeros]))
cv2.imshow("Green", cv2.merge([zeros, G, zeros]))
cv2.imshow("Red", cv2.merge([zeros, zeros, R]))

# 合并RGB三个通道
cv2.imshow("Merged(B,G,R)", cv2.merge([B, G, R]))

# Convert BGR to HSV
imageHSV = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
# (h,s,v) = cv2.split(imageHSV)
# 通过索引方式分离
h = imageHSV[:,:,0]
s = imageHSV[:,:,1]
v = imageHSV[:,:,2]

# 显示各个分离出的通道HSV
#hh=h.copy()
# hh.fill(255)
ss=s.copy()
ss.fill(255)
vv=v.copy()
vv.fill(255)

cv2.imshow("Hue", cv2.cvtColor(cv2.merge([h, ss, vv]), cv2.COLOR_HSV2BGR))
cv2.imshow("Saturation", s)
cv2.imshow("Value", v)
#cv2.imshow("Saturation", cv2.cvtColor(cv2.merge([hh, s, vv]), cv2.COLOR_HSV2BGR))
#cv2.imshow("Value", cv2.cvtColor(cv2.merge([hh, ss, v]), cv2.COLOR_HSV2BGR))

cv2.imshow("Merged(H,S,V)", cv2.cvtColor(cv2.merge([h, s, v]), cv2.COLOR_HSV2BGR))

cv2.waitKey(0)
