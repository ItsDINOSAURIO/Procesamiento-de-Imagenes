clear, close all, clc

% Carpeta con nuevas imágenes
newImageFolder = 'D:\Upiita\5to\PDI\Proyecto Final\Prueba\12.jpg';

% Carpeta de plantillas
templateFolder = 'D:\Upiita\5to\PDI\Proyecto Final\Letras';

% % Cargar y unir las imágenes de ejemplo
% img1 = imread('Letras\T\T30.jpg');
% img2 = imread('Letras\U\U45M.jpg');
% img3 = imread('Letras\B\B120.jpg');
% img4 = imread('Letras\O\O.jpg');
% 
% target_height = min([size(img1, 1), size(img2, 1), size(img3, 1), size(img4, 1)]);
% img1 = imresize(img1, [target_height NaN]);
% img2 = imresize(img2, [target_height NaN]);
% img3 = imresize(img3, [target_height NaN]);
% img4 = imresize(img4, [target_height NaN]);
% 
% % Unir las imágenes horizontalmente
% imagen_unida = [img1, img2, img3, img4];

% Convertir la imagen a escala de grises
x=imread(newImageFolder);
imagen_unida_gray = rgbtogray(x);

% Aplicar umbralización
imagen_unida_bin = im2bw(x,0.5);
% % Aplicar umbralización
% imagen_unida_bin = imbinarize(imagen_unida_gray);

% Etiquetar las regiones conectadas en la imagen binaria
[etiquetas, num] = bwlabel(imagen_unida_bin);

% Obtener las propiedades de las regiones etiquetadas
propiedades = regionprops(etiquetas, 'BoundingBox', 'Area');

% Definir umbral de área mínima
minAreaThreshold = 1000;  % Ajustar según el tamaño deseado

imshow(imagen_unida_bin);
hold on;

% Letras correspondientes a las plantillas
letras = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'I', 'J', 'L', 'M', ...
          'N', 'O', 'P', 'R', 'S', 'T', 'U', 'X', 'Y'];

% Inicializar vector para almacenar las mejores coincidencias
allBestMatches = [];

% Recorrer cada región detectada
for i = 1:num
    % Obtener las coordenadas y el área de la región
    bounding_box = propiedades(i).BoundingBox;
    area = propiedades(i).Area;

    % Filtrar regiones pequeñas basadas en el área
    if area < minAreaThreshold
        continue;  % Saltar a la siguiente iteración si el área es muy pequeña
    end

    % Dibujar un rectángulo alrededor de cada letra
    rectangle('Position', bounding_box, 'EdgeColor', 'r', 'LineWidth', 2);

    % Recortar la región de la imagen original en escala de grises
    letra_recortada_gray = imcrop(imagen_unida_bin, bounding_box);

    % Invertir la imagen binaria y eliminar pequeños objetos
    binaryImage = ~imagen_unida_bin;
    binaryImage = bwareaopen(binaryImage, 50);

    % Calcular momentos
    M = computeMoments(letra_recortada_gray);

    % Normalizar momentos centrales
    normMoments = centralMomentsNormalization(M);

    % Calcular momentos de Hu
    huMoments = computeHuInvariants(normMoments);

    % Buscar la mejor coincidencia con las plantillas
    bestMatchIndex = 0;
    minDistance = 0.1;
    bestMatch = '';

    templateFiles = dir(fullfile(templateFolder, 'Hu*.mat'));

    for j = 1:length(templateFiles)
        templateFilePath = fullfile(templateFolder, templateFiles(j).name);
        load(templateFilePath, 'huMomentsArray');

        for k = 1:size(huMomentsArray, 1)
            distance = norm(huMoments - huMomentsArray(k, :));

            if distance < minDistance
                minDistance = distance;
                bestMatchIndex = j;
                bestMatch = letras(j);
            end
        end
    end

    % Mostrar la mejor coincidencia encontrada (la letra correspondiente)
    if bestMatchIndex > 0 && bestMatchIndex <= length(letras)
        allBestMatches = [allBestMatches, bestMatch]; % Agregar la mejor coincidencia al vector
        fprintf('Best match for region %d: %s\n', i, bestMatch);
    else
        fprintf('No se encontró una coincidencia válida para la región %d\n', i);
    end
