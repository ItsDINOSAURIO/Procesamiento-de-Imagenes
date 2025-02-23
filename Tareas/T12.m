% Filtro de mediana
clear , clc, close all
x=input("Ingrese el nombre de la imagen con la extensión: ", 's');
rgbtogray
gr=uint8(g);
[m, n] = size(gr);

o = input('Indique el orden del filtro: ');

disp('Seleccione el tipo de ruido deseado: ');

disp('1. Gaussiano');
disp('2. Sal y pimienta');
t = input('');

pr = input('Indique la cantidad de ruido deseada: ');

switch t
    case 1
        r=imnoise(gr,'gaussian',0,pr);
    case 2
        r=imnoise(gr,'salt & pepper',pr);
end

fl = zeros(m, n);

for i = 1 + floor(o / 2) : m - floor(o / 2)
    for j = 1 + floor(o / 2) : n - floor(o / 2)
        bq = r(i - floor(o / 2) : i + floor(o / 2), j - floor(o / 2) : j + floor(o / 2));
        fl(i, j) = median(bq(:));
    end
end
figure, subplot(131),imshow(gr);
title('Imágen Original');
subplot(132),imshow(r);
title('Imágen con Ruido');
subplot(133),imshow(fl/255);
title('Imagen Filtrada');