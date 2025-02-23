% Pasabajas
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

fp=ones(o)/(o^2);
for i = floor(o/2)+1:m-floor(o/2)
    for j = floor(o/2)+1:n-floor(o/2)
        x= double(r(i-floor(o/2):i+floor(o/2), j-floor(o/2):j+floor(o/2)));
        vp=sum(x(:).*fp(:));
        fl(i, j) = vp;
    end
end

figure, subplot(131),imshow(gr);
title('Imágen Original');
subplot(132),imshow(r);
title('Imágen con Ruido');
subplot(133),imshow(fl/255);
title('Imagen Filtrada');