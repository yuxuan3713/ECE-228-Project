function result = repeat_padding(y, len)
    if length(y) >= len
        result = y(1:len);
    else
       assert(~isempty(y));
       
       len_y = length(y);
       result = zeros(len,1);
       
       for i = 1 : floor(len / len_y)
          result(1 + (i-1) * len_y : i * len_y) = y;
       end
       
       if i * len_y < len
          result(1 + i * len_y : len) = y(1 : len - i * len_y);
       end

    end

end