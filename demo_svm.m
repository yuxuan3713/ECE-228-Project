%% Using 8k dataset

DatasetPath = fullfile('/Users/liuyuxuan/Downloads/228dataset/Sound8K/');
wave = imageDatastore(DatasetPath,...
    'ReadFcn',@wav2fft3,...
    'FileExtensions', '.wav',...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');

%% Specify Training and Validation Sets
% labelCount = countEachLabel(wave);

[wavTrain,wavValidation] = splitEachLabel(wave,0.8,'randomize');


%% read all data into memory

% these are the cell arrays
trainData = readall(wavTrain); 
testData = readall(wavValidation);

maxFeatures = 4000;

trainMat = zeros(length(wavTrain.Files),maxFeatures);
trainLabel = double(wavTrain.Labels);
for i = 1 : length(wavTrain.Files)
    trainMat(i,:) = cell2mat(trainData(i));
end

testMat = zeros(length(wavValidation.Files),maxFeatures,'double');
testLabel = double(wavValidation.Labels);
for i = 1 : length(wavValidation.Files)
    testMat(i,:) = cell2mat(testData(i));
end



%% grid search for parameters


C = [ 2^-4, 2^-1, 2^1, 2^3, 2^5, 2^7, 2^9, 2^11,      2^13, 2^15, 2^17, 2^19, 2^21, 2^23, 2^25, 2^27, 2^29];
gamma = [ 2^-11, 2^-9, 2^-7, 2^-5, 2^-3, 2^-1,        2, 2^3, 2^5, 2^7, 2^9, 2^11, 2^13, 2^15, 2^17, 2^19, 2^21]; 


%C = [ 2^13, 2^15, 2^17, 2^19, 2^21];
%gamma = [ 2, 2^3, 2^5, 2^7, 2^9]; 


C_num = numel(C);
g_num = numel(gamma);
svm_result = zeros(C_num, g_num);

for i = 1 : C_num
    parfor j = 1 : g_num
        option = [char("-c " + num2str(C(i)) + " -g " + num2str(gamma(j)) + " -t 2 -v 2") ];
        accuracy = svmtrain(trainLabel, trainMat, option);
        

       svm_result(i,j) = accuracy;

%         if accuracy > bestAccuracy
%             bestAccuracy = accuracy;
%             bestC = C(i);
%             bestGamma = gamma(j);
%         end
        
        %waitbar(((i-1)*6+j)/48,f,num2str(((i-1)*6+j)/48*100) + "%");
        %pause(0.5);
    end
end


%% SVM using single parameter
bestC = 2^21;
bestGamma = 2^9;
option = [char("-c " + num2str(bestC) + " -g " + num2str(bestGamma) + " -t 2 -v 2") ];
model = svmtrain(trainLabel, trainMat, option);
[predicted_label, accuracy, decision_values] = svmpredict(testLabel, testMat, model);