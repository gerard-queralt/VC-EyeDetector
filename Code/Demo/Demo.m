function [] = Demo(videoName, trainedModel)
    % Create a cascade detector object.
    FaceDetector = vision.CascadeObjectDetector('FrontalFaceLBP');
    % Read a video frame and run the face detector.
    videoReader = VideoReader(videoName);
    videoNameSplit = split(videoName, '.');
    resultName = strcat(videoNameSplit(1), 'Result');
    resultName = resultName{1};
    videosPath = what('Videos').path;
    oldDir = cd(videosPath);
    result = VideoWriter(resultName);
    open(result);
    while hasFrame(videoReader)
        % get the next frame
        videoFrame = readFrame(videoReader);
        [r, c, ~] = size(videoFrame);
        bboxes = step(FaceDetector, videoFrame);
        
        faces = ExtractFaces(videoFrame, bboxes);
        
        eyesFound = cellfun(@(face) FindEyes(face, trainedModel), faces, 'UniformOutput', false);

        for i = 1:numel(faces)
            [rf, cf, ~] = size(faces{i});
            eyes = imresize(eyesFound{i}, [rf, cf]);
            bb = bboxes(i,:);
            eyeMask = false(r, c);
            eyeMask(bb(2):bb(2)+bb(4), bb(1):bb(1)+bb(3)) = eyes;
            largestRegion = bwareafilt(eyeMask,1);
            props = regionprops('table', largestRegion, 'BoundingBox');
            videoFrame = insertShape(videoFrame, 'Rectangle', props.BoundingBox);
        end
        writeVideo(result, videoFrame);
    end
    close(result);
    cd(oldDir);
end
