

pt1 = [0, 1] % 포인트 1 입력
pt2 = [1, 0] % 포인트 2 입력
pt3 = [2, 1] % 포인트 3 입력
pt4 = [1.8, 1.9] % 포인트 4 입력
pt5 = [0.5, 1.9] % 포인트 5 입력

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



