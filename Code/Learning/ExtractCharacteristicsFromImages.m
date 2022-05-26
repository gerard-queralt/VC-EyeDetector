function [charsTable] = ExtractCharacteristicsFromImages(images)
    charsTable = cellfun(@ExtractCharacteristics, images, 'UniformOutput', false);
    charsTable = cell2table(charsTable');
    charsTable = splitvars(charsTable);
end

