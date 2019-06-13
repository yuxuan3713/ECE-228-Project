% Precision changed to 1 Hz
function [X, Fs] = wav2seq(filePath)
    maxFeature = 10000;

    [X, Fs] = audioread(filePath);  % Fs is sampling rate
    X = X(:, 1);  % take one channel from stereo

    % repeat padding X
    X = repeat_padding(X, maxFeature);

end