clc
clear all
close all

% Q1-1
% define x, y, z as numpy array
% plot 2d surface
x = linspace(-1, 1.5, 50);
y = linspace(-1.2, 0.2, 50);
[x,y] = meshgrid(x,y);
z = func(x, y);
figure(1)
plot(z)
grid on
hold on

% plot 3d surface
figure(2)
plot3(x,y,z)
grid on
hold on

% Q1-2
% define function using symbol x and y
syms x y
z = (x + y) * (x * y + x * y^2);
hessi = hessian(z,[x,y]) % hessian matrix
z_gran = [diff(z,'x') diff(z,'y')]; % gradient of z
subs(z_gran,[x,y],[1,0])

% Q1-3
% find critical point
critical_points = solve(z_gran == 0,[x y]);
critical_points = [critical_points.x(:,1),critical_points.y(:,1)];

% second partial derivative test
 H = hessian(z,[x,y])
 H_eig = zeros(length(critical_points),2);
 
 % Hessian 
 for i = 1 : 4
     z_critical = subs(z,[x,y],[critical_points(i,1),critical_points(i,2)]);
     hold on
     plot3(critical_points(i,1),critical_points(i,2),z_critical,'ro')

     Hessian_test = subs(H,[x,y], critical_points(i,:));
     [Hessian_eigvec,Hessian_eigvalue] = eig(Hessian_test);
     H_eig(i,1:2) = diag(Hessian_eigvalue);

     if(H_eig(i,1)>0 && H_eig(i,2)>0)
         text(critical_points(i,1),critical_points(i,2),z_critical+0.2,'local minimum')
     elseif(H_eig(i,1)<0 && H_eig(i,2)<0)
         text(critical_points(i,1),critical_points(i,2),z_critical+0.2,'local maximum')
     elseif(sum(sign(H_eig(i,:)))==0 && sum((sign(H_eig(i,:))~=0))==2)
         text(critical_points(i,1),critical_points(i,2),z_critical+0.2,'saddle point')
     else
         text(critical_points(i,1),critical_points(i,2),z_critical+0.2,'inconclusive')
     end
 end


function z = func(x, y)
    z = (x + y) .* (x .* y + x .* y.^2);
end