end

hold off;

% Concatenar todas las mejores coincidencias en una sola cadena
bestMatchesString = strjoin(arrayfun(@(x) x, allBestMatches, 'UniformOutput', false), '');

% Enviar la cadena concatenada a la función speak
speak(bestMatchesString);
hold off;

% Función para calcular momentos centrales
function M = computeMoments(binaryImage)
    % Compute central moments for a binary image
    [rows, cols] = size(binaryImage);
    [X, Y] = meshgrid(1:cols, 1:rows);

    % Compute spatial moments
    m00 = sum(binaryImage(:));
    m10 = sum(X(:) .* binaryImage(:));
    m01 = sum(Y(:) .* binaryImage(:));

    % Compute centroid
    xBar = m10 / m00;
    yBar = m01 / m00;
    % T23_1

    % Compute central moments
    M = zeros(3, 3);
    for p = 0:2
        for q = 0:2
            M(p+1, q+1) = sum(sum(((X - xBar).^p .* (Y - yBar).^q) .* binaryImage));
        end
    end
end

% Función para normalizar momentos centrales
function normMoments = centralMomentsNormalization(M)
    % Compute normalized central moments
    m00 = M(1,1);
    normMoments = zeros(3, 3);

    for p = 0:2
        for q = 0:2
            normMoments(p+1,q+1) = M(p+1,q+1) / m00^(1 + (p + q) / 2);
        end
    end
end

% Función para calcular momentos de Hu
function huMoments = computeHuInvariants(normMoments)
    % Compute Hu invariants from normalized central moments
    huMoments = zeros(1, 7);

    nu20 = normMoments(3, 1);
    nu02 = normMoments(1, 3);
    nu11 = normMoments(2, 2);
    nu30 = normMoments(3, 1) - 3 * normMoments(2, 2);
    nu03 = normMoments(1, 3) - 3 * normMoments(2, 2);
    nu21 = normMoments(3, 2) - 2 * normMoments(2, 2);
    nu12 = normMoments(2, 3) - 2 * normMoments(2, 2);

    huMoments(1) = nu20 + nu02;
    huMoments(2) = (nu20 - nu02)^2 + 4 * nu11^2;
    huMoments(3) = (nu30 - 3 * nu12)^2 + (3 * nu21 - nu03)^2;
    huMoments(4) = (nu30 + nu12)^2 + (nu21 + nu03)^2;
    huMoments(5) = (nu30 - 3 * nu12) * (nu30 + nu12) * ((nu30 + nu12)^2 - 3 * (nu21 + nu03)^2) + ...
                   (3 * nu21 - nu03) * (nu21 + nu03) * (3 * (nu30 + nu12)^2 - (nu21 + nu03)^2);
    huMoments(6) = (nu20 - nu02) * ((nu30 + nu12)^2 - (nu21 + nu03)^2) + 4 * nu11 * (nu30 + nu12) * (nu21 + nu03);
    huMoments(7) = (3 * nu21 - nu03) * (nu30 + nu12) * ((nu30 + nu12)^2 - 3 * (nu21 + nu03)^2) - ...
                   (nu30 - 3 * nu12) * (nu21 + nu03) * (3 * (nu30 + nu12)^2 - (nu21 + nu03)^2);
end

