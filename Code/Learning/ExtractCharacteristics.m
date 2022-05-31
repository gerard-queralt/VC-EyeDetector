function [characteristics] = ExtractCharacteristics(grayImage)
    [~, ~, channels] = size(grayImage);
    if(channels == 3) % RGB image
        grayImage = rgb2gray(grayImage);
    end
    I = imresize(grayImage, [48, 32]);
    % mean gray level
    meanGray = mean2(I);
    % mean gradient
    h = fspecial("sobel");
    Sy = imfilter(I, h);
    Sx = imfilter(I, h');
    Ider = abs(Sy) + abs(Sx);
    meanGradient = mean2(Ider);
    % number of brightest
    % eyes should have a lot of white pixels
%     hist = imhist(I);
%     brightest = find(hist, 1, 'last');
%     nBrightest = hist(brightest);
    brightest = I > 200;
    nBrightest = sum(sum(brightest));
    characteristics = table(meanGray, meanGradient, nBrightest);
end

