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
  mincorrectionnorm = 5;
  i = 1;
  do 
	misclassified = dot(repmat(sepplane,rows(tset),1), tset,2) < 0; % these are missclassified samples
	correction = lrate(i)*sum(tset(misclassified, :));
    sepplane = sepplane+correction;
	if norm(correction)<mincorrectionnorm
	    sprintf("stopcriterion at %d", i)
	    break
	end
	++i;
  until i > 200;

  res = dot(repmat(sepplane,rows(tset),1), tset,2);
  miss = res < 0;
  nPos
  nNeg
  posmiss = rows(tset(tset(miss==1, 1)==1))/nPos
  negmiss = rows(tset(tset(miss==1, 1)==-1))/nNeg
