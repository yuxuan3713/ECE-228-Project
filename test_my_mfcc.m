%% load 8k dataset

DatasetPath = fullfile('/Users/liuyuxuan/Downloads/228dataset/Sound8K/');
wave = imageDatastore(DatasetPath,...
    'ReadFcn',@wav2mfcc,...
    'FileExtensions', '.wav',...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');

%% Specify Training and Validation Sets
% labelCount = countEachLabel(wave);

[wavTrain,wavValidation] = splitEachLabel(wave,0.8,'randomize');


%% read and transform data


N_train = length(wavTrain.Files); % number of data points
M_train = feature_count; % number of features per data point

rawData_train = zeros(N_train,M_train);
for i = 1 : N_train
    rawData_train(i,:) = read(wavTrain);
end

N_val = length(wavValidation.Files); % number of data points
M_val = feature_count; % number of features per data point

rawData_val = zeros(N_val,M_val);
for i = 1 : N_val
    rawData_val(i,:) = read(wavValidation);
end