function [characteristics] = ExtractCharacteristics(grayImage)
    [r, c, channels] = size(grayImage);
    if(channels == 3) % RGB image
        grayImage = rgb2gray(grayImage);
    end
    I = imresize(grayImage, [48, 32]);
    characteristics = [0, 1];
end

