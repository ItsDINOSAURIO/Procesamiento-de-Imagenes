clear , clc, close all
% Verde por azul
% Rojo por magenta

im=imread('esferascolores.JPG');
c=im;
[X,Y,Z]=size(c);

r=zeros(sz);
r(:,:,1)=c(:,:,1);
g=zeros(sz);
g(:,:,2)=c(:,:,2);
b=zeros(sz);
b(:,:,3)=c(:,:,3);

for i=1:X
    for j=1:Y
        if (c(i,j,1)>=100 && c(i,j,2)<=50 && c(i,j,3)<=30)
           c(i,j,1)=255; 
           c(i,j,2)=0;
           c(i,j,3)=255;
        end
    end
end

for i=1:X
    for j=1:Y
        if (c(i,j,1)<=100 && c(i,j,2)>=80 && c(i,j,3)<=50)
           c(i,j,1)=0;
           c(i,j,2)=0;
           c(i,j,3)=255;
        end
    end
end

figure, subplot(121), imshow(im)
title('Imagen Original')

subplot(122), imshow(c)
title('Imagen Transformada')