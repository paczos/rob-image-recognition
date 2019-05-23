function [A stds means] = standardize(M, stdsopt, meansopt)
A = zeros(rows(M),columns(M));

    if ~exist('stdsopt','var'), stds = std(M);
    else
        stds = stdsopt;
    end


    if ~exist('meansopt','var'), means = mean(M);
    else
        means = meansopt;
    end


    for i=1:columns(M)
        A(:, i) = (M(:, i)-means(:, i)) ./ stds(:, i);
    end

end