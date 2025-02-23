clear, close,clc

templateFolder = 'D:\Upiita\5to\PDI\Proyecto Final\Letras';  % Replace with the path to your templates folder
computeAndSaveHuMoments(templateFolder);

% % Specify the folder containing the images
% folder = 'D:\Upiita\5to\PDI\Proyecto Final\Letras\A';
% 
% % List all extensions you want to include
% extensions = {'*.jpg', '*.png', '*.bmp'};
% 
% % Initialize an empty array to hold the file information
% imageFiles = [];
% 
% % Collect all files with the specified extensions
% for ext = extensions
%     imageFiles = [imageFiles; dir(fullfile(folder, ext{1}))];
% end
% 
% % Determine the number of images
% numImages = length(imageFiles);
% 
% % Calculate the number of rows and columns for subplots
% numCols = ceil(sqrt(numImages));
% numRows = ceil(numImages / numCols);
% 
% % Create a figure to hold the subplots
% figure;
% 
% % Loop through the list, read each image, and display in subplot
% for k = 1:numImages
%     baseFileName = imageFiles(k).name;
%     fullFileName = fullfile(folder, baseFileName);
%     fprintf(1, 'Now reading %s\n', fullFileName);
%     imageArray = imread(fullFileName);
% 
%     % Create a subplot for this image
%     subplot(numRows, numCols, k);
%     imshow(imageArray);
%     title(baseFileName, 'Interpreter', 'none');
% end
% 
% % Specify the folder containing the images and templates
% imageFolder ='D:\Upiita\5to\PDI\Proyecto Final\Letras\A';
% templateFolder = 'D:\Upiita\5to\PDI\Proyecto Final\Letras\A';
% 
% % List all extensions you want to include for images and templates
% imageExtensions = {'*.jpg', '*.png', '*.bmp'};
% templateExtensions = {'*.jpg', '*.png', '*.bmp'};
% 
% % Collect all image files
% imageFiles = [];
% for ext = imageExtensions
%     imageFiles = [imageFiles; dir(fullfile(imageFolder, ext{1}))];
% end
% 
% % Collect all template files
% templateFiles = [];
% for ext = templateExtensions
%     templateFiles = [templateFiles; dir(fullfile(templateFolder, ext{1}))];
% end
% 
% % Read templates and store them in a cell array
% templates = cell(length(templateFiles), 1);
% templateLabels = cell(length(templateFiles), 1);
% for i = 1:length(templateFiles)
%     templateName = templateFiles(i).name;
%     templatePath = fullfile(templateFolder, templateName);
%     templates{i} = imread(templatePath);
%     templateLabels{i} = templateName(1); % Assuming the file name starts with the letter
% end
% 
% % Create a figure to hold the subplots
% figure;
% 
% % Loop through each image, read it, and match it against templates
% for k = 1:length(imageFiles)
%     baseFileName = imageFiles(k).name;
%     fullFileName = fullfile(imageFolder, baseFileName);
%     fprintf(1, 'Now reading %s\n', fullFileName);
%     imageArray = imread(fullFileName);
% 
%     % Convert image to grayscale if necessary
%     if size(imageArray, 3) == 3
%         imageArray = rgb2gray(imageArray);
%     end
% 
%     bestMatch = '';
%     bestScore = -Inf;
% 
%     % Loop through each template and perform template matching
%     for t = 1:length(templates)
%         template = templates{t};
% 
%         % Convert template to grayscale if necessary
%         if size(template, 3) == 3
%             template = rgb2gray(template);
%         end
% 
%         % Resize template if it is larger than the image
%         if size(template, 1) > size(imageArray, 1) || size(template, 2) > size(imageArray, 2)
%             template = imresize(template, [size(imageArray, 1), size(imageArray, 2)]);
%         end
% 
%         % Perform normalized cross-correlation with different rotations
%         for angle = 0:30:330 % Check rotations from 0 to 330 degrees in 30-degree steps
%             rotatedTemplate = imrotate(template, angle, 'crop');
%             correlation = normxcorr2(rotatedTemplate, imageArray);
%             maxCorr = max(correlation(:));
% 
%             % Keep track of the best match
%             if maxCorr > bestScore
%                 bestScore = maxCorr;
%                 bestMatch = templateLabels{t};
%             end
%         end
%     end
% 
%     % Display the image with the identified letter
%     subplot(ceil(sqrt(length(imageFiles))), ceil(sqrt(length(imageFiles))), k);
%     imshow(imageArray);
%     title(['Identified as: ', bestMatch], 'Interpreter', 'none');
% end
