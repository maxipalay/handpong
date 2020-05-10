%% Evaluate detector using test set
% this code follows a tutorial on 
% https://es.mathworks.com/help/deeplearning/ug/object-detection-using-yolo-v2.html

%% Load data
load('full_dataset_evaluation.mat');
inputSize = [300 300 3];
testData = evaluationData;

imdsTest = imageDatastore(testData{:,'path'});
bldsTest = boxLabelDatastore(testData(:,'hands'));

% Combine image and box label datastores.
testData = combine(imdsTest, bldsTest);


%% Preprocess Test Data
preprocessedTestData = transform(testData,@(data)preprocessData(data,inputSize));

%% Load trained network
trainednet = load('trained_networks/YOLOv2_mobilenetv2_trained');
detector=trainednet.detector;


%% Run the detector on all the test images.
detectionResults = detect(detector, preprocessedTestData, 'Threshold', 0.4);
% Evaluate the object detector using average precision metric.
[ap,recall,precision] = evaluateDetectionPrecision(detectionResults, preprocessedTestData);
figure
plot(recall,precision)
xlabel('Recall')
ylabel('Precision')
grid on
title(sprintf('Average Precision = %.2f',ap))

function data = preprocessData(data,targetSize)
% Resize image and bounding boxes to the targetSize.
scale = targetSize(1:2)./size(data{1},[1 2]);
data{1} = imresize(data{1},targetSize(1:2));
data{2} = bboxresize(data{2},scale);
end