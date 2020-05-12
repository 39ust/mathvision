from os import listdir
from os.path import isdir
import cv2
import numpy as np
from scipy.spatial import distance
from sklearn.decomposition import PCA

def read_gray_image(path: str):
    image = cv2.imread(path, cv2.IMREAD_GRAYSCALE)
    image = image.flatten()
    return image

def classify_faces(pca: PCA, train_faces: np.ndarray, test_faces: np.ndarray):
    train_faces_low = np.matmul(train_faces, pca.components_.T)
    test_faces_low = np.matmul(test_faces, pca.components_.T)
    classifications = []

    for test_face_low in test_faces_low:
        distances = []
        for i in range(num_of_classes):
            # euclidean distance
            euclidean = np.array(
                [np.linalg.norm(test_face_low - train_face_low) for train_face_low in train_faces_low[9 * i:9 * (i + 1), :]]
            ).mean()

            # cosine distance
            cosine = np.array(
               [distance.cosine(test_face_low, train_face_low) for train_face_low in train_faces_low[9 * i:9 * (i + 1), :]]
            ).mean()

            # manhattan distace
            manhattan = np.array(
               [distance.cityblock(test_face_low, train_face_low) for train_face_low in train_faces_low[9 * i:9 * (i + 1), :]]
            ).mean()

            # minkowski distance
            Minkowski = np.array(
               [distance.minkowski(test_face_low, train_face_low) for train_face_low in train_faces_low[9 * i:9 * (i + 1), :]]
            ).mean()

            distances.append(euclidean)

        classifications.append(np.argmin(distances))

    corrects = sum([1 if i == c else 0 for i, c in enumerate(classifications)])
    accuracy = corrects / len(classifications)

    return classifications, accuracy

if __name__ == '__main__':
    num_of_classes = 40
    root_dir = './data/att_faces/'
    train_dir = root_dir + 'train/'
    test_dir = root_dir + 'test/'
    faces = []

    for i in range(num_of_classes):
        class_dir = train_dir + '{}/'.format(i + 1)
        for filename in listdir(class_dir):
            filepath = class_dir + filename
            if isdir(filepath):
                continue
            image = cv2.imread(filepath, cv2.IMREAD_GRAYSCALE)
            face = image.flatten()
            faces.append(face)

    faces = np.array(faces)

    num_of_eigenfaces = [1, 10, 100, 200]
    pca = {}

    for k in num_of_eigenfaces:
        pca[k] = PCA(n_components=k)
        pca[k].fit(faces)


    test_face = image.flatten()
    reconstructions = {}

    for k in pca:
        test_face_low = np.matmul(test_face, pca[k].components_.T)
        reconstruction = np.matmul(test_face_low, pca[k].components_)
        reconstructions[k] = reconstruction

    test_faces = []

    for i in range(num_of_classes):
        filepath = test_dir + 's{}_1.png'.format(i + 1)
        image = cv2.imread(filepath, cv2.IMREAD_GRAYSCALE)
        test_face = image.flatten()
        test_faces.append(test_face)
    test_faces = np.array(test_faces)

    for k in pca:
        _, accuracy = classify_faces(pca=pca[k], train_faces=faces, test_faces=test_faces)
        print('k={}, accuracy = {}.'.format(k, accuracy))

    my_face = [read_gray_image('my_face.jpg')]
    my_face = np.array(my_face)
    pca = PCA(n_components=1)
    pca.fit(faces)

    classifications, _ = classify_faces(pca=pca, train_faces=faces, test_faces=my_face)
    print('my faces classification results: {}'.format(classifications))