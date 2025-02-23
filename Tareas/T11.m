% Promediado de imágenes
clear , clc, close all
x=input("Ingrese el nombre de la imagen con la extensión: ", 's');
rgbtogray
gr=uint8(g);
M = input('Indique el número de imágenes a promediar: ');
disp('Seleccione el tipo de ruido deseado: ');
disp('1. Gaussiano');
disp('2. Sal y pimienta');
t = input('');
pr = input('Indique la cantidad de ruido deseada: ');
su = uint8(zeros(size(gr)));
for i=1:M
    switch t
        case 1
            r=imnoise(gr,'gaussian',0,pr);
        case 2
            r=imnoise(gr,'salt & pepper',pr);
    end
    su=su+r;
end
fl=(su/M);

figure, subplot(131),imshow(gr);
title('Imágen Original');
subplot(132),imshow(r);
title('Imágen con Ruido');
subplot(133),imshow(fl);
title('Imagen Promediada');