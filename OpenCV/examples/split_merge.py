#!/usr/bin/env python    
# encoding: utf-8    
  
import cv2    
import numpy as np    
  
image = cv2.imread("resframe.jpg",cv2.IMREAD_COLOR)
imageRGB = cv2.cvtColor(image, cv2.COLOR_BGR2RGB) 

cv2.imshow("Original", image)
cv2.imshow("RGB", imageRGB)

# 通道分离，注意顺序是BGR
(B, G, R) = cv2.split(image)

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

# 生成一个值为0的单通道数组
zeros = np.zeros(image.shape[:2], dtype = "uint8")

# 合并三个通道
cv2.imshow("Merged", cv2.merge([B, G, R]))

cv2.waitKey(0)