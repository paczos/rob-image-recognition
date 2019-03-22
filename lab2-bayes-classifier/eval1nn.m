function errcf = eval1nn(ts, test)
% performs leave one test of cls1nn classifier on ts
% ts - trainingset; first column contains class label
% errcf = error coefficient

    res = zeros(rows(test), 1);

    for i=1:rows(test)
        res(i) = cls1nn(ts, test(i, 2:end));
    end

    errcf = mean(res ~= test(:, 1));
end

