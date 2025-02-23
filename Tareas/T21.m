clear, close, clc

% leer la imcagen en escala de grises
[x, loc] = uigetfile({'*.png;*.jpg;*.jpeg', 'Image Files (*.png, *.jpg, *.jpeg)'}, 'Select a file', 'D:\Upiita\5to\PDI\');
rgbtogray 
[X, Y] = size(g);

% Calcular el histograma normalizado y acumulado
r_k = 0:255;    nk = zeros(256, 1);
for i = 0:255
    nk(i + 1) = sum(g(:) == i);
end
pk = nk / sum(nk);

% Momentos
M1 = zeros(256, 1);
M2 = zeros(256, 1);
for t = 0:255
    M1(t+1) = sum(pk(1:(t+1)));
    M2(t+1) = sum(pk((t+1)+1:end));
end

% Medias
m1 = zeros(256, 1);
m2 = zeros(256, 1);
for t = 0:255
    if (t == 0)
        m1(t+1) = sum(1 * pk(1:t+1)) / M1(t+1);
    else
        m1(t+1) = sum(r_k(1:t+1)' .* pk(1:t+1)) / M1(t+1);
    end

    m2(t+1) = sum(r_k(t+2:end)' .* pk(t+2:end)) / M2(t+1);
end

% Intensidad Media
mut= M1 .* m1 + M2 .* m2; 
wt = M1 + M2; 

% Varianza
s = M1.*(m1 - mut).^2 + M2.*(m2 - mut).^2; 

% Encontrar el umbral óptimo
[~, T] = max(s);

% Resultado de T
disp(['Umbral T calculado por el método de Otsu: ', num2str(T)]);

% Umbralización
nueva = zeros(X, Y); 
for i = 1:X
    for j = 1:Y
        if g(i, j) > T
            nueva(i, j) = 255;
        else
            nueva(i, j) = 0;
        end
    end
end

% Gráficas
figure; 
subplot(2, 2, 1); imshow(g/255);
title('Imagen original');

subplot(2, 2, 3:4); bar(r_k, nk, "c"); 
line([T, T], [0, max(nk)], 'Color', 'r', 'LineWidth', 2);
title('Histograma');
xlabel('Nivel de Gris');

subplot(2, 2, 2); imshow(nueva/255);
title(['Imagen procesada (T = ', num2str(T), ')']);