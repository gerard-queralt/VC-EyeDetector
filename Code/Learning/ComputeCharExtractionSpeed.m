eyesImages = GetAllImagesInDatabaseFolder('Eyes');
n = numel(eyesImages);
index = round(randi(n));
image = eyesImages{index};
image = rgb2gray(image);
tic
chars = ExtractCharacteristics(image);
toc