function computeAndSaveHuMoments(templateFolder)
    % Get list of folders (each folder corresponds to a letter)
    letterFolders = dir(templateFolder);
    letterFolders = letterFolders([letterFolders.isdir]);  % Only keep directories
    letterFolders = letterFolders(~ismember({letterFolders.name}, {'.', '..'}));  % Remove '.' and '..'

    % Loop through each letter folder
    for i = 1:length(letterFolders)
        letterFolder = letterFolders(i).name;
        letterPath = fullfile(templateFolder, letterFolder);
        
        % Get list of images in the letter folder
        imageFiles = dir(fullfile(letterPath, '*.jpg'));  % Adjust extension if needed

        % Initialize array to store Hu moments for each image
        huMomentsArray = zeros(length(imageFiles), 7);

        % Loop through each image and compute Hu moments
        for j = 1:length(imageFiles)
            imagePath = fullfile(letterPath, imageFiles(j).name);
            x = imread(imagePath);
            % Convert image to grayscale using the provided rgbtogray function
            imageArray = rgbtogray(x);
            
            % Convert to binary image
            binaryImage = im2bw(x, 0.5);
            % binaryImage = ~binaryImage;
            binaryImage=bwareaopen(binaryImage,50);
            
            % Segment the binary image
            [etiquetas, num] = bwlabel(binaryImage);
            propiedades = regionprops(etiquetas, 'BoundingBox', 'Area');
            
            % Define minimum area threshold
            minAreaThreshold = 1000;
            
            % Initialize array to store Hu moments for the current image
            huMomentsCurrentImage = [];

            % Loop through each segmented region
            for k = 1:num
                bounding_box = propiedades(k).BoundingBox;
                area = propiedades(k).Area;

                % Filter out small regions
                if area < minAreaThreshold
                    continue;
                end

                % Crop the region from the binary image
                binaryImageSegmented = imcrop(binaryImage, bounding_box);

                % Compute central moments
                M = computeMoments(binaryImageSegmented);
                
                % Normalize central moments
                normMoments = centralMomentsNormalization(M);
                
                % Compute Hu moments
                huMoments = computeHuInvariants(normMoments);
                
                % Store Hu moments in array for the current image
                huMomentsCurrentImage = [huMomentsCurrentImage; huMoments];
            end

            % If there are multiple segmented regions, take the mean of Hu moments
            if ~isempty(huMomentsCurrentImage)
                huMomentsArray(j, :) = mean(huMomentsCurrentImage, 1);
            else
                huMomentsArray(j, :) = NaN; % Handle case where no regions are detected
            end
        end
        
        % Save Hu moments array to a .mat file
        saveFileName = fullfile(templateFolder, ['Hu', letterFolder, '.mat']);
        save(saveFileName, 'huMomentsArray');
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