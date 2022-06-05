PopulateDatabase;
if exist('eyesImages', 'var') == 0
    eyesImages = GetAllImagesInDatabaseFolder('Eyes');
end
if exist('noEyesImages', 'var') == 0
    noEyesImages = GetAllImagesInDatabaseFolder('NoEyes');
end
eyesChars = ExtractCharacteristicsFromImages(eyesImages);
noEyesChars = ExtractCharacteristicsFromImages(noEyesImages);
chars = [eyesChars; noEyesChars];
lables = table('Size', [700, 1],'VariableTypes',"string",'VariableNames',"Expected");
lables(1:300,1) = {'Eye'};
lables(301:end,1) = {'NoEye'};
chars = [chars, lables];
classificationLearner(chars, "Expected")
