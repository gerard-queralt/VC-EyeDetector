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
        eyesFound = cellfun(@(chars) FindEyes(chars, MODEL?), faces, 'UniformOutput', false);
    end
end

