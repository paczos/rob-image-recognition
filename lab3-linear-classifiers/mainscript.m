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

g0 = [3 5 8];
g1 = [4 6 0];
g2 = [1 2 7 9];

% increase by one because we had shifted numbers by one to make indexing easier
g0 += 1;
g1 += 1;
g2 += 1;

g0tlab = tlab(ismember(tlab, g0), :);
g0tvec = tvec(ismember(tlab, g0), :);

g1tlab = tlab(ismember(tlab, g1), :);
g1tvec = tvec(ismember(tlab, g1), :);

g2tlab = tlab(ismember(tlab, g2), :);
g2tvec = tvec(ismember(tlab, g2), :);

% using custom labels for groups so we can train group classifiers treating items belonging to one group as the same
gtlab = [ones(rows(g0tlab), 1); ones(rows(g1tlab), 1)+1; ones(rows(g2tlab), 1)+2];
gtvec = [g0tvec; g1tvec; g2tvec];

govo = trainOVOensamble(gtvec, gtlab, @perceptron);

% check group ensemble on train set
gclab = unamvoting(gtvec, govo);
gcfmx = confMx(gtlab, gclab)
compErrors(gcfmx)

% extract cannonical ovo classifiers analogous to the items of groups

ovo0 = extrGroupFromEnsemble(ovo, g0);
tvec0 = gtvec(gtlab==1,:);
g0clab = unamvoting(tvec0, ovo0);
g0confMx = confMx(tvec0, g0clab);

ovo1 = extrGroupFromEnsemble(ovo, g1);
tvec1 = gtvec(gtlab==2,:);
g1clab = unamvoting(tvec0, ovo1);
g1confMx = confMx(tvec1, g1clab);

ovo2 = extrGroupFromEnsemble(ovo, g2);
tvec2 = gtvec(gtlab==3,:);
g2clab = unamvoting(tvec2, ovo2);
g2confMx = confMx(tvec2, g2clab);

% use classic enseble to classify remaining numbers

tvec3 = gtvec(gtlab==4,:);
g3clab = unamvoting(tvec3, ovo);
g3confMx = confMx(tvec3, g3clab);

gconfMx = g0confMx+g1confMx+g2confMx+g3confMx;
compErrors(gconfMx)




