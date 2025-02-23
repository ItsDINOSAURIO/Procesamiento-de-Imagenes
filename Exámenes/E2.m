clear,clc,close

x = imread('aaa.jpg');
rgbtogray
% gris = grises_funct(color);
[filas, columnas] = size(g);

ntotal = filas*columnas;
x = 0:255;
y = zeros(1,256);
y2 = zeros(1,256);
yt = zeros(1,256);
nueva = zeros(filas,columnas);

factorisimo = 255/ntotal;

for i = 1:filas
    for j = 1:columnas

        tono = g(i,j) + 1;
        y(tono) = y(tono) + 1;

    end
end

for k = 1:256

    yt(k) = floor(factorisimo*(sum(y(1:k))));

end

for i = 1:filas
    for j = 1:columnas

        tono2 = max(1, min(256, g(i,j) + 1));
        nueva(i,j) = yt(tono2);
        tono3 = nueva(i,j) + 1;
        y2(tono3) = y2(tono3) + 1;

    end
end

subplot(2,2,1), imshow(g/255), title('IMAGEN ORIGINAL')
subplot(2,2,2), bar(x,y,'FaceColor','#dbc6b9'), xlim([0,256]), ylim([0, max(y)]), title('HISTOGRAMA ORIGINAL'), xlabel('rk'), ylabel('nk')
subplot(2,2,3), imshow(nueva/255), title('IMAGEN ECUALIZADA'), grid minor
subplot(2,2,4), bar(x,y2,'FaceColor','#a3bcb5'), xlim([0,256]), ylim([0, max(y2)]), title('HISTOGRAMA ECUALIZADO'), xlabel('rk'), ylabel('nk'), grid minor

figure, plot(x,yt,'b', 'LineWidth', 2), xlim([0,256]), ylim([0,256]), title('GRAFICA TRASNFORMACION SUM'), xlabel('X'), ylabel('YT')