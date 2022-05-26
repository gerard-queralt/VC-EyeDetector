function [images] = GetAllImagesInDatabaseFolder(folderName)
    fullPath = what(folderName).path;
    dirFiltered = append(fullPath,'\*.jpg');
    imageFiles = dir(dirFiltered);
    L = length(imageFiles);
    images = cell(1, L);
    for i = 1:L
        I = imread(imageFiles(i).name);
        images{i} = I;
    end
end

