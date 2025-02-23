clear, clc, close all

load datos.mat

imshow(gris)
title('Imagen original')

[m, n] = size(gris);
prom = zeros(m, n);

for i = 1:2:m-1
    for j = 1:2:n-1
        bloque = gris(i:i+1, j:j+1);
        A = mean(bloque(:));
        prom(i:i+1, j:j+1)=A;
    end
end

figure
imshow(uint8(prom))
title('Nueva imagen con promedios de bloques 2x2')

