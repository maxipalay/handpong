%% Creating a YOLOv2 Object detection network from pretrained classifier

inputSize = [300 300 3]; % Specify the image input size for networks
% Load training dataset
training_data = load('full_dataset_training.mat');
training_data = training_data.trainingData;
imdsTrain = imageDatastore(training_data{:,'path'});
bldsTrain = boxLabelDatastore(training_data(:,'hands'));
% Combine image and box label datastores.
trainingData = combine(imdsTrain,bldsTrain);
% transform data
preprocessedTrainingData = transform(trainingData,@(data)preprocessData(data,inputSize));

%% YOLOv2
% Creating a YOLOv2 Object detection network from pretrained classifier
% follows example from https://es.mathworks.com/help/vision/ref/yolov2layers.html
network = mobilenetv2(); % Se puede probar con otras, hay que cambiar la featureLayer
numClasses = 1; % Specify the classes to detect.
featureLayer = 'block_12_add';%layer 113
% Estimate the anchor boxes using the boxLabelDatastore object.
numAnchors = 3;
[anchorBoxes,meanIoU] = estimateAnchorBoxes(preprocessedTrainingData,numAnchors)
lgraph = yolov2Layers(inputSize,numClasses,anchorBoxes,network,featureLayer); % Create the YOLO v2 object detection network. The network is returned as a LayerGraph object.
%analyzeNetwork(lgraph) % Visualize the network using the network analyzer.
save('untrained_networks/YOLOv2_mobilenetv2_untrained', 'lgraph')


%% VER
% Ver que son las anchor boxes y como se eligen https://es.mathworks.com/help/vision/ug/anchor-boxes-for-object-detection.html
% https://es.mathworks.com/help/vision/examples/estimate-anchor-boxes-from-training-data.html

%% 

function data = preprocessData(data,targetSize)
% Resize image and bounding boxes to the targetSize.
scale = targetSize(1:2)./size(data{1},[1 2]);
data{1} = imresize(data{1},targetSize(1:2));
data{2} = bboxresize(data{2},scale);
end