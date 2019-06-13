% Precision changed to 1 Hz
function [P1, Fs] = wav2fft3(filePath)
    maxFreq = 20000; % set max freq to 20k
    precision = 1; % precision to 1 Hz

    [X, Fs] = audioread(filePath);  % Fs is sampling rate
    X = X(:, 1);  % take one channel from stereo

%     T = 1/Fs;             % Sampling period
%     L = length(X);
%     t = (0:L-1)*T;        % Time vector


    % repeat padding X
    need_L = round(Fs / precision);
    X = repeat_padding(X, need_L);
    L = length(X);

    Y = fft(X);

    P2 = abs(Y/L);
    P1 = P2(1:floor(L/2)+1);
    P1(2:end-1) = 2*P1(2:end-1);
    
    
%     if length(P1) < round(maxFreq / precision)
%         P1 = padarray(P1,[round(maxFreq / precision) - length(P1) 0],'post');
%     elseif length(P1) > maxFreq / precision
%         P1 = P1(1:round(maxFreq / precision), :);
%     end

    
%     can add freq vector if needed
    f = Fs*(0:(L/2))/L; % frequency vector
    figure
    plot(f,P1) 
    title('Single-Sided Amplitude Spectrum of X(t)')
    xlabel('f (Hz)')
    ylabel('|P1(f)|')
end