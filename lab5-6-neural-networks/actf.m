function res = actf(tact)
% sigmoid activation function
% tact - total activation

res = 2 ./ (1 + exp(tact));