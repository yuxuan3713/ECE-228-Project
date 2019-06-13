function coeff = wav2mfcc(filePath)
    [y, Fs] = audioread(filePath);
    y = y(:, 1);
    
    
    coeff = mfcc(y, Fs, 'NumCoeffs', 13);
    
    coeff = reshape(coeff, [], 1);
    
    if size(coeff) >= 398 * 14
        coeff = coeff(1 : 398*14);
    else
        coeff = repeat_padding(coeff, 398 * 14);
    end

end