function [] = Demo(videoName)
    % Create a cascade detector object.
    FaceDetector = vision.CascadeObjectDetector('FrontalFaceLBP');
    % Read a video frame and run the face detector.
    videoReader = VideoReader(videoName);
    while hasFrame(videoReader)
        % get the next frame
        videoFrame = readFrame(videoReader);
        bboxes = step(FaceDetector, videoFrame);
        
        faces = ExtractFaces(videoFrame, bboxes);
        
        facesChars = cellfun(@ProcessFace, faces, 'UniformOutput', false);
        if exists('trainedModel', 'var') == 1
            eyesFound = cellfun(@(chars) FindEyes(chars, trainedModel), facesChars, 'UniformOutput', false);
        end
    end
end

