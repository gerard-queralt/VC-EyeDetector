function [eye] = IsEye(image, trainedModel)
    chars = ExtractCharacteristics(image);
    prediction = trainedModel.predictFcn(chars);
    eye = strcmp(prediction{1},'Eye');
end

