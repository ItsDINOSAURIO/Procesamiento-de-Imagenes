clear, clc, close all
% Lectura de la imagen
x = 'C:\mis documentos\imagen1.jpg';

% rgbtogray
c=double(imread(x));
[X, Y, Z]=size(c);
if Z==3
    g=round(c(:,:,1)*0.299 + c(:,:,2)*0.587 + c(:,:,3)*0.114);
elseif Z==1
    g=c;
end

sz=size(c);
% Combinación de colores
r=zeros(sz);
r(:,:,1)=c(:,:,1);
gr=zeros(sz);
gr(:,:,2)=c(:,:,2);
b=zeros(sz);
b(:,:,3)=c(:,:,3);
m=r+b;
a=r+gr; 
% Impresión de colores
figure, imshow(m/255)
figure, imshow(a/255)
figure, mesh(g)