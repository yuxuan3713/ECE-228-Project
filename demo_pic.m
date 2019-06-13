%% options 


%% Load data

DatasetPath = fullfile('/Users/liuyuxuan/Downloads/spectrogram');

%wave = datastore(DatasetPath,'ReadFcn',@wav2fft,'Type','file','FileExtensions', '.wav');
wave = imageDatastore(DatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames');


%% Specify Training and Validation Sets
labelCount = countEachLabel(wave);
numTrainFiles = 200;
[wavTrain,wavValidation] = splitEachLabel(wave,numTrainFiles,'randomize');

%% Define Network Architecture

layers = [
    imageInputLayer([217 223 3])
    
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
    'MaxEpochs',4, ...%4
    'Shuffle','every-epoch', ...
    'ValidationData',wavValidation, ...
    'ValidationFrequency',30, ...%30
    'Verbose',false, ...
    'Plots','training-progress',...
    'ExecutionEnvironment','parallel');

%% Train Network Using Training Data

net = trainNetwork(wavTrain,layers,options);