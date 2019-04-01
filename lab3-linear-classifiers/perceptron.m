function [sepplane posmiss negmiss] = perceptron(pclass, nclass)
% Computes separating plane (linear classifier) using
% perceptron method.
% pclass - 'positive' class (one row contains one sample)
% nclass - 'negative' class (one row contains one sample)
% Output:
% sepplane - row vector of separating plane coefficients
% posmiss - number (coefficient) of misclassified samples of pclass
% negmiss - number (coefficient) of misclassified samples of nclass

  sepplane = rand(1, columns(pclass) + 1) - 0.5;
  nPos = rows(pclass); % number of positive samples
  nNeg = rows(nclass); % number of negative samples
  tset = [ ones(nPos, 1) pclass; -ones(nNeg, 1) -nclass]; % denormalizowane dane, 
  lrate = @(iteration) 1/(1+iteration);
  i = 1;
  do 
	%%% YOUR CODE GOES HERE %%%
	%% You should:
	%% 1. Check which samples are misclassified (boolean column vector)
	misclassified = dot(repmat(sepplane,rows(tset),1), tset,2) < 0; % these are missclassified samples
	%% 2. Compute separating plane correction
	%%		This is sum of misclassfied samples coordinate times learning rate
	correction = lrate(i)*sum(tset(misclassified, :));
	%% 3. Modify solution (i.e. sepplane)
    sepplane = sepplane+correction;
	%% 4. Optionally you can include additional conditions to the stop criterion
	%%		200 iterations can take a while and probably in most cases is unnecessary
	% TODO: ADD OPTIMIZATION
	++i;
  until i > 200;

  %%% YOUR CODE GOES HERE %%%
  %% You should:
  %% 1. Compute the numbers (coefficients) of misclassified positive 
  %%    and negative samples
  res = dot(repmat(sepplane,rows(tset),1), tset,2);
  miss = res < 0;
  nPos
  nNeg
  posmiss = rows(tset(tset(miss==1, 1)==1))/nPos
  negmiss = rows(tset(tset(miss==1, 1)==-1))/nNeg
