clc
clear
close all

n = input('n = ? \n');
figure(1)
grid on
i = ginput(n);

x = i(:,1);
y = i(:,2);

pinv_a = [x ones(length(x),1)];
SVD_a = [x y ones(length(x),1)];

pinv_p = pinv(pinv_a)*y;
pinv_e = pinv_p(1)*x + pinv_p(2);
%fprintf('y = %f*x + %f\n',pinv_p(1),pinv_p(2)) 

[U,D,V] = svd(SVD_a);
svd_p = V(:,end);
svd_e = (-svd_p(1)*x - svd_p(3))/svd_p(2);
%fprintf('y = %f*x + %f\n',-svd_p(1),svd_p(2)) 

plot(x,pinv_e,'g-');
hold on
grid on
plot(x,svd_e,'r-');
hold on
plot(x,y,'bo');
legend({'y=ax+b','ax+by+c=0'})