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
    % sum of rows
    sumRow = sum(I,2)';

    characteristics = table(meanGradient, hist, sumRow);
end

