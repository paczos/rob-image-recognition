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


parts = partitions(10);
bestSuccess = 0;
bestGroup = [];
for p=1:size(parts, 1)

    groups = parts{p};
 fflush(stdout)

    sprintf("this partition has %d groups", columns(groups) )
    gtlab = [];
    gtflab = [];
    gtvec = [];

    groupMoreThan2 = true;

     for g=1:columns(groups)
        group  =  groups{g};
        if columns(group) < 2
           groupMoreThan2=false;
        end
        partgsel = ismember(tlab, group);
        partgtlab = tlab(partgsel, :);
        partgtvec = tvec(partgsel, :);

        gtlab = [gtlab; zeros(rows(partgtlab),1)+g];
        gtflab = [gtflab; partgtlab];
        gtvec = [gtvec; partgtvec];
     end

     if unique(gtlab)<2 | groupMoreThan2==false
        % we do not care about grouping into a single group
        continue
     end
     govo = trainOVOensamble(gtvec, gtlab, @perceptron);

    % check group ensemble on train set


    % run ensemble to split into groups
    gclab = unamvoting(gtvec, govo);

    sprintf("group classifiers results")
    gcfmx = confMx(gtlab, gclab)
    e =  compErrors(gcfmx)
    if e(1)> bestSuccess
    sprintf("found new best grouping")
    bestSuccess=e(i)
    bestGroup = groups

    end
    if e(1)
    if (e(1)<0.9)
    continue
    end


    summaryConfMx = zeros(10,11);


    % extract cannonical ovo classifiers analogous to the items of groups and use them to classify numbers within groups
    for g=1:columns(groups);
            group  =  groups{g};
        ovo0 = extrGroupFromEnsemble(ovo, group);
        tvec0 = gtvec(gclab==g,:);
        g0clab = unamvoting(tvec0, ovo0, 11);
        g0clabfr = castToFullRange(g0clab, group);
        sprintf("group 0 results")
        g0confMx = confMx(gtflab(gclab==g), g0clabfr)
        compErrors(g0confMx)
        summaryConfMx = summaryConfMx+g0confMx;
    end


    sprintf("results using grouping")
    sprintf("groups:")
    groups
    sprintf("conf mx and results:")

    summaryConfMx
    compErrors(summaryConfMx)


end