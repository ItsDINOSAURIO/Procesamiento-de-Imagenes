% Degradado de grises
clear, clc, close all

c=imread('gradual.jpg');
% c=imread('512.png');
imshow(c)
title('Imagen original con 256 tonos de grises')

[m, n] = size(c);
im = zeros(m, n, 7);
l=[0, 2, 4, 8, 16, 32, 64, 128];

for o=1:8
    for k=2:2^o
        for i = 1:m
            for j = 1:n
        im(i, j,o)=floor((c(i,j)/k))*k; 
            end
        end
        l(o)=k;
    end
    figure
    imshow(uint8(im(:,:,o)))
    title(['Nueva imagen con ' num2str(l(1, 9-o)) ' tonos de grises']);
end 
