s = zeros(4899,2);
for i = 1 : 4899
    s(i,:) = size(mfcc_wav(wave.Files{i}, ));
end