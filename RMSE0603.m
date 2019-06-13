function [rmse] = RMSE0603(path)
    n = 100;
    [y, ~] = audioread(path);
    mono = y(1:end,1); %Left channel
    mono = repeat_padding(mono, 200000);
    step = floor(size(mono, 1) / (3 * n + 1)) * 3;
    start = 1;
    rmse = zeros(n, 1);
    for i=1:n
        rmse(i) = rms(mono(start:(start + step - 1), 1));
        start = start + step;
    end
end