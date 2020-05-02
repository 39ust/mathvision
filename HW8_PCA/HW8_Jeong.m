clc
clear
close all

apple_a = load('data_a.txt'); 
apple_b = load('data_b.txt');

apple = [apple_a; apple_b];

%[n_apple, mu, sigma] = zscore(apple); % 특성값이 -1에서 1사이, 평균 0이 되도록 표준화.  

cov_apple = cov(apple);
[eigvector, eigvalue] = eig(cov_apple);


coeff = pca(apple); %% PCA 수행

data_a = apple_a*coeff(:,1:2);
data_b = apple_b*coeff(:,1:2);

figure()
plot(data_a(:,1),data_a(:,2),'ro')
hold on
grid on
plot(data_b(:,1),data_b(:,2),'bo')
legend('apple_A','apple_B')

x1 = -25:.2:25;
x2 = -25:.2:25;
[X1,X2] = meshgrid(x1,x2);
X =[X1(:),X2(:)];

d = 2;
Mu_a = mean(data_a);
Sigma_a = cov(data_a);

Mu_b = mean(data_b);
Sigma_b = cov(data_b);

%P_Gaussian_a = 1/((2*pi)^(d)*sqrt(det(Sigma_a)))*exp(-1/2*(X-Mu_a)*Sigma_a^-1*(X-Mu_a)');
%P_Gaussian_a_plot = reshape(P_Gaussian_a,length(x2),length(x1));

%P_Gaussian_b = 1/((2*pi)^(d)*sqrt(det(Sigma_b)))*exp(-1/2*(X-Mu_b)*Sigma_b^-1*(X-Mu_b)');
%P_Gaussian_b_plot = reshape(P_Gaussian_b,length(x2),length(x1));

Sigma_ab = [Sigma_a; Sigma_b];

test_apple = load('test.txt');
test_data = test_apple*coeff(:,1:2);

test_cov_apple = cov(test_apple);
[eigvector, eigvalue] = eig(test_cov_apple);


Mu_apple = [Mu_a; Mu_b];

mahal_distance_a = mahal(test_data,data_a);
mahal_distance_b = mahal(test_data,data_b);

mahal_distance_mat = [mahal_distance_a, mahal_distance_b]

d1 = (test_data(1,:) - Mu_apple(1,:))*Sigma_a^-1*(test_data(1,:) - Mu_apple(1,:))';
d2 = (test_data(1,:) - Mu_apple(2,:))*Sigma_b^-1*(test_data(1,:) - Mu_apple(2,:))';
d3 = (test_data(2,:) - Mu_apple(1,:))*Sigma_a^-1*(test_data(2,:) - Mu_apple(1,:))';
d4 = (test_data(2,:) - Mu_apple(2,:))*Sigma_b^-1*(test_data(2,:) - Mu_apple(2,:))';


mahal_distance = [d1, d2; d3, d4]
