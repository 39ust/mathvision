clc
clear
close all

%n = input('n = ? \n');
%i = ginput(n);

figure(1)
grid on
hold on

i = [1 1; 2 2; 3 3; 4 4; 5 5; 6 6; 7 5; 8 4; 9 3; 10 2;];

x = i(:,1);
y = i(:,2);

A = std(y);
B = 1;
C = 2;
D = mean(y);

p = [A B C D]';
config.term_torelance = 10^(-3);

syms X

itr = 0;
config.term_max_iter = 1000;

for itr = 1:config.term_max_iter
    r = compute_residual_at(x, y, p); 
    J = compute_jacobiab_at(x, p);
    delta_p = p;
    
    h = fplot(p(1) * sin(p(2) * X + p(3)) + p(4));
    p = p - (J' * J)^-1 * J' * r;
     
    % Check the tolrance terminal condition
    if(norm(p - delta_p) < config.term_torelance)
        break;
    else
        delete(h);
    end
end

plot(x,y,'r.','MarkerSize',10)

fprintf([num2str(p(1)),'sin(',num2str(p(2)),'x +',num2str(p(3)),') + ',num2str(p(4))])
itr

function [r] = compute_residual_at(x, y, p)
r = zeros(length(x),1);
    for i = 1:length(x)
        r(i,1) = y(i) - (p(1) * sin(p(2) * x(i) + p(3)) + p(4));
    end
end

function [J] = compute_jacobiab_at(x, p)
J = zeros(length(x),4);   
    for i = 1:length(x)
        J(i,1) = -sin(p(2) * x(i) + p(3));
        J(i,2) = -p(1) * x(i) * cos(p(2) * x(i)+p(3));
        J(i,3) = -p(1) * cos(p(2) * x(i)+p(3));
        J(i,4) = -1;
    end
end