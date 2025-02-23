% Detección de puntos
clear , clc, close all
[x,loc]=uigetfile({'*.png;*.jpg;*.jpeg', 'Image Files (*.png, *.jpg, *.jpeg)'},...
 'Select a file', 'D:\Upiita\5to\PDI\');
T=input("Ingrese el valor de T deseado: ");
rgbtogray

gr=uint8(g);
[m, n] = size(gr);
s=zeros(size(gr));

% Máscara
ma = [-1 -1 -1; -1 8 -1; -1 -1 -1];

% Aplicar la máscara

for i=2:m-1
    for j=2:n-1
        dd=ma.*g(i-1:i+1,j-1:j+1);
        R=sum(dd(:));
        if abs(R)>=T
            s(i,j)=255;
        else 
            s(i,j)=0;
        end
    end
end

% Mostrar los resultados
figure;
subplot(2,1,1), imshow(gr), title('Imagen Original');
subplot(2,1,2), imshow(s/255), title(['Imagen filtrada con T= ' num2str(T)]);
