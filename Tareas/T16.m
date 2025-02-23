clear , clc, close all
x=input("Ingrese el nombre de la imagen con la extensión: ", 's');
rgbtogray
go=g;
% Inicializar una celda para almacenar los planos de bits
p = cell(1, 8);

% Extraer los 8 planos de bits
for k = 1:8
    % Desplazar los bits a la derecha y aplicar una máscara para obtener el bit k-ésimo
    p{k} = bitget(go, k); % k va de 1 a 8
end

% Mostrar los resultados
figure;
subplot(3,3,1), imshow(go/255), title('Imagen Original');
for k = 1:8
    subplot(3,3,k+1), imshow(logical(p{k})), title(['Plano de bit ' num2str(k-1)]);
end

x=input("Ingrese el nombre de la imagen a esconder con la extensión: ", 's');
rgbtogray

figure;
subplot(221), imshow(go/255),title('Imagen Original');

pe = bitget(g, 8);
p{1}=pe;

subplot(222), imshow(c/255),title('Imagen a esconder');
subplot(223), imshow(logical(pe)),title('Plano 7');
subplot(224), imshow(go/255),title('Imagen Reconstruida');


figure;
subplot(3,3,1), imshow(go/255), title('Imagen Original con la imagen escondida');
for k = 1:8
    subplot(3,3,k+1), imshow(logical(p{k})), title(['Plano de bit ' num2str(k-1)]);
end