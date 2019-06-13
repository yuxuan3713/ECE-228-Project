%% Using 8k dataset

DatasetPath = fullfile('/Users/liuyuxuan/Downloads/228dataset/Sound8K/');
wave = imageDatastore(DatasetPath,...
    'ReadFcn',@wav2fft3,...
    'FileExtensions', '.wav',...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');


%% read raw data
feature_count = 2000;

percentage_separate = 0.8;
[wavTrain,wavValidation] = splitEachLabel(wave,percentage_separate,'randomize');
%put full raw data into n * p matrix, each row is a observation

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

%% test pca

[coeff_train,score_train,latent_train,tsquared_train,explained_train,mu_train] = pca(rawData_train);
[coeff_val,score_val,latent_val,tsquared_val,explained_val,mu_val] = pca(rawData_val);

%% find how many dimension needed
threshold = 95; % percentage of explained vairance threshold
reduced_dimension = 0;
for i = 1 : feature_count
    if sum(explained_train(1:i)) > threshold
        reduced_dimension = i;
        break;
    end
end
%% reduce data dimension
reduced_data_train = score_train * coeff_train'; % reduced data
reduced_data_train = reduced_data_train(:, 1:reduced_dimension);

reduced_data_val = score_val * coeff_val'; % reduced data
reduced_data_val = reduced_data_val(:, 1:reduced_dimension);


%% create label and reshape data
Xtrain = reshape(reduced_data_train, [reduced_dimension 1 1 N_train]);
Ytrain = wavTrain.Labels;

Xval = reshape(reduced_data_val, [reduced_dimension 1 1 N_val]);
Yval = wavValidation.Labels;

%% test network

maxFeatures = reduced_dimension;

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
    'MaxEpochs',20, ...%4
    'Shuffle','every-epoch', ...
    'Verbose',false, ...
    'Plots','training-progress',...
    'ValidationData',{Xval,Yval},...
    'ExecutionEnvironment','parallel');

net = trainNetwork(Xtrain,Ytrain,layers,options);

% %% predict
% 
% YPred = classify(net,Xval);
% accuracy = sum(YPred == Yval)/numel(Yval);
% disp(accuracy);
