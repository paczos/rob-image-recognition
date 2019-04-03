% mainscript is rather short this time
% primary component count
comp_count = 80; 

[tvec tlab tstv tstl] = readSets(); 

% let's look at the first digit in the training set
%imshow(1-reshape(tvec(1,:), 28, 28)');

% let's check labels in both sets
[unique(tlab)'; unique(tstl)']

% compute and perform PCA transformation
[mu trmx] = prepTransform(tvec, comp_count);
tvec = pcaTransform(tvec, mu, trmx);
tstv = pcaTransform(tstv, mu, trmx);

% let's shift labels by one to use labels directly as indices
tlab += 1;
tstl += 1;

% To successfully prepare ensemble you have to implement perceptron function
% I would use 10 first zeros and 10 fisrt ones 
% and only 2 first primary components
% It'll allow printing of intermediate results in perceptron function

%
% YOUR CODE GOES HERE - testing of the perceptron function

fprintf("\n|plabel|nlabel|posmiss|negmiss|\n")
fprintf("|---|---|---|---|\n")
pairs = nchoosek(1:10, 2);
for i=1:rows(pairs)
    p = pairs(i, 1);
    n = pairs(i, 2);
    plab = tlab == p;
    toptenzeros = (tvec(plab, :))(:, [n p]);

    nlab = tlab == n;
    toptenones = (tvec(nlab, :))(:, [n p]);

    [sepplane posmiss negmiss] = perceptron(toptenzeros, toptenones);
    fprintf("|%d|%d|%f|%f|\n", p-1, n-1, posmiss, negmiss)
end


% training of the whole ensemble
ovo = trainOVOensamble(tvec, tlab, @perceptron);

% check your ensemble on train set
clab = unamvoting(tvec, ovo);
cfmx = confMx(tlab, clab)
compErrors(cfmx)

% repeat on test set
clab = unamvoting(tstv, ovo);
cfmx = confMx(tstl, clab)
compErrors(cfmx)

%
% YOUR CODE GOES HERE

% classifier may start to oscilate around some local solution
% it's worth starting with some easy to distinguish digits, e.g. 1 and 0. On the other hand, among the most difficult are 3 and 5

% when the perceptron is ready, try to achieve some minor improvement for individual classifier
% improvement of 1.5% can be treated as good enough

