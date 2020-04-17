clc
clear all
close all

pt1 = [-5, 3] % 포인트 1 입력
pt2 = [-1, 7] % 포인트 2 입력
pt3 = [3, 5] % 포인트 3 입력
pt4 = [5, -4] % 포인트 4 입력

X_blank = [];
X_blank = [pt1(1,1), pt1(1,2); pt2(1,1), pt2(1,2); pt3(1,1), pt3(1,2); pt4(1,1), pt4(1,2);]

A = [X_blank(:,1).^2 X_blank(:,1).* X_blank(:,2) X_blank(:,2).^2 X_blank(:,1) X_blank(:,2) ones(4,1)]
[U, S, V] = svd(A)
x = V(:,end)

ct_y = (-x(4)/x(1) + 2*x(5)/x(2))/(-4*x(3)/x(2) + x(2)/x(1));
ct_x = -2*x(3)*ct_y/x(2) -x(5)/x(2);

syms X Y 
eqn = x(1)*X^2 + x(2)*X*Y + x(3)*Y^2 + x(4)*X + x(5)*Y + x(6);

plot(X_blank(:,1),X_blank(:,2),'bo')
for i = 1:length(X_blank)
    text(X_blank(i,1)+0.02,X_blank(i,2)-0.01,num2str(i))
end
hold on

grid on
fimplicit(eqn)
plot(ct_x,ct_y,'b.')
xlabel('x')
ylabel('y')

A*x
