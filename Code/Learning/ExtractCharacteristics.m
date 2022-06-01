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
    % number of bright
    % eyes should have a lot of white pixels
%     hist = imhist(I);
%     brightest = find(hist, 1, 'last');
%     nBrightest = hist(brightest);
    bright = I > 200;
    nBrigh = sum(sum(bright));
    
    % working with largest connected component
    BI = not(imbinarize(I));
    filteredBiggest = bwareafilt(BI,1);

    prop = regionprops('table', filteredBiggest, I, 'WeightedCentroid');
    centroidX = prop.WeightedCentroid(1);
    centroidY = prop.WeightedCentroid(2);
    BIchars = table(centroidX, centroidY);

    characteristics = table(meanGray, meanGradient, nBrigh);
    characteristics = [characteristics, BIchars];
end

