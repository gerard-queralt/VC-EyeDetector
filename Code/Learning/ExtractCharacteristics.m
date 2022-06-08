function [characteristics] = ExtractCharacteristics(grayImage)
    [~, ~, channels] = size(grayImage);
    if(channels == 3) % RGB image
        grayImage = rgb2gray(grayImage);
    end
    I = imresize(grayImage, [48, 32]);
    % mean gradient
    h = fspecial("sobel");
    Sy = imfilter(I, h);
    Sx = imfilter(I, h');
    Ider = abs(Sy) + abs(Sx);
    meanGradient = mean2(Ider);
    % graylevel histogram
    hist = imhist(I)';
    % sum of columns
    sumCol = sum(I,1);
    % sum of rows
    sumRow = sum(I,2)';
    % gray-level co-occurrence matrix
    glcms = graycomatrix(I);
    glcmsVec = reshape(glcms, 1, []);

    characteristics = table(meanGradient, hist, sumCol, sumRow, glcmsVec);
end

