%% LSTM layers and options

inputSize = 187;
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
    'ExecutionEnvironment','auto');

Labels = zeros(8732,1);
for i = 1 : 8732
    for j = 1: 10
        if combinedLabels(i,j) == 1
            Labels(i) = j;
            break;
        end
    end
end

Labels = categorical(Labels);
Data = cell(length(combinedFeatures),1);
for i = 1 : length(combinedFeatures)
    Data{i} = combinedFeatures(i,:)';

end

%% Train LSTM
net = trainNetwork(Data,Labels,LSTM_layers,options);