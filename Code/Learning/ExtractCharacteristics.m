function [characteristics] = ExtractCharacteristics(grayImage)
    [~, ~, channels] = size(grayImage);
    if(channels == 3) % RGB image
        grayImage = rgb2gray(grayImage);
    end
    I = imresize(grayImage, [48, 32]);

    % graylevel histogram
    hist = imhist(I)';
    % sum of rows
    sumRow = sum(I,2)';
    % sum of rows of gradient magnitude and direction
    [Gmag, Gdir] = imgradient(I,'sobel');
    sumRowGmag = sum(Gmag, 2)';
    sumRowGdir = sum(Gdir, 2)';

    characteristics = table(hist, sumRow, sumRowGmag, sumRowGdir);
end