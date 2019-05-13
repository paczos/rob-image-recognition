function res = actdf(sfvalue)
% derivative of sigmoid activation function
% sfvalue - value of sigmoid activation function (!)
    res = - exp(sfvalue) ./ pow((1+exp(sfvalue)),2);
end