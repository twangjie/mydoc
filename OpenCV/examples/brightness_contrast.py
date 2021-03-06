# -*- coding: utf-8 -*-
# encoding: utf-8
#
# brightness_contrast.py

# 亮度、对比度调整

import cv2
import numpy as np

window_name = "brightness"

#读入图片，模式为BGR，创建窗口
img = cv2.imread("resframe.jpg")
cv2.namedWindow(window_name)

cv2.imshow("Original",img)

#convert it to hsv
hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
#h, s, v = cv2.split(hsv)

def increase_brightness(increase):
    hsvCopy = hsv.copy()

    v = hsvCopy[:,:,2]
    v = np.where(v <= 255 - increase, v + increase, 255)
    hsvCopy[:,:,2] = v
    
    img = cv2.cvtColor(hsvCopy, cv2.COLOR_HSV2BGR)
    cv2.imshow(window_name,img)

# 算法来源：https://stackoverflow.com/questions/39308030/how-do-i-increase-the-contrast-of-an-image-in-python-opencv
def increase_contrast(increase):
    hsvCopy = hsv.copy()
    hsvCopy[:,:,2] = [[max(pixel - increase, 0) if pixel < 190 else min(pixel + increase, 255) for pixel in row] for row in hsvCopy[:,:,2]]
    cv2.imshow(window_name, cv2.cvtColor(hsvCopy, cv2.COLOR_HSV2BGR))


#创建滑动条
cv2.createTrackbar("brightness", window_name,0, 255, increase_brightness)
cv2.createTrackbar("contrast", window_name,-100, 100, increase_contrast)

cv2.imshow(window_name,img)

if cv2.waitKey(0) == 27:
    cv2.destroyAllWindows()