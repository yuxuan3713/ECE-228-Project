function [rmse] = wav2rmse(path)
    n = 100;
    [y, Fs] = audioread(path);
    mono = y(:,1); %Left channel
    mono = repeat_padding(mono, 5000);
    step = floor(size(mono, 1) / (n + 1));
    start = 1;
    rmse = zeros(n, 1);
    for i=1:n
        rmse(i) = rms(mono(start:(start + 2 * step - 1), 1));
        start = start + step;
    end
end
