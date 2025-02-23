% Detección de líneas a distintos grados
clear, clc, close all

[x, loc] = uigetfile({'*.png;*.jpg;*.jpeg', 'Image Files (*.png, *.jpg, *.jpeg)'}, 'Select a file', 'D:\Upiita\5to\PDI\');
T = input("Ingrese el valor de T deseado: ");
rgbtogray 

[F, C] = size(g);
D = zeros(F, C);
D1 = zeros(F, C);

disp('Detección de líneas a:')
disp('20°')
disp('50°')
disp('60°')
disp('120°')
disp('130°')
disp('150°')
a = input('Ingrese el valor del ángulo a detectar: ');

% Definición de máscaras

m20=[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1;
        -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1;
        -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1;
        -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1;
        -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1;
        -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1;
        -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1;
        -1,-1,-1,-1,-1,-1,-1,-1, 8, 8,10;
        -1,-1,-1,-1,-1, 8, 8, 8, 8,-1,-1;
        -1,-1,-1, 8, 8, 8,-1,-1,-1,-1,-1;
        10, 8, 8,-1,-1,-1,-1,-1,-1,-1,-1];
m50 = [-1 -1 -1 -1 -1 -1 -1 -1  7  7 -1;
       -1 -1 -1 -1 -1 -1 -1  7  7 -1 -1;
       -1 -1 -1 -1 -1 -1 -1  7 -1 -1 -1;
       -1 -1 -1 -1 -1 -1  7 -1 -1 -1 -1;
       -1 -1 -1 -1 -1  8 -1 -1 -1 -1 -1;
       -1 -1 -1 -1  7 -1 -1 -1 -1 -1 -1;
       -1 -1 -1  7 -1 -1 -1 -1 -1 -1 -1;
       -1 -1  7  7 -1 -1 -1 -1 -1 -1 -1;
       -1  7  7 -1 -1 -1 -1 -1 -1 -1 -1;
       -1  7 -1 -1 -1 -1 -1 -1 -1 -1 -1;
        7 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1];
m60 = [-1 -1 -1 -1 -1 10 -1 -1 -1 -1 -1;
       -1 -1 -1 -1 -1 10 -1 -1 -1 -1 -1;
       -1 -1 -1 -1 10 -1 -1 -1 -1 -1 -1;
       -1 -1 -1 -1 10 -1 -1 -1 -1 -1 -1;
       -1 -1 -1 10 -1 -1 -1 -1 -1 -1 -1;
       -1 -1 -1 10 -1 -1 -1 -1 -1 -1 -1;
       -1 -1 10 -1 -1 -1 -1 -1 -1 -1 -1;
       -1 -1 10 -1 -1 -1 -1 -1 -1 -1 -1;
       -1 10 -1 -1 -1 -1 -1 -1 -1 -1 -1;
       10 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1;
       10 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1];
m150 = [-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1;
        -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1;
        -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1;
        -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1;
        10 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1;
        -1  8  8 -1 -1 -1 -1 -1 -1 -1 -1;
        -1 -1  8  8 -1 -1 -1 -1 -1 -1 -1;
        -1 -1 -1 -1  8  8 -1 -1 -1 -1 -1;
        -1 -1 -1 -1 -1 -1  8  8 -1 -1 -1;
        -1 -1 -1 -1 -1 -1 -1  8  8 -1 -1;
        -1 -1 -1 -1 -1 -1 -1 -1 -1  8 10];
m120 = m60(:, end:-1:1);
m130 = m50(:, end:-1:1);

switch a
    case 20
        m = m20;
        T = 54 * 121;
    case 50
        m = m50;
        T = 80 * 121;
    case 60
        m = m60;
        T = 120 * 121;
    case 120
        m = m120;
        T = 110 * 121;
    case 130
        m = m130;
        T = 90 * 121;
    case 150
        m = m150;
        T = 55 * 121;
    otherwise
        error('Ángulo no válido.');
end

% % Método tradicional de bucles
% for f = 6:F-5
%     for c = 6:C-5
%         s = 0;
%         for x = -5:5
%             for y = -5:5
%                 s = s + m(6 + x, 6 + y) * g(f + x, c + y);
%             end
%         end
%         if abs(s) >= T
%             D1(f, c) = 1;
%         end
%     end
% end

% Aplicar la máscara utilizando convolución
r = conv2(g, m, 'same');

% Umbralización
D = abs(r) >= T;

% Visualización
% figure
% subplot(1, 3, 1)
% imshow(g / 255)
% title('Imagen original')
% subplot(1, 3, 2)
% imshow(D)
% title("Detección de líneas (Convolución) a " + a + "°")
% subplot(1, 3, 3)
% imshow(D1)
% title("Detección de líneas (Bucles) a " + a + "°")
figure
subplot(1, 2, 1)
imshow(g / 255)
title('Imagen original')
subplot(1, 2, 2)
imshow(D)
title("Detección de líneas a " + a + "°")
