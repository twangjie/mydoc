# -*- coding: utf-8 -*-
# encoding: utf-8
#
# brightness_contrast.py
#
# 

'''
亮度、对比度调整

算法流程：

调整图像亮度与对比度算法主要由以下几个步骤组成：

1.计算图像的RGB像素均值– M
2.对图像的每个像素点Remove平均值-M
3.对去掉平均值以后的像素点 P乘以对比度系数
4. 对步骤上处理以后的像素P加上 M乘以亮度系统
5. 对像素点RGB值完成重新赋值
'''

import os
import numpy as np
import cv2


window_name = "brightness"

#读入图片，模式为BGR，创建窗口
img = cv2.imread("rgb2.jpg")
cv2.namedWindow(window_name)

cv2.imshow("Original",img)

img = np.array(img)
mean = np.mean(img)
img = img - mean
img = img*5.5 + mean*0.3 #修对比度和亮度

#非常关键，没有会白屏
img = img/255.

cv2.imshow(window_name,img)
if cv2.waitKey(0) == 27:
    cv2.destroyAllWindows()
