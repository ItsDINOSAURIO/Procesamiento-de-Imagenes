% Deteccion de bordes
clear, clc, close all

[x, loc] = uigetfile({'*.png;*.jpg;*.jpeg', 'Image Files (*.png, *.jpg, *.jpeg)'}, 'Select a file', 'D:\Upiita\5to\PDI\');
T = input("Ingrese el valor de T deseado: ");
rgbtogray 

% Definición de operadores
mrx = [1 0; -1 0];
mry = [0 -1; 1 0];
mpx = [-1 0 1; -1 0 1; -1 0 1];
mpy = [-1 -1 -1; 0 0 0; 1 1 1];
msx = [1 0 -1; 2 0 -2; 1 0 -1];
msy = [1 2 1; 0 0 0; -1 -2 -1];

% Aplicación de operadores Roberts
robertsx = conv2(g, mrx, 'same');
robertsy = conv2(g, mry, 'same');
roberts = abs(robertsx) + abs(robertsy);

% Aplicación de operadores Prewitt
prewittx = conv2(g, mpx, 'same');
prewitty = conv2(g, mpy, 'same');
prewitt = abs(prewittx) + abs(prewitty);

% Aplicación de operadores Sobel
sobelx = conv2(g, msx, 'same');
sobely = conv2(g, msy, 'same');
sobel = abs(sobelx) + abs(sobely);

% Umbralización Roberts
robertsxb = robertsx >= T;
robertsyb = robertsy >= T;
robertsb = roberts >= T;

% Umbralización Prewitt
prewittxb = prewittx >= T;
prewittyb = prewitty >= T;
prewittb = prewitt >= T;

% Umbralización Sobel
sobelxb = sobelx >= T;
sobelyb = sobely >= T;
sobelb = sobel >= T;

% Visualización
figure;
subplot(221), imshow(g / 255), title('Imagen Original');
subplot(2, 2, 2), imshow(abs(robertsxb*255)), title('Bordes en X Roberts');
subplot(2, 2, 3), imshow(abs(robertsyb*255)), title('Bordes en Y Roberts');
subplot(2, 2, 4), imshow(abs(robertsb*255)), title('Bordes Roberts');

figure;
subplot(221), imshow(g / 255), title('Imagen Original');
subplot(2, 2, 2), imshow(abs(prewittxb*255)), title('Bordes en X Prewitt');
subplot(2, 2, 3), imshow(abs(prewittyb*255)), title('Bordes en Y Prewitt');
subplot(2, 2, 4), imshow(abs(prewittb*255)), title('Bordes Prewitt');

figure;
subplot(221), imshow(g / 255), title('Imagen Original');
subplot(2, 2, 2), imshow(abs(sobelxb*255)), title('Bordes en X Sobel');
subplot(2, 2, 3), imshow(abs(sobelyb*255)), title('Bordes en Y Sobel');
subplot(2, 2, 4), imshow(abs(sobelb*255)), title('Bordes Sobel');

figure;
subplot(221), imshow(g / 255), title('Imagen Original');
subplot(2, 2, 2), imshow(abs(robertsb*255)), title('Bordes Roberts');
subplot(2, 2, 3), imshow(abs(prewittb*255)), title('Bordes Prewitt');
subplot(2, 2, 4), imshow(abs(sobelb*255)), title('Bordes Sobel');