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
    
    % working with largest connected component
    BI = not(imbinarize(I));
    filteredBiggest = bwareafilt(BI,1);

    prop = regionprops('table', filteredBiggest, I, 'WeightedCentroid', ...
                       'MajorAxisLength', 'MinorAxisLength','MaxFeretProperties', 'MinFeretProperties');
    centroidX = prop.WeightedCentroid(1);
    centroidY = prop.WeightedCentroid(2);
    meanAxisLength = mean([prop.MajorAxisLength prop.MinorAxisLength], 2);
    meanFeret = mean([prop.MaxFeretDiameter prop.MinFeretDiameter], 2);
    meanAxisFeretRatio = meanAxisLength / meanFeret;
    BIchars = table(centroidX, centroidY, meanAxisFeretRatio, meanAxisLength, meanFeret);

    characteristics = table(meanGray, meanGradient);
    characteristics = [characteristics, BIchars];
end

