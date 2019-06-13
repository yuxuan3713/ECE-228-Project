% use 40 features from mfcc, use the whole file as a single frame
function coeff = wav2mfcc2(filePath)
    [y, Fs] = audioread(filePath);
    y = y(:, 1);
    
    
    coeff = mfcc(y, Fs, 'NumCoeffs', 29);
    coeff = mean(coeff)';
%     coeff = reshape(coeff, [], 1);
%     disp(size(coeff));
    
%     if size(coeff) >= 398 * 14
%         coeff = coeff(1 : 398*14);
%     else
%         coeff = repeat_padding(coeff, 398 * 14);
%     end

end