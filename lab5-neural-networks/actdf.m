function res = actdf(sfvalue)
% derivative of sigmoid activation function
% sfvalue - value of sigmoid activation function (!)

% TODO: derivative of the activation function(sigmoid)
	res = zeros(size(sfvalue));
res = - exp(sfvalue) ./ (1+exp(sfvalue));