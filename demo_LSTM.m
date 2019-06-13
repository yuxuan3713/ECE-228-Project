%% Using 8k dataset
DatasetPath = fullfile('/Users/liuyuxuan/Downloads/228dataset/Sound8K/');
wave = imageDatastore(DatasetPath,...
    'ReadFcn',@wav2mfcc2,...
    'FileExtensions', '.wav',...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');


%% Specify Training and Validation Sets

percentage_separate = 0.8;
[wavTrain,wavValidation] = splitEachLabel(wave,percentage_separate,'randomize');

%% read data into memory

trainData = readall(wavTrain); 
valData = readall(wavValidation);

%% LSTM layers and options

inputSize = 30; % modify wa2seq also
numHiddenUnits = 100;
numClasses = 10;

LSTM_layers = [ ...
    sequenceInputLayer(inputSize)
    bilstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

maxEpochs = 50;
miniBatchSize = 27;

options = trainingOptions('adam', ...
    'ExecutionEnvironment','cpu', ...
    'GradientThreshold',1, ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'SequenceLength','longest', ...
    'Shuffle','never', ...
    'Verbose',0, ...
    'Plots','training-progress',...
    'ValidationData',{valData,wavValidation.Labels});


%% Train LSTM
net = trainNetwork(trainData,wavTrain.Labels,LSTM_layers,options);
