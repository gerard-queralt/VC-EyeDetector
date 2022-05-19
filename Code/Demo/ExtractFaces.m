function [faces] = ExtractFaces(videoFrame,bboxes)
    [nBoxes, ~] = size(bboxes);
    faces = cell(1, nBoxes);
    for i = 1:nBoxes
        bb = bboxes(i,:);
        I = imcrop(videoFrame, bb);
        faces{i} = I;
    end
end

