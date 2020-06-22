
clc
clear
close all

format long

syms X Y;
F = sin(X + Y - 1) + (X - Y - 1)^2 - 1.5*X + 2.5*Y + 1;

x(1) = -0.5;
y(1) = 3;
e = 10^(-8);
i = 1;

df_dx = diff(F, X);
df_dy = diff(F, Y);
J = [subs(df_dx,[X,Y], [x(1),y(1)]) subs(df_dy, [X,Y], [x(1),y(1)])]; % Gradient
ddf_ddx = diff(df_dx,X);
ddf_ddy = diff(df_dy,Y);
ddf_dxdy = diff(df_dx,Y);
ddf_ddx_1 = subs(ddf_ddx, [X,Y], [x(1),y(1)]);
ddf_ddy_1 = subs(ddf_ddy, [X,Y], [x(1),y(1)]);
ddf_dxdy_1 = subs(ddf_dxdy, [X,Y], [x(1),y(1)]);
H = [ddf_ddx_1, ddf_dxdy_1; ddf_dxdy_1, ddf_ddy_1];
S = -(J);

while norm(J) > e 
    I = [x(i),y(i)]';
    syms h;
    g = subs(F, [X,Y], [x(i)+S(1)*h,y(i)+h*S(2)]);
    dg_dh = diff(g,h);
    h = 0.1;
    x(i+1) = I(1)+h*S(1);
    y(i+1) = I(2)+h*S(2);
    i = i+1;
    J = [subs(df_dx,[X,Y], [x(i),y(i)]) subs(df_dy, [X,Y], [x(i),y(i)])];
    S = -(J);
end

Iter = 1:i;
X_coordinate = x';
Y_coordinate = y';
Iterations = Iter';
T = table(Iterations,X_coordinate,Y_coordinate)

fprintf('Minimum value : %d\n\n', subs(F,[X,Y], [x(i),y(i)]));

fcontour(F, 'Fill', 'On');
hold on;
plot(x,y,'*-r');
title('gradient descent')