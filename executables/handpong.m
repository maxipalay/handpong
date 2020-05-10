clc
clear all;
% set up the code for communicating with Unity
tcpipClient = tcpip('127.0.0.1',55001,'NetworkRole','Client');
set(tcpipClient,'Timeout',3);

% set up
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Whole image inference of YOLOv2 network without any post-processing
% Tutorial on how to improve imshow performance for real time:
% https://es.mathworks.com/matlabcentral/answers/65521-make-imshow-more-efficent

inputSize = [300 300 3]; % network input size

% load pre trained YOLOv2 Object detector
trainednet = load('YOLOv2_mobilenetv2_trained');
detector=trainednet.detector;

% get camera object and set display resolution
camList = webcamlist;   % list all available webcams
cam = webcam(camList{1});% select first webcam
resolutionString = cam.Resolution; % get camera resolution (returns as string)
resolutionStringArray = split(resolutionString,'x'); % split string to get height and width separately
camera_resolution = [str2num(resolutionStringArray{2}),str2num(resolutionStringArray{1})];
aspect_ratio = camera_resolution(2)/camera_resolution(1); % aspect ratio to scale display properly
% if camera resolution is >720 in height, scale is down to 720, maintaining
% aspect ratio
display_resolution = [720,720*aspect_ratio];
% if camera resolution is <720 in height, leave scale as is
if camera_resolution(1)<720
    display_resolution = camera_resolution;
end

pause(0.5)
% inference
figure % open figure for display
frame = snapshot(cam); % get a frame
frame = imresize(frame,display_resolution); % resize 
imageShower = imshow(frame); % show image

% inference loop
while true
    %tic % debugging
    frame = snapshot(cam); % get a frame
    I = imresize(frame,inputSize(1:2));% resize frame to network input size
    % whole image detection
    [bboxes,scores] = detect(detector, I, 'threshold', 0.5, 'SelectStrongest', true);
    
    % POST PROCESSING
    % we get rid of boxes in the middle to avoid problems with faces
    % get the indexes of boxes on the left
    indexes_left = find((2*bboxes(:,1)+bboxes(:,3))/2<=130)';
    % get the indexes of boxes on the right
    indexes_right = find((2*bboxes(:,1)+bboxes(:,3))/2>=170)';
    % concat indexes
    indexes = [indexes_left,indexes_right];
    
    [score1,index]=max(scores(indexes_left));
    strongestbboxleft = bboxes(indexes_left(index),:);
    [score2,index]=max(scores(indexes_right));
    strongestbboxright = bboxes(indexes_right(index),:);
    
    bboxes = [strongestbboxleft;strongestbboxright];
    scores = [score1 score2];
    center_points = [-1,-1;-1,-1];                     
                 % left x y; right x y
    if score1
        center_points(1,:)=[(2*strongestbboxleft(1)+strongestbboxleft(3))/2, ...
                     (2*strongestbboxleft(2)+strongestbboxleft(4))/2];
    end
    if score2
        center_points(2,:)=[(2*strongestbboxright(1)+strongestbboxright(3))/2, ...
                     (2*strongestbboxright(2)+strongestbboxright(4))/2];
    end
    I = insertMarker(I, center_points);
    % END POST PROCESSING
    
      if scores % if there was a detection
        I = insertObjectAnnotation(I,'rectangle',bboxes,scores); % insert bounding boxes
                
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
           
            % open the port for the client
            fopen(tcpipClient);
            % pass the matrix "move" into the client (unity)
            move = num2str(center_points(1,2)) + " " + num2str(center_points(2,2))
            fwrite(tcpipClient,move);
            % close the client
            fclose(tcpipClient);
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    I = imresize(I,display_resolution); % resize 
    set(imageShower, 'cData', I); % faster than imshow
    %toc % debugging
end
mean(time)