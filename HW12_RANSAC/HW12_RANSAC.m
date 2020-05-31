clc
close all
clear all

%n = input('n = ? \n');
%figure(1)
%grid on
%i = ginput(n);

i = importdata('data.csv'); % n_data = 30

x = i(:,1);
y = i(:,2);

% build matrix
A = [x.^2 x ones(length(x), 1)];
B = y;

% RANSAC fitting => f(x) = ax^2+bx+c의 포물선 결정을 위해 뽑아야할 샘플의 갯수는 3개
n_data = length(x);
N = 100; % iterations [1, 10, 100]
% T = 3*noise_sigma; % residual threshold
T = 3*100 % residual threshold
n_sample = 3; % ration [3%, 10%, 50%]
max_cnt = 0; % c_max = 0으로 초기화
best_model = [0;0;0];
for itr = 1:N,
    % random sampling
    s = n_data*rand(n_sample,1); % 무작위로 세점 p1, p2, p3를 선택
    k = floor(s)+1;
    
    % model estimation
    % 세 점을 지나는 포물선 f(x)를 구함
    AA = [x(k).^2 x(k) ones(length(k), 1)];
    BB = y(k);
    X = pinv(AA) * BB; % AA*X=BB
    
    % evaluation
    % f(x)와의 거리 residual가 T이하인 데이터의 개수 c를 구함
    residual = abs(B-A*X);
    cnt = length(find(residual<T));
    % c가 c_max보다 크다면 현재 f(x)를 저장(과거 저장된 값은 버림)
    if(cnt>max_cnt),
        best_model = X;
        max_cnt = cnt;
    end  
end

% optional LS(Least Square) fitting
%residual = abs(A*best_model - B);
%in_k = find(residual<T); % inlier k
%A2 = [x(in_k).^2 x(in_k) ones(length(in_k), 1)];
%B2 = y(in_k);
%X = pinv(A2)*B2; % refined model

% drawing
F = A*X;
% figure;
plot(x, y, '*b', x, F, 'r')
title('Result(iter = 100)')