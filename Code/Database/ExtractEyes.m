rect = [283.112, 446.532, 185.909, 82.459];
fullPath = what('Eyes').path;
eyes = dir(append(fullPath,'\*.jpg'));
L = length(eyes);
for i = 1:L
    I = imread(eyes(i).name);
    [r, c] = size(I);
    if r > 187 && c > 87 % not already cropped
        I = imcrop(I, rect);
        fullname = append(eyes(1).folder, '\', eyes(i).name);
        imwrite(I, fullname);
    end
end