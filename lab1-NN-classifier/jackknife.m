function errcf = jackknife(ts)
% performs leave one test of cls1nn classifier on ts
% ts - trainingset; first column contains class label
% errcf = error coefficient
res = zeros(rows(ts), 1)

for i:rows(ts)
res(i) = cls1nn(ts([(i-1):i (i+1):end], :), ts(i, 22:))
end

errcf = mean(clsres ~= ts(:, 1));

end

