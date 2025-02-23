% High-Boost
clear , clc, close all
x=input("Ingrese el nombre de la imagen con la extensión: ", 's');
rgbtogray
gr=uint8(g);
[m, n] = size(gr);

o = input('Indique el orden del filtro: ');
A = input('Eliga un valor para A: ');

fl = zeros(m, n); 
mat = -ones(o);
ct = ceil(o / 2); 
mat(ct, ct) = A*(o^2) - 1;
am = zeros(m, n); 

% Aplicar el filtro
for i = 1 + floor(o / 2) : m - floor(o / 2)
    for j = 1 + floor(o / 2) : n - floor(o / 2)
        reg = g(i - floor(o / 2) : i + floor(o / 2), j - floor(o / 2) : j + floor(o / 2));
        v = sum(reg, 'all');
        fl(i, j) = v / o^2; 
        
        v1 = double(reg);
        am(i, j) = sum(mat .* v1, 'all')/o^2; 
    end
end

% High-Boost por diferencia de imágenes
a = g - fl; 
bd = ((A - 1) * g) + a;

% High-Boost por máscara
bm = ((A - 1) * g) + am; 

subplot(2, 2, 1), imshow(uint8(c));
title('Imagen original a color');
subplot(2, 2, 2), imshow(gr);
title('Imagen original a escala de grises');
subplot(2, 2, 3), imshow(uint8(am));
title(['High-Boost con máscara de ' num2str(o) ' orden']);
subplot(2, 2, 4), imshow(uint8(bd));
title(['High-Boost por diferencia de imágenes de ' num2str(o) ' orden']);