clc
close
clear all

H = 56;
W = 46;
X = [];

count = 0;
for i=1:40
    for j=2:10
    fname = sprintf('s%d_%d.png', i,j);
    fname = [cd '/att_faces/' fname];
    img = double(imread(fname));  
    tmp = reshape(img, H*W ,1);
    X=[X tmp]; 
    end
end

face = zeros(H,W);
face(:) = mean(X');
imwrite(uint8(face), 'avg.png');

c = cov(X');
[v, d] = eig(c);


for k=1:20
    fname = sprintf('eig%d.png',k);
    face(:) = v(:,56*46-k+1);
    imwrite(uint8(face/max(face(:)')*255), fname);
end

cnt = [1, 10, 100, 200];
for k=cnt
    v_k = v(:,56*46-k+1:56*46);
    y_k = X'*v_k;
    x_recons = v_k*y_k';
    for i=10
        fname = sprintf('%dres%d.png',i,k);
        face(:) = x_recons(:,i);
        imwrite(uint8(face), fname);
    end
end

fname_in = sprintf('s1_1.png');
fname_in = [cd '/att_faces/' fname_in];


