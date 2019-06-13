load('svm_result3.mat');
gamma = [2^-11, 2^-9, 2^-7, 2^-5, 2^-3, 2^-1, 2^1, 2^3, 2^5, 2^7, 2^9, 2^11, 2^13, 2^15, 2^17, 2^19, 2^21];
C = [2^-4, 2^-1, 2^1, 2^3, 2^5, 2^7, 2^9, 2^11, 2^13, 2^15, 2^17, 2^19, 2^21, 2^23, 2^25, 2^27, 2^29];


num_g = numel(gamma);
num_c = numel(C);

% Z = zeros(num_c, num_g,1);
% 
% Z(1:8,1:6) = svm_result1;
% Z(9:13, 7:11) = svm_result2;


surf(gamma, C, svm_result)

set(gca,'XScale','log')
set(gca,'yScale','log')

xlabel('Gamma')
ylabel('C')
zlabel('Accuracy(%)')

title('SVM linear kernal parameter vs accuracy')