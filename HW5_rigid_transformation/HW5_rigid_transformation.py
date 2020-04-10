import numpy as np

# original location
p1 = np.array([-0.500000, 0.000000, 2.121320])
p2 = np.array([0.500000, 0.000000, 2.121320])
p3 = np.array([0.500000, -0.707107, 2.828427])
p4 = np.array([0.500000, 0.707107, 2.828427])
p5 = np.array([1.000000, 1.000000, 1.000000])

# transformed location
p1_prime = np.array([1.363005,-0.427131, 2.339082])
p2_prime = np.array([1.748084, 0.437983, 2.017688])
p3_prime = np.array([2.636461, 0.184843, 2.400710])
p4_prime = np.array([1.498100, 0.871000, 2.883700])
p5_prime = np.array([0, 0, 0])

# Define rotational transform
def rotational_transform(axis: np.ndarray, cos: float):
    sin = np.sqrt(1 - cos ** 2)
    transform = np.asarray([
        [cos + axis[0] ** 2 * (1 - cos), axis[0] * axis[1] * (1 - cos) - axis[2] * sin,
         axis[0] * axis[2] * (1 - cos) + axis[1] * sin],
        [axis[1] * axis[0] * (1 - cos) + axis[2] * sin, cos + axis[1] ** 2 * (1 - cos),
         axis[1] * axis[2] * (1 - cos) - axis[0] * sin],
        [axis[2] * axis[0] * (1 - cos) - axis[1] * sin, axis[2] * axis[1] * (1 - cos) + axis[0] * sin,
         cos + axis[2] ** 2 * (1 - cos)]
    ])
    return transform

# Normal vector h, h_prime
h = np.cross(p2 - p1, p3 - p1)
h_prime = np.cross(p2_prime - p1_prime, p3_prime - p1_prime)

# Rotational Transform R1
u_r1 = (np.cross(h, h_prime)) / np.linalg.norm((np.cross(h, h_prime)))
theta_r1 = np.inner(h, h_prime) / (np.linalg.norm(h) * np.linalg.norm(h_prime))
r1 = rotational_transform(axis = u_r1, cos = theta_r1)

print(r1)

# Rotational Transform R2
u_r2 = h_prime / np.linalg.norm(h_prime)
theta_r2 = np.inner((np.matmul(r1, p1-p3)), p1_prime-p3_prime) / (np.linalg.norm((np.matmul(r1, p1-p3))) * np.linalg.norm(p1_prime-p3_prime))
r2 = rotational_transform(axis= u_r2, cos= theta_r2)

print(r2)

# Verification p4 values
p4_val = np.transpose(np.matmul(np.matmul(r1, np.transpose(p4 - p1)), r2)) + p1_prime

print(p4_val)

# Find p5 values
p5_val = np.transpose(np.matmul(np.matmul(r1, np.transpose(p5 - p1)), r2)) + p1_prime

print(p5_val)