clear, clc, close all
x=input("Ingrese el nombre de la imagen con la extensión: ", 's');

rgbtogray

[m, n] = size(g);
    
fr = zeros(1, 256);
    
for i = 1:m
    for j = 1:n
            ng = g(i, j);
            fr(ng + 1) = fr(ng + 1) + 1;
    end
end

ng = 0:255;
figure, subplot(121), bar(ng, fr);
title('Histograma de niveles de grises');
xlabel('Nivel de gris');
ylabel('Número de píxeles');
subplot(122),imshow(g/255);
title('Imagen en tonos de Gris');

figure, subplot(121),bar(ng, fr/(m*n));
title('Probabilidad de niveles de grises');
xlabel('Nivel de gris');
ylabel('Probabilidad');

 subplot(122), imshow(g/255);
title('Imagen en tonos de Gris');