% Función para hablar en voz alta
function speak(text)
    if ispc
        % Windows con PowerShell y voz en español
        system(['powershell -Command "Add-Type -AssemblyName System.Speech; ' ...
                '$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer; ' ...
                '$speak.SelectVoice(''Microsoft Sabina Desktop''); ' ...
                '$speak.Speak(''' text ''');"']);
    elseif ismac
        % MacOS con comando say y voz en español
        system(['say -v Monica "' text '"']);
    elseif isunix
        % Linux con espeak y voz en español
        system(['espeak -v es "' text '"']);
    else
        disp('No se soporta la síntesis de voz en este sistema operativo');
    end
end


% clear
% close all
% clc
% 
% % Carpeta con nuevas imágenes
% newImageFolder = 'D:\Upiita\5to\PDI\Proyecto Final\Prueba';
% 
% % Carpeta de plantillas
% templateFolder = 'D:\Upiita\5to\PDI\Proyecto Final\Letras';
% 
% % Cargar y unir las imágenes de ejemplo
% img1 = imread('Letras\T\T30.jpg');
% img2 = imread('Letras\U\U45M.jpg');
% img3 = imread('Letras\B\B120.jpg');
% img4 = imread('Letras\O\O.jpg');
% 
% % Redimensionar para asegurar que tengan la misma altura
% target_height = min([size(img1, 1), size(img2, 1), size(img3, 1), size(img4, 1)]);
% img1 = imresize(img1, [target_height NaN]);
% img2 = imresize(img2, [target_height NaN]);
% img3 = imresize(img3, [target_height NaN]);
% img4 = imresize(img4, [target_height NaN]);
% 
% % Unir las imágenes horizontalmente
% imagen_unida = [img1, img2, img3, img4];
% 
% % Convertir la imagen a escala de grises
% imagen_unida_gray = rgb2gray(imagen_unida);
% 
% % Aplicar umbralización adaptativa
% bw = adaptthresh(imagen_unida_gray, 0.5);
% imagen_unida_bin = imbinarize(imagen_unida_gray, bw);
% 
% % Aplicar operaciones morfológicas para mejorar la binarización
% imagen_unida_bin = bwareaopen(imagen_unida_bin, 50);  % Eliminar pequeños objetos
% se = strel('disk', 2);  % Elemento estructurante para operaciones morfológicas
% imagen_unida_bin = imclose(imagen_unida_bin, se);  % Cierre para unir partes de las letras
% imagen_unida_bin = imfill(imagen_unida_bin, 'holes');  % Rellenar huecos dentro de las letras
% 
% % Etiquetar las regiones conectadas en la imagen binaria
% [etiquetas, num] = bwlabel(imagen_unida_bin);
% 
% % Obtener las propiedades de las regiones etiquetadas
% propiedades = regionprops(etiquetas, 'BoundingBox', 'Area');
% 
% % Definir umbral de área mínima
% minAreaThreshold = 10000;  % Ajustar según el tamaño deseado
% 
% % Letras correspondientes a las plantillas (suponiendo que las plantillas
% % están etiquetadas de alguna manera)
% letras = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', ...
%           'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
% 
% % Preparar subplot para visualización
% figure;
% 
% % Recorrer cada región detectada
% for i = 1:num
%     % Obtener las coordenadas y el área de la región
%     bounding_box = propiedades(i).BoundingBox;
%     area = propiedades(i).Area;
% 
%     % Filtrar regiones pequeñas basadas en el área
%     if area < minAreaThreshold
%         continue;  % Saltar a la siguiente iteración si el área es muy pequeña
%     end
% 
%     % Dibujar un rectángulo alrededor de cada letra
%     subplot(3, num, i);
%     imshow(imagen_unida_gray);
%     hold on;
%     rectangle('Position', bounding_box, 'EdgeColor', 'r', 'LineWidth', 2);
% 
%     % Recortar la región de la imagen original en escala de grises
%     letra_recortada_gray = imcrop(imagen_unida_gray, bounding_box);
% 
%     % Calcular momentos de Hu para la letra recortada
%     binaryImage = imbinarize(letra_recortada_gray);
% 
%     % Calcular momentos
%     M = computeMoments(binaryImage);
% 
%     % Normalizar momentos centrales
%     normMoments = centralMomentsNormalization(M);
% 
%     % Calcular momentos de Hu
%     huMoments = computeHuInvariants(normMoments);
% 
%     % Buscar la mejor coincidencia con las plantillas
%     bestMatchIndex = 0;
%     minDistance = inf;
% 
%     templateFiles = dir(fullfile(templateFolder, 'Hu*.mat'));
% 
%     for j = 1:length(templateFiles)
%         templateFilePath = fullfile(templateFolder, templateFiles(j).name);
%         load(templateFilePath, 'huMomentsArray');
% 
%         for k = 1:size(huMomentsArray, 1)
%             distance = norm(huMoments - huMomentsArray(k, :));
% 
%             if distance < minDistance
%                 minDistance = distance;
%                 bestMatchIndex = k;
%             end
%         end
%     end
% 
%     % Mostrar la mejor coincidencia encontrada (la letra correspondiente)
%     if bestMatchIndex > 0 && bestMatchIndex <= length(letras)
%         bestMatch = letras(bestMatchIndex);
%         fprintf('Best match for region %d: %s\n', i, bestMatch);
% 
%         % Decir en voz alta la letra encontrada
%         speak(bestMatch);
%     else
%         fprintf('No se encontró una coincidencia válida para la región %d\n', i);
%     end
% 
%     hold off;
% end
% 
% % Función para calcular momentos centrales
% function M = computeMoments(binaryImage)
%     % Compute central moments for a binary image
%     [rows, cols] = size(binaryImage);
%     [X, Y] = meshgrid(1:cols, 1:rows);
% 
%     % Compute spatial moments
%     m00 = sum(binaryImage(:));
%     m10 = sum(X(:) .* binaryImage(:));
%     m01 = sum(Y(:) .* binaryImage(:));
% 
%     % Compute centroid
%     xBar = m10 / m00;
%     yBar = m01 / m00;
% 
%     % Compute central moments
%     M = zeros(3, 3);
%     for p = 0:2
%         for q = 0:2
%             M(p+1, q+1) = sum(sum(((X - xBar).^p .* (Y - yBar).^q) .* binaryImage));
%         end
%     end
% end
% 
% % Función para normalizar momentos centrales
% function normMoments = centralMomentsNormalization(M)
%     % Compute normalized central moments
%     m00 = M(1,1);
%     normMoments = zeros(3, 3);
% 
%     for p = 0:2
%         for q = 0:2
%             normMoments(p+1,q+1) = M(p+1,q+1) / m00^(1 + (p + q) / 2);
%         end
%     end
% end
% 
% % Función para calcular momentos de Hu
% function huMoments = computeHuInvariants(normMoments)
%     % Compute Hu invariants from normalized central moments
%     huMoments = zeros(1, 7);
% 
%     nu20 = normMoments(3, 1);
%     nu02 = normMoments(1, 3);
%     nu11 = normMoments(2, 2);
%     nu30 = normMoments(3, 1) - 3 * normMoments(2, 2);
%     nu03 = normMoments(1, 3) - 3 * normMoments(2, 2);
%     nu21 = normMoments(3, 2) - 2 * normMoments(2, 2);
%     nu12 = normMoments(2, 3) - 2 * normMoments(2, 2);
% 
%     huMoments(1) = nu20 + nu02;
%     huMoments(2) = (nu20 - nu02)^2 + 4 * nu11^2;
%     huMoments(3) = (nu30 - 3 * nu12)^2 + (3 * nu21 - nu03)^2;
%     huMoments(4) = (nu30 + nu12)^2 + (nu21 + nu03)^2;
%     huMoments(5) = (nu30 - 3 * nu12) * (nu30 + nu12) * ((nu30 + nu12)^2 - 3 * (nu21 + nu03)^2) + ...
%                    (3 * nu21 - nu03) * (nu21 + nu03) * (3 * (nu30 + nu12)^2 - (nu21 + nu03)^2);
%     huMoments(6) = (nu20 - nu02) * ((nu30 + nu12)^2 - (nu21 + nu03)^2) + 4 * nu11 * (nu30 + nu12) * (nu21 + nu03);
%     huMoments(7) = (3 * nu21 - nu03) * (nu30 + nu12) * ((nu30 + nu12)^2 - 3 * (nu21 + nu03)^2) - ...
%                    (nu30 - 3 * nu12) * (nu21 + nu03) * (3 * (nu30 + nu12)^2 - (nu21 + nu03)^2);
% end
% 
% % Función para hablar en voz alta
% function speak(text)
%     if ispc
%         % Windows con PowerShell y voz en español
%         system(['powershell -Command "Add-Type -AssemblyName System.Speech; ' ...
%                 '$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer; ' ...
%                 '$speak.SelectVoice(''Microsoft Sabina Desktop''); ' ...
%                 '$speak.Speak(''' text ''');"']);
%     elseif ismac
%         % MacOS con comando say y voz en español
%         system(['say -v Monica "' text '"']);
%     elseif isunix
%         % Linux con espeak y voz en español
%         system(['espeak -v es "' text '"']);
%     else
%         disp('No se soporta la síntesis de voz en este sistema operativo');
%     end
% end
