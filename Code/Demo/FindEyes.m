function [res] = FindEyes(face, trainedModel)
    grayFace = rgb2gray(face);
    step = 10;
    % rectangle found empirically
    rect = [283.112, 446.532, 185.909, 82.459];
    h = round((rect(4) - step)/2);
    w = round((rect(3) - step)/2);
    blk = [h, w];
    res = blkproc(grayFace, [step, step], blk, @(block) IsEye(block, trainedModel));
    res = logical(res);
end

