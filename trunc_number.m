function result = trunc_number(number_array)
    len = length(number_array);
    first_non_zero = false;
    left = 0; right = 0;
    for m = 1:len
        if first_non_zero == false && number_array(m) ~= 0
            left = m;
            first_non_zero = true;
        end            
        if number_array(m) ~= 0
            right = m;
        end
    end
    result = number_array(left:right);
    if sum(result) ~= 0
        result = result / sum(result);
    end
end