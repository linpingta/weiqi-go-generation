function result = normalize_number(number_array,K)
    len = length(number_array);
    interval = double(len) / K;
    for k = 1:K
        result(k) = sum(number_array(ceil((k - 1) * interval + 0.999):floor(k * interval + 0.999)));
    end   
end