% Training of YOLOv2 network
% This training follows the tutorial on:
% https://es.mathworks.com/help/deeplearning/ug/object-detection-using-yolo-v2.html
% The code provided in the tutorial has suffered some changes

%% Load data
% we know data has already been shuffled
training_data = load('full_dataset_training.mat');
training_data = training_data.trainingData;
validation_data = load('full_dataset_validation.mat');
validation_data = validation_data.validationData;

inputSize = [300 300 3]; % input size of the network

% Use imageDatastore and boxLabelDatastore to load the image and label 
% data during training and evaluation.
imdsTrain = imageDatastore(training_data{:,'path'});
bldsTrain = boxLabelDatastore(training_data(:,'hands'));

imdsValidation = imageDatastore(validation_data{:,'path'});
bldsValidation = boxLabelDatastore(validation_data(:,'hands'));

% Combine image and box label datastores.
trainingData = combine(imdsTrain,bldsTrain);
validationData = combine(imdsValidation, bldsValidation);

% Display one of the training images and box labels.
data = read(trainingData);
I = data{1};
bbox = data{2};
annotatedImage = insertShape(I,'Rectangle',bbox);
annotatedImage = imresize(annotatedImage,2);
figure
imshow(annotatedImage)

%% Augment Training Data
% Use transform to augment the training data by randomly flipping the 
% image and associated box labels horizontally. Note that data augmentation 
% is not applied to the test and validation data. Ideally, test and 
% validation data should be representative of the original data and is 
% left unmodified for unbiased evaluation.
augmentedTrainingData = transform(trainingData,@augmentData);
% Read the same image multiple times and display the augmented training 
% data.
% Visualize the augmented images.
augmentedData = cell(4,1);
for k = 1:4
    data = read(augmentedTrainingData);
    augmentedData{k} = insertShape(data{1},'Rectangle',data{2});
    reset(augmentedTrainingData);
end
figure
montage(augmentedData,'BorderSize',10)

%% Preprocess Training Data
preprocessedTrainingData = transform(augmentedTrainingData,@(data)preprocessData(data,inputSize));
preprocessedValidationData = transform(validationData,@(data)preprocessData(data,inputSize));
% Read the preprocessed training data.
data = read(preprocessedTrainingData);
%
I = data{1};
bbox = data{2};
annotatedImage = insertShape(I,'Rectangle',bbox);
annotatedImage = imresize(annotatedImage,2);
figure
imshow(annotatedImage)

%% load nn
untrainednet = load('untrained_networks/YOLOv2_mobilenetv2_untrained.mat');
lgraph=untrainednet.lgraph;

%% Train Object Detector
% Use trainingOptions to specify network training options. 
options = trainingOptions('sgdm', ...
    'MiniBatchSize',64, 'VerboseFrequency',1, 'MaxEpochs', 1, ...
    'InitialLearnRate', 0.001,'ValidationData', preprocessedValidationData, ...
    'ValidationFrequency', 10, 'Shuffle', 'every-epoch', ...
    'LearnRateSchedule','piecewise', 'LearnRateDropFactor',0.1, ...
    'LearnRateDropPeriod',10,'GradientThreshold',100);
    %'ExecutionEnvironment', 'parallel', ...

[detector, info] = trainYOLOv2ObjectDetector(preprocessedTrainingData,lgraph,options);
save('trained_networks/YOLOv2_mobilenetv2_trained','detector')

function data = preprocessData(data,targetSize)
% Resize image and bounding boxes to the targetSize.
scale = targetSize(1:2)./size(data{1},[1 2]);
data{1} = imresize(data{1},targetSize(1:2));
data{2} = bboxresize(data{2},scale);
end

function B = augmentData(A)
% Apply random horizontal flipping, and random X/Y scaling. Boxes that get
% scaled outside the bounds are clipped if the overlap is above 0.25. Also,
% jitter image color.
B = cell(size(A));

I = A{1};
sz = size(I);
if numel(sz)==3 && sz(3) == 3
    I = jitterColorHSV(I,...
        'Contrast',0.2,...
        'Hue',0,...
        'Saturation',0.1,...
        'Brightness',0.2);
end

% Randomly flip and scale image.
tform = randomAffine2d('XReflection',true,'Scale',[1 1.1]);
rout = affineOutputView(sz,tform,'BoundsStyle','CenterOutput');
B{1} = imwarp(I,tform,'OutputView',rout);

% Apply same transform to boxes.
[B{2},indices] = bboxwarp(A{2},tform,rout,'OverlapThreshold',0.25);
B{3} = A{3}(indices);

% Return original data only when all boxes are removed by warping.
if isempty(indices)
    B = A;
end
end