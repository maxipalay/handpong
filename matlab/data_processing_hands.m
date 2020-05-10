% process training data of dataset
% Straightens up bounding boxes of hands
% generates output file

out_file = 'data_hands.mat'; % name of output_file

uf = dir('dataset_hands/training_dataset/training_data/images/*.jpg');
%figure
counter = 1;
for i = 1000:length(uf)
    dot = strfind(uf(i).name,'.');
    imname = uf(i).name(1:dot-1);
    load(['dataset_hands/training_dataset/training_data/annotations/' imname '.mat']);
    im = imread(['dataset_hands/training_dataset/training_data/images/' uf(i).name]);
    bboxes = [];
    for j = 1:length(boxes)
        box = boxes{j};
        points_x = [box.a(2) box.b(2) box.c(2) box.d(2)];
        points_y = [box.a(1) box.b(1) box.c(1) box.d(1)];
        min_x = floor(min(points_x));
        if min_x<0
            min_x=0;
        end
        
        min_y = floor(min(points_y));
        if min_y<0
            min_y=0;
        end
        
        max_x = floor(max(points_x));
        max_y = floor(max(points_y));
        bbox = [min_x min_y max_x-min_x max_y-min_y];
        if bbox(1)+bbox(3)>size(im,2)
            bbox = zeros(4,1);
        end
        if bbox(2)+bbox(4)>size(im,1)
            bbox = zeros(4,1);
        end
        %im = insertObjectAnnotation(im,'rectangle',bbox,'1');
        if bbox~=zeros(4,1)    
            bboxes = [bboxes;bbox];
        end
    end
    if ~isempty(bboxes)
        handsDataset.path{counter}=sprintf('dataset_hands/training_dataset/training_data/images/%s',uf(i).name);
        handsDataset.hands{counter}=bboxes;
        counter=counter+1;
    end
    
    %imshow(im);
    %disp('Press any key to move onto the next image');pause;
end

hands.path=handsDataset.path';
hands.hands=handsDataset.hands';

data=struct2table(hands);

save(out_file, 'data');