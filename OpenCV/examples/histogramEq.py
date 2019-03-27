#!/usr/bin/env python
# encoding: utf-8
# -*-  coding: utf-8 -*-  

'''
https://blog.csdn.net/sunny2038/article/details/9403059

对于曝光过度或者逆光拍摄的图片可以通过直方图均衡化来进行处理用来增强局部或整体的对比度。
具体思路是通过找出图像中最亮和最暗的像素值将之映射到纯黑和纯白之后再将其他的像数值按某种算法映射到纯黑纯白之间的值。
而对于彩图可以将各个颜色通道分开处理然后再合并到一起。

'''

#coding=utf-8  
import cv2  
import numpy as np
import matplotlib.pyplot as plt

def hisEqulYCrCb(img):
    ycrcb = cv2.cvtColor(img, cv2.COLOR_BGR2YCR_CB)
    '''
    channels = cv2.split(ycrcb)
    cv2.equalizeHist(channels[0], channels[0])
    cv2.merge(channels, ycrcb)
    '''
    ycrcb[:,:,0] = cv2.equalizeHist(ycrcb[:,:,0])
    
    #img = cv2.cvtColor(ycrcb, cv2.COLOR_YCR_CB2BGR)
    return ycrcb


def hisEqulYUV(img):
    img_yuv  = cv2.cvtColor(img, cv2.COLOR_BGR2YUV)
   
    # equalize the histogram of the Y channel
    img_yuv[:,:,0] = cv2.equalizeHist(img_yuv[:,:,0])
       
    # convert the YUV image back to RGB format
    #img = cv2.cvtColor(img_yuv, cv2.COLOR_YUV2BGR)
    
    return img_yuv
    
def histEqulRGB(img):

    imgRGB  = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    for c in xrange(0, 2):
       imgRGB[:,:,c] = cv2.equalizeHist(imgRGB[:,:,c])

    return imgRGB

im = cv2.imread("images/backlight.jpg")  

retYCrCb=hisEqulYCrCb(im)
retYUV=hisEqulYUV(im)
retRGB=histEqulRGB(im)

'''

im_gray=cv2.cvtColor(im, cv2.COLOR_BGR2GRAY)
equ = cv2.equalizeHist(im_gray)
res = np.hstack((im_gray,equ))
cv2.imshow('hstack', res)

cv2.imshow('Original', im)
cv2.imshow('hisEqulYCrCb',hisEqulYCrCb(im))
cv2.imshow('hisEqulYUV',hisEqulYUV(im))
cv2.imshow('histEqulRGB',histEqulRGB(im))
'''

plt.figure()
plt.subplot(221),plt.imshow(cv2.cvtColor(im, cv2.COLOR_BGR2RGB))
plt.title('Original')

plt.subplot(222),plt.imshow(cv2.cvtColor(retYCrCb, cv2.COLOR_YCR_CB2RGB))
plt.title('hisEqulYCrCb')

plt.subplot(223),plt.imshow(cv2.cvtColor(retYUV, cv2.COLOR_YUV2RGB))
plt.title('hisEqulYUV')

plt.subplot(224),plt.imshow(retRGB)
plt.title('histEqulRGB')

plt.show()