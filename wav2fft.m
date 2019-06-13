%% Zero Padding

function [P1, f, Fs] = wav2fft(filePath)
    maxFreq = 500;
    %disp(maxFreq)
    [y, Fs] = audioread(filePath);  % Fs is sampling rate
    y = y(:, 1);    % take one channel from stero

    T = 1/Fs;             % Sampling period       
    [L,~] = size(y);        % Length of signal

    %t = (0:L-1)*T;        % Time vector
    n = 4 * Fs;
    Y = fft(y,n);

    P2 = abs(Y/L);
    P1 = P2(1:int32(L/2)+1);
    P1(2:end-1) = 2*P1(2:end-1);

    f = Fs*(0:(n/2))/n;

    [size_P, ~] = size(P1);
    f = f(1 : min(maxFreq * 4, size_P));

    if size_P < maxFreq * 4
        P1 = padarray(P1,[maxFreq * 4 - size_P 0],'post');
    else if size_P > maxFreq * 4
        P1 = P1(1:maxFreq * 4, :);
    end

    %f = f(2:maxFreq * 4 + 1);
    %assert(f(80000) == 20000, 'Error : Highest freq not 20000 Hz');
    %P1 = P1(1:maxFreq * 4);

    %plot
    % plot(f,P1) 
    % title('Single-Sided Amplitude Spectrum of X(t)')
    % xlabel('f (Hz)')
    % ylabel('|P1(f)|')

    %[size_P, ~] = size(P1);
    %assert(size_P == maxFreq * 4, strcat('wav2fft wrong length at ',filePath))
end