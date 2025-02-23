% Detección de lineas
clear , clc, close all
[x,loc]=uigetfile({'*.png;*.jpg;*.jpeg', 'Image Files (*.png, *.jpg, *.jpeg)'},...
 'Select a file', 'D:\Upiita\5to\PDI\');
T=input("Ingrese el valor de T deseado: ");
rgbtogray

gr=uint8(g);
[m, n] = size(gr);
s=zeros(m,n,4);

% Máscaras
h = [-1 -1 -1; 2 2 2; -1 -1 -1];
v = [-1 2 -1; -1 2 -1; -1 2 -1];
d = [-1 -1 2; -1 2 -1; 2 -1 -1];
di = [2 -1 -1; -1 2 -1; -1 -1 2];

% Aplicar la máscara

% for k=1:4
%     for i=2:m-1
%         for j=2:n-1
%             switch k
%                 case 1
%                     dd = h .* g(i-1:i+1, j-1:j+1);
%                 case 2
%                     dd = v .* g(i-1:i+1, j-1:j+1);
%                 case 3
%                     dd = d .* g(i-1:i+1, j-1:j+1);
%                 case 4
%                     dd = di .* g(i-1:i+1, j-1:j+1);
%             end
%             R = sum(dd(:));
%             if abs(R) >= T
%                 s(i,j,k) = 255;
%             else 
%                 s(i,j,k) = 0;
%             end
%         end
%    end
% end

% Aplicación de máscaras por convolución
masks = {h, v, d, di};
for k = 1:4
    filtered = conv2(double(g), masks{k}, 'same');
    s(:,:,k) = uint8((abs(filtered) >= T) * 255);
end

figure, subplot(2,2,1), imshow(s(:,:,1)/255), title(['Imagen filtrada Horizontal con T= ' num2str(T)]);
subplot(2,2,2), imshow(s(:,:,2)/255), title(['Imagen filtrada Vertical con T= ' num2str(T)]);
subplot(2,2,3), imshow(s(:,:,3)/255), title(['Imagen filtrada +45° con T= ' num2str(T)]);
subplot(2,2,4), imshow(s(:,:,4)/255), title(['Imagen filtrada -45° con T= ' num2str(T)]);