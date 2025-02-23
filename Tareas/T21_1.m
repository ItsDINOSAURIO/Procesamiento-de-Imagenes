clear, close, clc

% Leer la imagen en escala de grises
[x, loc] = uigetfile({'*.png;*.jpg;*.jpeg', 'Image Files (*.png, *.jpg, *.jpeg)'}, 'Select a file', 'D:\Upiita\5to\PDI\');
rgbtogray 
[X, Y] = size(g);


% Calcular el histograma normalizado
r_k = 0:255;
nk = histcounts(g(:), 0:256);
pk = nk / sum(nk);

% Calcular pk acumulado y sus medias acumuladas
pk_acum = cumsum(pk);
r_k_acum = cumsum(r_k .* pk);

% Calcular las varianzas entre clases
sigma = pk_acum .* (1 - pk_acum) .* (r_k_acum - pk_acum).^2;

% Encontrar el umbral óptimo T
[~, T] = max(sigma);

% Resultado de T
disp(['Umbral T calculado por el método de Otsu: ', num2str(T)]);

% Umbralización
nueva = double(g > T) * 255;

% Graficar resultados
figure;

% Imagen original
subplot(2, 2, 1);
imshow(g/255);
title('Imagen original');

% Histograma
subplot(2, 2, 3:4);
bar(r_k, nk, "c");
line([T, T], [0, max(nk)], 'Color', 'r', 'LineWidth', 2);
title('Histograma');
xlabel('Nivel de Gris');

% Imagen procesada
subplot(2, 2, 2);
imshow(uint8(nueva));
title(['Imagen procesada (T = ', num2str(T), ')']);