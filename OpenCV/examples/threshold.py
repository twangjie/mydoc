#!/usr/bin/env python
# encoding: utf-8

# https://blog.csdn.net/on2way/article/details/46812121

import cv2
import matplotlib.pyplot as plt

#直接读为灰度图像
img = cv2.imread('resframe.jpg',cv2.IMREAD_GRAYSCALE)

ret,thresh1 = cv2.threshold(img,127,255,cv2.THRESH_BINARY)
ret,thresh2 = cv2.threshold(img,127,255,cv2.THRESH_BINARY_INV)
ret,thresh3 = cv2.threshold(img,127,255,cv2.THRESH_TRUNC)
ret,thresh4 = cv2.threshold(img,127,255,cv2.THRESH_TOZERO)
ret,thresh5 = cv2.threshold(img,127,255,cv2.THRESH_TOZERO_INV)

plt.figure()
titles = ['Gray Image','BINARY','BINARY_INV','TRUNC','TOZERO','TOZERO_INV']
images = [img,thresh1,thresh2,thresh3,thresh4,thresh5]
for i in range(6):
    plt.subplot(2,3,i+1),plt.imshow(images[i],'gray')
    plt.title(titles[i])
    plt.xticks([]),plt.yticks([])
# plt.show()


#简单滤波
ret1,th1 = cv2.threshold(img,80,255,cv2.THRESH_BINARY)

#Otsu 滤波
ret2,th2 = cv2.threshold(img,0,255,cv2.THRESH_BINARY + cv2.THRESH_OTSU)

print "OTSU threshold: ",ret2

plt.figure()
plt.subplot(221),plt.imshow(img,'gray')
plt.subplot(222),plt.hist(img.ravel(),256)#.ravel方法将矩阵转化为一维
plt.subplot(223),plt.imshow(th1,'gray')
plt.subplot(224),plt.imshow(th2,'gray')

plt.show()

