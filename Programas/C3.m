clear , clc, close all

c=imread('rauw.jpg');
sz=size(c);

r=zeros(sz);
r(:,:,1)=c(:,:,1);
g=zeros(sz);
g(:,:,2)=c(:,:,2);
b=zeros(sz);
b(:,:,3)=c(:,:,3);
% a=zeros(sz);
a=r+g; %a(:,:1:2)=c(:,:,1:2)
% cy=zeros(sz);
cy=b+g; %cy(:,:2:3)=c(:,:,2:3)
% m=zeros(sz);
m=r+b; %m(:,:1:2:3)=c(:,:,1:2:3)
figure
subplot(2,2,1), imshow(c)
subplot(2,2,2), imshow(r/255) %imshow(uint8(r))
subplot(2,2,3), imshow(g/255)
subplot(2,2,4), imshow(b/255)
figure
subplot(2,2,1), imshow(c)
subplot(2,2,2), imshow(a/255)
subplot(2,2,3), imshow(cy/255)
subplot(2,2,4), imshow(m/255)

rg=c(:,:,1);
gg=c(:,:,2);
bg=c(:,:,3);
figure
subplot(2,2,1),imshow(c)
subplot(2,2,2),imshow(rg)
subplot(2,2,3),imshow(gg)
subplot(2,2,4),imshow(bg)

grs=rgb2gray(c);
figure,subplot(1,2,1),imshow(c)
subplot(1,2,2),imshow(grs)

figure
subplot(2,2,1),imshow(grs)
subplot(2,2,2),imshow(rg)
subplot(2,2,3),imshow(gg)
subplot(2,2,4),imshow(bg)

figure,subplot(1,2,1),imshow(grs)
subplot(1,2,2), mesh(grs) %mesh(double(grs))