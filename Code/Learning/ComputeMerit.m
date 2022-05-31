% TMP
prediction = trainedModel.predictFcn(chars);
% from: https://es.mathworks.com/matlabcentral/answers/388575-convert-string-array-into-cell-array#answer_310224
expected = arrayfun(@(x)char(chars.Expected(x)),1:numel(chars.Expected),'uni',false)';
accuracy = sum(strcmpi(expected,prediction),'all')/numel(expected);
% TMP
charsSize = width(chars) - 1; % we don't consider the label
imSize = 48 * 32;
merit = sqrt(pow2(1 - charsSize/imSize) + pow2(accuracy));
