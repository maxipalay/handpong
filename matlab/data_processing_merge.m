% merge data from all datasets, shuffle it and split it into training data, validation
% data and evaluation

% output files names
out_file_training = 'full_dataset_training_2.mat'; % name of output_file
out_file_validation = 'full_dataset_validation_2.mat'; % name of output_file
out_file_evaluation = 'full_dataset_evaluation_2.mat'; % name of output_file

% select percentages of whole dataset to assign for training, validation
% and evaluation
training_data_percentage = 0.8;
validation_data_percentage = 0.1;
% evaluation_data_percentage = 0.1; % obvio

% Load data
data_ego = load('data_egohands.mat');
data_ego = data_ego.data;
data_maxihands = load('data_maxihands.mat');
data_maxihands = data_maxihands.data;
data_hands = load('data_hands.mat');
data_hands = data_hands.data;
% merge all data
dataset = [data_ego;data_maxihands;data_hands];

% mix all data
shuffledIndices = randperm(height(dataset)); % random permutations
idx1 = floor(training_data_percentage * length(shuffledIndices)); % first index of cut
idx2 = floor((training_data_percentage+validation_data_percentage) * length(shuffledIndices)); % second index of cut

trainingData = dataset(shuffledIndices(1:idx1),:);
validationData = dataset(shuffledIndices(idx1+1:idx2),:);
evaluationData = dataset(shuffledIndices(idx2+1:length(shuffledIndices)),:);

% save files
save(out_file_training, 'trainingData');
save(out_file_validation, 'validationData');
save(out_file_evaluation, 'evaluationData');



