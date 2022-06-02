function [res] = FindEyes(face, trainedModel)
    grayFace = rgb2gray(face);
    step = 10;
    [h, w] = size(grayFace);
    h = round((h - step)/2);
    w = round((w - step)/2);
    blk = [h, w];
    res = blkproc(grayFace, [step, step], blk, @(block) IsEye(block, trainedModel));
end

