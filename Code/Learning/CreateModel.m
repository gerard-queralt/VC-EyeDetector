PopulateDatabase;
eyes = GetAllImagesInDatabaseFolder('Eyes');
noEyes = GetAllImagesInDatabaseFolder('NoEyes');
eyesChars = ExtractCharacteristicsFromImages(eyes);
noEyesChars = ExtractCharacteristicsFromImages(noEyes);
chars = [eyesChars; noEyesChars];
lables = table('Size', [700, 1],'VariableTypes',"string",'VariableNames',"Expected");
lables(1:300,1) = {'Eye'};
lables(301:end,1) = {'NoEye'};
chars = [chars, lables];
classificationLearner(chars, "Expected")
