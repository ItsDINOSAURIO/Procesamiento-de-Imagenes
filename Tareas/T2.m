clear, clc, close all

%c=rgb2gray(imread('rauw.jpg'));
c=imread('512.png');
imshow(c)
title('Imagen original')

[m, n] = size(c);
im = zeros(m, n, 8);

for o=1:8
    for k=2:2^o
        for i = 1:k:m-k-1
            for j = 1:k:n-k-1
        bloque = c(i:i+k-1, j:j+k-1);
        A = mean(bloque(:));
        im(i:i+k-1, j:j+k-1,o)=A;
            end
        end
    end
    figure
    imshow(uint8(im(:,:,o)))
    title(['Nueva imagen con promedios en bloques de ' num2str(k) ' x ' num2str(k)]);
end 
