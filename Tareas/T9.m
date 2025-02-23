clear, clc, close all
x=input("Ingrese el nombre de la imagen con la extensión: ", 's');

rgbtogray

[m, n] = size(g);

pt=m*n;

fr = zeros(1, 256);
hec = zeros(1, 256);
% ec = zeros(1, 256);
ecim=zeros(m,n);

for i = 1:m
    for j = 1:n
        ng = g(i, j); 
        fr(ng + 1) = fr(ng + 1) + 1;
    end
end

sum=cumsum(fr);
ec=round((sum/pt)*(255));

for i = 1:m
    for j = 1:n
        ecim(i, j) = ec(g(i, j) + 1); 
    end
end

for i = 1:m
    for j = 1:n
        ng = ecim(i, j); 
        hec(ng + 1) = hec(ng + 1) + 1;
    end
end


figure, subplot(221), bar(fr);
title('Histograma de niveles de grises');
xlabel('Nivel de gris');
ylabel('Número de píxeles');
subplot(222),imshow(g/255);
title('Imagen en tonos de Gris');
subplot(223),bar(hec);
title('Histograma ecualizado');
xlabel('Nivel de gris');
ylabel('Número de píxeles');
subplot(224), imshow(ecim/255);
title('Imagen ecualizada');

figure,plot(ec);
