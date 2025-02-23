clear, close all, clc

newImageFolder = 'D:\Upiita\5to\PDI\Proyecto Final\Prueba';  % Carpeta con nuevas imágenes
templateFolder = 'D:\Upiita\5to\PDI\Proyecto Final\Letras';  % Carpeta de plantillas
recognizeLetters(newImageFolder, templateFolder);
 
% function recognizeLetters(newImageFolder, templateFolder)
%     newImageFiles = dir(fullfile(newImageFolder, '*.jpg'));
%     templateFiles = dir(fullfile(templateFolder, 'Hu*.mat'));
% 
%     for i = 1:length(newImageFiles)
%         newImagePath = fullfile(newImageFolder, newImageFiles(i).name);
%         newImage = imread(newImagePath);
%         newImageG = rgbtogray(newImagePath);
% 
%         binaryImage =im2bw(newImage,0.5);
%         binaryImage= ~binaryImage;
%         % newImageHuMoments = computeMoments(binaryImage);
% 
%             % Compute central moments
%             M = computeMoments(binaryImage);
% 
%             % Normalize central moments
%             normMoments = centralMomentsNormalization(M);
% 
%             % Compute Hu moments
%             huMoments = computeHuInvariants(normMoments);
% 
%             % Store Hu moments in array
%             newImageHuMoments = huMoments;
% 
%         bestMatch = '';
%         minDistance = inf;
% 
%         for j = 1:length(templateFiles)
%             templateFilePath = fullfile(templateFolder, templateFiles(j).name);
%             load(templateFilePath, 'huMomentsArray');
% 
%             for k = 1:size(huMomentsArray, 1)
%                 distance = norm(newImageHuMoments - huMomentsArray(k, :));
% 
%                 if distance < minDistance
%                     minDistance = distance;
%                     bestMatch = templateFiles(j).name;
%                 end
%             end
%         end
% 
%         fprintf('Best match for %s: %s\n', newImageFiles(i).name, bestMatch);
%     end
% end
% 
% % function recognizeLetters(newImageFolder, templateFolder)
% %     newImageFiles = dir(fullfile(newImageFolder, '*.jpg'));
% %     templateFiles = dir(fullfile(templateFolder, 'Hu*.mat'));
% % 
% %     for i = 1:length(newImageFiles)
% %         newImagePath = fullfile(newImageFolder, newImageFiles(i).name);
% %         newImage = imread(newImagePath);
% %         newImageG = rgbtogray(newImagePath);
% % 
% %         % Segmentación y recorte de letras
% %         [letterImages, boundingBoxes] = segmentAndSaveLetters(newImageG, newImageFiles(i).name);
% % 
% %         % Iterar sobre cada letra segmentada
% %         for letterIdx = 1:length(letterImages)
% %             letterImage = letterImages{letterIdx};
% % 
% %             % Calcular momentos de Hu para la letra recortada
% %             binaryImage =im2bw(letterImage,0.5);
% %             binaryImage= ~binaryImage;
% % 
% %             % Calcular momentos y normalizar
% %             M = computeMoments(binaryImage);
% %             normMoments = centralMomentsNormalization(M);
% %             huMoments = computeHuInvariants(normMoments);
% % 
% %             % Encontrar la mejor coincidencia con las plantillas
% %             bestMatch = '';
% %             minDistance = inf;
% % 
% %             for j = 1:length(templateFiles)
% %                 templateFilePath = fullfile(templateFolder, templateFiles(j).name);
% %                 load(templateFilePath, 'huMomentsArray');
% % 
% %                 for k = 1:size(huMomentsArray, 1)
% %                     distance = norm(huMoments - huMomentsArray(k, :));
% % 
% %                     if distance < minDistance
% %                         minDistance = distance;
% %                         bestMatch = templateFiles(j).name;
% %                     end
% %                 end
% %             end
% % 
% %             fprintf('Best match for letter %d in %s: %s\n', letterIdx, newImageFiles(i).name, bestMatch);
% %         end
% %     end
% % end
% % 
% % function [letterImages, boundingBoxes] = segmentAndSaveLetters(image, imageName)
% %     % Convertir la imagen a escala de grises (si no lo es ya)
% %     imagen_unida_gray = image;
% % 
% %     % Aplicar umbralización
% %     imagen_unida_bin = imbinarize(imagen_unida_gray);
% % 
% %     % Etiquetar las regiones conectadas en la imagen binaria
% %     [etiquetas, num] = bwlabel(imagen_unida_bin);
% % 
% %     % Obtener las propiedades de las regiones etiquetadas
% %     propiedades = regionprops(etiquetas, 'BoundingBox');
% % 
% %     % Inicializar celdas para almacenar imágenes y bounding boxes
% %     letterImages = cell(num, 1);
% %     boundingBoxes = zeros(num, 4);
% % 
% %     % Recorrer cada región detectada
% %     for i = 1:num
% %         % Obtener las coordenadas de la región
% %         bounding_box = propiedades(i).BoundingBox;
% % 
% %         % Recortar la región de la imagen original en escala de grises
% %         letra_recortada = imcrop(imagen_unida_gray, bounding_box);
% % 
% %         % Guardar la letra recortada como imagen separada
% %         nombre_archivo = sprintf('%s_letra_%d.png', imageName, i);
% %         imwrite(letra_recortada, nombre_archivo);
% % 
% %         % Almacenar la imagen y el bounding box
% %         letterImages{i} = letra_recortada;
% %         boundingBoxes(i, :) = bounding_box;
% %     end
% % end
% 
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

