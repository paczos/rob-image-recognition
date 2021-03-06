% mainscript is rather short this time
% primary component count
pkg load statistics
comp_count = 80;

[tvec tlab tstv tstl] = readSets(); 

% let's look at the first digit in the training set
% imshow(1-reshape(tvec(1,:), 28, 28)');

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
% I would use 10 first zeros and 10 first ones
% and only 2 first primary components
% It'll allow printing of intermediate results in perceptron function

%
% YOUR CODE GOES HERE - testing of the perceptron function
sprintf("perceptron tests")
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

[idx ] = kmeans(tvec, 3);
tabulate(tlab(idx==1))
tabulate(tlab(idx==2))
tabulate(tlab(idx==3))


% training of the whole ensemble
ovo = trainOVOensamble(tvec, tlab, @perceptron);

% check your ensemble on train set
sprintf("cannonical ensemble on train set")
clab = unamvoting(tvec, ovo);
cfmx = confMx(tlab, clab)
compErrors(cfmx)

% repeat on test set
sprintf("cannonical ensemble on test set")
clab = unamvoting(tstv, ovo);
cfmx = confMx(tstl, clab)
compErrors(cfmx)

%
% YOUR CODE GOES HERE

% classifier may start to oscilate around some local solution
% it's worth starting with some easy to distinguish digits, e.g. 1 and 0. On the other hand, among the most difficult are 3 and 5

% when the perceptron is ready, try to achieve some minor improvement for individual classifier
% improvement of 1.5% can be treated as good enough


g0 = [0 1 2 3 5 8];

g1 = [4 6];

g2 = [7 9];

% increase by one because we had shifted numbers by one to make indexing easier
g0 += 1;
g1 += 1;
g2 += 1;

g0sel = ismember(tlab, g0);
g0tlab = tlab(g0sel, :);
g0tvec = tvec(g0sel, :);

g1sel = ismember(tlab, g1);
g1tlab = tlab(g1sel, :);
g1tvec = tvec(g1sel, :);

g2sel = ismember(tlab, g2);
g2tlab = tlab(g2sel, :);
g2tvec = tvec(g2sel, :);

% using custom labels for groups so we can train group classifiers treating items belonging to one group as the same
gtlab = [ones(rows(g0tlab), 1); ones(rows(g1tlab), 1)+1; ones(rows(g2tlab), 1)+2];
gtflab = [g0tlab; g1tlab; g2tlab];
gtvec = [g0tvec; g1tvec; g2tvec];

govo = trainOVOensamble(gtvec, gtlab, @perceptron);

% check group ensemble on train set

% run ensemble to split into groups
gclab = unamvoting(gtvec, govo);
sprintf("group classifiers results")
gcfmx = confMx(gtlab, gclab)

compErrors(gcfmx)

% extract cannonical ovo classifiers analogous to the items of groups and use them to classify numbers within groups

ovo0 = extrGroupFromEnsemble(ovo, g0);
tvec0 = gtvec(gclab==1,:);
g0clab = unamvoting(tvec0, ovo0, 11);
g0clabfr = castToFullRange(g0clab, g0);
sprintf("groupgtvec 0 results")
g0confMx = confMx(gtflab(gclab==1), g0clabfr)
compErrors(g0confMx)

ovo1 = extrGroupFromEnsemble(ovo, g1);
tvec1 = gtvec(gclab==2, :);
g1clab = unamvoting(tvec1, ovo1, 11);
g1clabfr = g1clab;
sprintf("group 1 results")
g1confMx = confMx(gtflab(gclab==2), g1clabfr)
compErrors(g1confMx)

sprintf("group 2 results")
ovo2 = extrGroupFromEnsemble(ovo, g2);
tvec2 = gtvec(gclab==3, :);
g2clab = unamvoting(tvec2, ovo2, 11);
g2clabfr = g2clab;
sprintf("group 2 results")
g2confMx = confMx(gtflab(gclab==3), g2clabfr)
compErrors(g2confMx)

% use original ensemble to classify numbers for which these modified ensembles were inconclusive
tvec3 = gtvec(gclab==4,:);
g3clab = unamvoting(tvec3, ovo);
g3confMx = confMx(gtflab(gclab==4), g3clab)

sprintf("results using grouping")
gconfMx = g0confMx + g1confMx + g2confMx + g3confMx;
compErrors(gconfMx)

