% Process data from EgoHands dataset to train a nn
% ######Uses getBoundingBoxes function provided with egohands dataset######
%
% Output:
%   file with following variables
%       paths_to_images -> array with path to image
%       bounding boxes -> multidimensional matrix in which the third
%       dimension corresponds to the ith image in paths_to_images.
%                      -> the first two dimensions are the matrix with the
%                      bounding boxes information. The rows from top to 
%                      bottom contain the bounding boxes for "own left",
%                      "own right", "other left", and "other right" hand
%                      respectively.
%

out_file = 'data_egohands.mat'; % name of output_file

load('dataset_egohands/metadata.mat'); % loads as 'video' struct

% Video struct structure (that we're interested in)
% video
%   video_id -> folder that has the frames
%   labelled_frames  -> struct
%       frame_num      -> number of frame
%       myleft         -> array with segmentation points of personal left
%                         hand
%       myright        -> array with segmentation points of personal right
%                         hand
%       yourleft       -> array with segmentation points of spectator left
%                         hand
%       yourright      -> array with segmentation points of spectator right
%                         hand


counter = 1;
for i=1:length(video) % for each folder with frames
    for j=1:length(video(i).labelled_frames) % for each frame
        path = get_path(video(i).video_id, video(i).labelled_frames(j).frame_num); % get frame path
        bboxes = getBoundingBoxes(video(i), j); % get frame bounding boxes
        if bboxes~=zeros(4,4) % check if there is at least one box
            handsDataset.path{counter}=path;
            handsDataset.hands{counter}=bboxes;
            for d=4:-1:1
                if handsDataset.hands{counter}(d,:)==zeros(1,4)
                    handsDataset.hands{counter}(d,:)=[];
                end
            end
            counter = counter + 1;
        else
            % do nothing % debug
        end
    end
end
handsData.path=handsDataset.path';
handsData.hands=handsDataset.hands';

data=struct2table(handsData);

save(out_file, 'data');


function path = get_path(video_id, frame_num)
    % get path to file from video_id and frame_num
    default_path = 'dataset_egohands/_LABELLED_SAMPLES/%s/frame_%04d.jpg';
    path = sprintf(default_path, video_id, frame_num);
end