function recognizeLetters(newImageFolder, templateFolder)
    newImageFiles = dir(fullfile(newImageFolder, '*.jpg'));
    templateFiles = dir(fullfile(templateFolder, 'Hu*.mat'));

    figure;
    for i = 1:length(newImageFiles)
        newImagePath = fullfile(newImageFolder, newImageFiles(i).name);
        newImage = imread(newImagePath);

        % Preprocesamiento de la imagen
        newImageG = rgbtogray(newImage);
        binaryImage = imbinarize(newImageG);  % Umbralización adaptativa puede ser útil
        binaryImage = ~binaryImage;  % Invertir binarización si es necesario

        % Segmentación y reconocimiento de letras
        [letterImages, boundingBoxes] = segmentLetters(binaryImage);

        % Subplot para mostrar resultados
        subplot(length(newImageFiles), 3, (i-1)*3 + 1);
        imshow(newImage);
        title('Imagen Original');

        subplot(length(newImageFiles), 3, (i-1)*3 + 2);
        imshow(binaryImage);
        title('Imagen Binarizada');

        subplot(length(newImageFiles), 3, (i-1)*3 + 3);
        imshow(newImage); hold on;
        for j = 1:size(boundingBoxes, 1)
            rectangle('Position', boundingBoxes(j,:), 'EdgeColor', 'r', 'LineWidth', 2);
        end
        hold off;
        title('Regiones Etiquetadas');

        % Iterar sobre cada letra segmentada
        for letterIdx = 1:length(letterImages)
            letterImage = letterImages{letterIdx};

            % Calcular momentos de Hu para la letra recortada
            M = computeMoments(letterImage);
            normMoments = centralMomentsNormalization(M);
            huMoments = computeHuInvariants(normMoments);

            % Encontrar la mejor coincidencia con las plantillas
            bestMatch = '';
            minDistance = inf;

            for j = 1:length(templateFiles)
                templateFilePath = fullfile(templateFolder, templateFiles(j).name);
                load(templateFilePath, 'huMomentsArray');

                % Comparar con cada plantilla
                for k = 1:size(huMomentsArray, 1)
                    distance = norm(huMoments - huMomentsArray(k, :));

                    if distance < minDistance
                        minDistance = distance;
                        bestMatch = templateFiles(j).name;
                    end
                end
            end

            fprintf('Best match for letter %d in %s: %s\n', letterIdx, newImageFiles(i).name, bestMatch);
        end
    end
end

function [letterImages, boundingBoxes] = segmentLetters(binaryImage)
    % Etiquetar las regiones conectadas en la imagen binaria
    [etiquetas, num] = bwlabel(binaryImage);

    % Obtener las propiedades de las regiones etiquetadas
    propiedades = regionprops(etiquetas, 'BoundingBox');

    % Inicializar celdas para almacenar imágenes y bounding boxes
    letterImages = cell(num, 1);
    boundingBoxes = zeros(num, 4);

    % Recorrer cada región detectada
    for i = 1:num
        % Obtener las coordenadas de la región
        bounding_box = propiedades(i).BoundingBox;

        % Recortar la región de la imagen original en escala de grises
        letterImage = imcrop(binaryImage, bounding_box);

        % Almacenar la imagen y el bounding box
        letterImages{i} = letterImage;
        boundingBoxes(i, :) = bounding_box;
    end
end

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

    % Compute central moments
    M = zeros(3, 3);
    for p = 0:2
        for q = 0:2
            M(p+1, q+1) = sum(sum(((X - xBar).^p .* (Y - yBar).^q) .* binaryImage));
        end
    end
end

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
