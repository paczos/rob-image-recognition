function res = actdf(sfvalue)
% derivative of sigmoid activation function
% sfvalue - value of sigmoid activation function (!)
    res = - exp(sfvalue) ./ ((1+exp(sfvalue)).^2);
end