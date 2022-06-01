function [chars] = ExtractCharacteristicsAsVector(image)
    charsTable = ExtractCharacteristics(image);
    chars = table2array(charsTable);
end

