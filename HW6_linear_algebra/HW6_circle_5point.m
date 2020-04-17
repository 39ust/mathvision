

pt1 = [0, 1] % ����Ʈ 1 �Է�
pt2 = [1, 0] % ����Ʈ 2 �Է�
pt3 = [2, 1] % ����Ʈ 3 �Է�
pt4 = [1.8, 1.9] % ����Ʈ 4 �Է�
pt5 = [0.5, 1.9] % ����Ʈ 5 �Է�

X = [];

% X = [pt1(1,1), pt1(1,2); pt2(1,1), pt2(1,2); pt3(1,1), pt3(1,2); pt4(1,1), pt4(1,2); pt5(1,1), pt5(1,2)]

syms A B C
eqn1 = pt1(1,1)^2 + pt1(1,2)^2 + pt1(1,1)*A + pt1(1,2)*B + C == 0;
eqn2 = pt2(1,1)^2 + pt2(1,2)^2 + pt2(1,1)*A + pt2(1,2)*B + C == 0;
eqn3 = pt3(1,1)^2 + pt3(1,2)^2 + pt3(1,1)*A + pt3(1,2)*B + C == 0;
eqn4 = pt4(1,1)^2 + pt4(1,2)^2 + pt4(1,1)*A + pt4(1,2)*B + C == 0;
eqn5 = pt5(1,1)^2 + pt5(1,2)^2 + pt5(1,1)*A + pt5(1,2)*B + C == 0;

[A,Y] = equationsToMatrix([eqn1, eqn2, eqn3, eqn4, eqn5], [A, B, C])

% AX=Y
X = pinv(A)*Y

ct = [-(X(1,1)/2), -(X(2,1)/2)]
r = (sqrt(X(1,1)^2 + X(2,1)^2 + (4*X(3,1))) / 2)
    
n = 1000;
point = linspace(0, 2*pi, n);
x = r*cos(point)+ct(1,1)
y = r*sin(point)+ct(1,2)
plot(x, y)



