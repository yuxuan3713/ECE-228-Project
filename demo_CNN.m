% %% Load data
% 
% DatasetPath = fullfile('/Users/liuyuxuan/Downloads/urban-sound-classification/train/Train');
% 
% %wave = datastore(DatasetPath,'ReadFcn',@wav2fft,'Type','file','FileExtensions', '.wav');
% wave = imageDatastore(DatasetPath,'ReadFcn',@wav2fft2,'FileExtensions', '.wav');
% 
% %% create Labels for datastore
% [numFiles , ~] = size(wave.Files);
% Labels = [];
% for i = 1 : numFiles
%     [~,name,~] = fileparts(wave.Files{i});
%     if class(id == str2num(name)) == 'car_horn' || class(id == str2num(name)) == 'gun_shot'
%         disp('aha');
%     else
%         Labels = [Labels; class(id == str2num(name))];
%     end
% end
% 
% wave.Labels = Labels;

%% Using 8k dataset

DatasetPath = fullfile('/Users/liuyuxuan/Downloads/228dataset/Sound8K/');
wave = imageDatastore(DatasetPath,...
    'ReadFcn',@RMSE0603,...
    'FileExtensions', '.wav',...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');

%% Specify Training and Validation Sets
% labelCount = countEachLabel(wave);

[wavTrain,wavValidation] = splitEachLabel(wave,0.8,'randomize');

%% Define Network Architecture

% maxFreq = 500;

maxFeatures = 100;

%maxFeatures = 398 * 14;

layers = [
    imageInputLayer([maxFeatures 1 1])
    
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    %maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    %maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];




% Specify Training Options

options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',10, ...%4
    'Shuffle','every-epoch', ...
    'ValidationData',wavValidation, ...
    'ValidationFrequency',30, ...%30
    'Verbose',false, ...
    'Plots','training-progress',...
    'ExecutionEnvironment','parallel');




%% Train CNN Using Training Data

net = trainNetwork(wavTrain,layers,options);

