templateRootFolder = 'D:\Upiita\5to\PDI\Proyecto Final\Letras';
outputFileName = 'templates.mat';
preprocessTemplates(templateRootFolder, outputFileName);

function preprocessTemplates(templateRootFolder, outputFileName)
    % Get the list of folders (each folder should represent a letter)
    folders = dir(templateRootFolder);
    folders = folders([folders.isdir] & ~startsWith({folders.name}, '.'));
    
    templates = struct();
    
    % Loop through each folder and process images
    for i = 1:length(folders)
        folderName = folders(i).name;
        letter = folderName(1); % Assuming folder name starts with the letter it represents
        folderPath = fullfile(templateRootFolder, folderName);
        
        % List all image files in the folder
        imageFiles = dir(fullfile(folderPath, '*.jpg'));
        imageFiles = [imageFiles; dir(fullfile(folderPath, '*.png'))];
        imageFiles = [imageFiles; dir(fullfile(folderPath, '*.bmp'))];
        
        letterTemplates = cell(length(imageFiles), 1);
        
        % Read each image and store it in the templates structure
        for j = 1:length(imageFiles)
            imageFile = fullfile(folderPath, imageFiles(j).name);
            letterTemplates{j} = imread(imageFile);
        end
        
        templates.(letter) = letterTemplates;
    end
    
    % Save the templates to a .mat file
    save(outputFileName, 'templates');
end
