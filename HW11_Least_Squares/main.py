import cv2
import numpy as np
from matplotlib import pyplot as plt

img = cv2.imread('hw11_sample.png', cv2.IMREAD_GRAYSCALE)

ret, thresh1 = cv2.threshold(img,127,255, cv2.THRESH_BINARY)
ret, thresh2 = cv2.threshold(img,127,255, cv2.THRESH_BINARY_INV)
ret, thresh3 = cv2.threshold(img,127,255, cv2.THRESH_TRUNC)
ret, thresh4 = cv2.threshold(img,127,255, cv2.THRESH_TOZERO)
ret, thresh5 = cv2.threshold(img,127,255, cv2.THRESH_TOZERO_INV)

titles =['Original','BINARY','BINARY_INV','TRUNC','TOZERO','TOZERO_INV']
images = [img,thresh1,thresh2,thresh3,thresh4,thresh5]

for i in range(6):
	plt.subplot(2,3,i+1),plt.imshow(images[i],'gray')
	plt.title(titles[i])
	plt.xticks([]),plt.yticks([])

plt.show()

A = []
B = []
for y in range(img.shape[0]):
    for x in range(img.shape[1]):
        a = [x * x, y * y, x * y, x, y, 1]
        b = img[y][x]
        A.append(a)
        B.append(b)

A_inv = np.linalg.pinv(A)
coef = np.matmul(A_inv, B)
a, b, c, d, e, f = coef

print(coef)


img_b = np.zeros(img.shape)
for y in range(img.shape[0]):
    for x in range(img.shape[1]):
        img_b[y][x] += a * x * x + b * y * y + c * x * y + d * x + e * y + f


img_n = img - img_b
plt.imshow(img, cmap=plt.get_cmap('gray'))
plt.show()
plt.imshow(img_b, cmap=plt.get_cmap('gray'))
plt.show()
plt.imshow(img_n, cmap=plt.get_cmap('gray'))
plt.show()

ret, thresh1 = cv2.threshold(img_n,-5,255, cv2.THRESH_BINARY)
ret, thresh2 = cv2.threshold(img_n,-5,255, cv2.THRESH_BINARY_INV)
ret, thresh3 = cv2.threshold(img_n,-10,255, cv2.THRESH_TRUNC)
ret, thresh4 = cv2.threshold(img_n,-10,255, cv2.THRESH_TOZERO)
ret, thresh5 = cv2.threshold(img_n,-10,255, cv2.THRESH_TOZERO_INV)

titles =['Remove background','BINARY(-5)','BINARY_INV(-5)','TRUNC(-10)','TOZERO(-10)','TOZERO_INV(-10)']
images = [img_n,thresh1,thresh2,thresh3,thresh4,thresh5]

for i in range(6):
	plt.subplot(2,3,i+1),plt.imshow(images[i],'gray')
	plt.title(titles[i])
	plt.xticks([]),plt.yticks([])

plt.show()

ret, th1 = cv2.threshold(img,127,255,cv2.THRESH_BINARY)
th2 = cv2.adaptiveThreshold(img,255,cv2.ADAPTIVE_THRESH_MEAN_C,\
cv2.THRESH_BINARY,15,2)
th3 = cv2.adaptiveThreshold(img,255,cv2.ADAPTIVE_THRESH_GAUSSIAN_C,\
cv2.THRESH_BINARY,15,2)

titles = ['Original','Global','Mean','Gaussian']

images = [img,th1,th2,th3]

for i in range(4):
	plt.subplot(2,2,i+1),plt.imshow(images[i],'gray')
	plt.title(titles[i])
	plt.xticks([]),plt.yticks([])

plt.show()