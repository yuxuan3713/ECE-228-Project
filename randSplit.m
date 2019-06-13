function [dTrain, labelTrain, dVal, labelVal] = randSplit(data, label, percentage)
%     assert length(data) == length(label);
    [numData, numFeature] = size(data);
    rp = randperm(numData);
    numTrain = round(numData * percentage);
    
    dTrain = zeros(numTrain, numFeature);
    labelTrain = zeros(numTrain, 1);
    dVal = zeros(numData - numTrain, numFeature);
    labelVal = zeros(numData - numTrain, 1);
    
    for i = 1 : numTrain
        dTrain(i, :) = data(rp(i),:);
        labelTrain(i,:) = label(rp(i));
    end
    
    for i = numTrain + 1 : numData
        dVal(i - numTrain, :) = data(rp(i),:);
        labelVal(i - numTrain, :) = label(rp(i),:);
        
    end
    

end