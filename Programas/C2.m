clear , clc, close all

c=imread('rauw.jpg');
sz=size(c);
% c(1,1,1)
% c(200,200,:)
r=zeros(sz);
r(:,:,1)=c(:,:,1);
g=zeros(sz);
g(:,:,2)=c(:,:,2);
b=zeros(sz);
b(:,:,3)=c(:,:,3);
a=zeros(sz);
a=r+g; %a(:,:1:2)=c(:,:,1:2)
cy=zeros(sz);
cy=b+g;
m=zeros(sz);
m=r+b;
figure
subplot(2,4,1:2), imshow(c)
subplot(2,4,3), imshow(r/255) %imshow(uint8(r))
subplot(2,4,4), imshow(g/255)
subplot(2,4,5), imshow(b/255)
subplot(2,4,6), imshow(a/255)
subplot(2,4,7), imshow(cy/255)
subplot(2,4,8), imshow(m/255)

rg=c(:,:,1);
gg=c(:,:,2);
bg=c(:,:,3);
figure
subplot(2,2,1)
imshow(c)
subplot(2,2,2),imshow(rg)
subplot(2,2,3),imshow(gg)
subplot(2,2,4),imshow(bg)
