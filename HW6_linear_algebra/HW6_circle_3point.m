clc
clear all

pt1 = [0, 1] % ����Ʈ 1 �Է�
pt2 = [1, 0] % ����Ʈ 2 �Է�
pt3 = [2, 1] % ����Ʈ 3 �Է�

syms A B C 
eqn1 = pt1(1,1)^2 + pt1(1,2)^2 + pt1(1,1)*A + pt1(1,2)*B + C == 0;
eqn2 = pt2(1,1)^2 + pt2(1,2)^2 + pt2(1,1)*A + pt2(1,2)*B + C == 0;
eqn3 = pt3(1,1)^2 + pt3(1,2)^2 + pt3(1,1)*A + pt3(1,2)*B + C == 0;
[D,F] = equationsToMatrix([eqn1, eqn2, eqn3], [A, B, C])
sol = linsolve(D,F)

ct = [-(sol(1,1)/2), -(sol(2,1)/2)]
r = (sqrt(sol(1,1)^2 + sol(2,1)^2 + (4*sol(3,1))) / 2)
    
n = 1000;
point = linspace(0, 2*pi, n);
x = r*cos(point)+ct(1,1)
y = r*sin(point)+ct(1,2)
plot(x, y)
hold on
axis equal

