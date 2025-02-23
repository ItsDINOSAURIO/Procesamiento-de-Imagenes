clear, clc, close all
x=input("Ingrese el nombre de la imagen con la extensión: ", 's');
ga=input("Ingrese el valor de gamma: ");
rgbtogray

[m, n] = size(g);

tr=zeros(size(g));

for i = 1:m
    for j = 1:n
        tr(i,j)=((255)^(1-ga))*(g(i,j)^ga);
    end
end

figure, subplot(221),imshow(g/255);
title('Imágen en tonos de grises');
subplot(222),imshow(c/255);
title('Imágen Original');
subplot(223),imshow(tr/255);
title('Imagen con corrección Gama');
ie=0:255;
is=((255).^(1-ga))*(ie.^ga);
subplot(224), plot(ie,is);
title('Transformación de corrección');