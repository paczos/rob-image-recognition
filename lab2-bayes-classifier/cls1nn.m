function label = cls1nn(ts, x)
% 1- NN classifier 
% ts training set; first column contains class label
% x - sample to be classified (without label)
% label - class label of x's nearest neighbour

    tvals = ts(:, 2:end);
    x = repmat(x, rows(ts),1);
    [min_v min_i] = min(sqrt(sum((tvals - x).^2, 2)));
    label = ts(min_i, 1);

end


