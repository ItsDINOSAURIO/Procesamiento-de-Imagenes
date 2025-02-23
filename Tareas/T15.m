clear , clc, close all
x=input("Ingrese el nombre de la imagen con la extensión: ", 's');
rgbtogray

r_x = [1 0; 0 -1];
r_y = [0 1; -1 0];

% Prewitt
p_x = [-1 0 1; -1 0 1; -1 0 1];
p_y = [-1 -1 -1; 0 0 0; 1 1 1];

% Sobel
s_x = [-1 0 1; -2 0 2; -1 0 1];
s_y = [-1 -2 -1; 0 0 0; 1 2 1];

% Aplicar las máscaras usando conv2
% Roberts
m_r_x = abs(conv2(double(g), r_x, 'same'));
m_r_y = abs(conv2(double(g), r_y, 'same'));
f_r = m_r_x + m_r_y;

% Prewitt
m_p_x = abs(conv2(double(g), p_x, 'same'));
m_p_y = abs(conv2(double(g), p_y, 'same'));
f_p = m_p_x + m_p_y;

% Sobel
m_s_x = abs(conv2(double(g), s_x, 'same'));
m_s_y = abs(conv2(double(g), s_y, 'same'));
f_s = m_s_x + m_s_y;

% Mostrar los resultados
figure;
subplot(2,2,1), imshow(g/255), title('Imagen Original');
subplot(2,2,2), imshow(uint8(m_r_x)), title('Bordes - Roberts - X');
subplot(2,2,3), imshow(uint8(m_r_y)), title('Bordes - Roberts - Y');
subplot(2,2,4), imshow(uint8(f_r)), title('Bordes - Roberts');

figure;l
subplot(2,2,1), imshow(g/255), title('Imagen Original');
subplot(2,2,2), imshow(uint8(m_p_x)), title('Bordes - Prewitt - X');
subplot(2,2,3), imshow(uint8(m_p_y)), title('Bordes - Prewitt - Y');
subplot(2,2,4), imshow(uint8(f_p)), title('Bordes - Prewitt');

figure;
subplot(2,2,1), imshow(g/255), title('Imagen Original');
subplot(2,2,2), imshow(uint8(m_s_x)), title('Bordes - Sobel - X');
subplot(2,2,3), imshow(uint8(m_s_y)), title('Bordes - Sobel - Y');
subplot(2,2,4), imshow(uint8(s_y)), title('Bordes - Sobel');

figure;
subplot(2,2,1), imshow(g/255), title('Imagen Original');
subplot(2,2,2), imshow(uint8(f_r)), title('Bordes - Roberts');
subplot(2,2,3), imshow(uint8(f_p)), title('Bordes - Prewitt');
subplot(2,2,4), imshow(uint8(s_y)), title('Bordes - Sobel');