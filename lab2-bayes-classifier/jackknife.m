function errcf = jackknife(ts)
% performs leave one test of cls1nn classifier on ts
% ts - trainingset; first column contains class label
% errcf = error coefficient
    res = zeros(rows(ts), 1);

    for i=1:rows(ts)
        res(i) = cls1nn(ts([1:i-1 i+1:end], :), ts(i, 2:end));
    end
    errcf = mean(res ~= ts(:, 1));

end

