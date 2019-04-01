% mainscript is rather short this time

% primary component count
comp_count = 80; 

[tvec tlab tstv tstl] = readSets(); 

% let's look at the first digit in the training set
imshow(1-reshape(tvec(1,:), 28, 28)');

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

tzerolab = tlab == 1;
toptenzeros = (tvec(tzerolab, :))(1:10, 1:2);

tonelab = tlab == 2;
toptenones = (tvec(tonelab, :))(1:10, 1:2);

perceptron(toptenzeros, toptenones)


tthreelab = tlab == 4;
toptenthrees= (tvec(tthreelab, :))(1:10, 1:2);

tfivelab = tlab == 6;
toptenfives = (tvec(tfivelab, :))(1:10, 1:2);

perceptron(toptenthrees, toptenfives)

%full set

perceptron(tthreelab, tfivelab)


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




% wyciągnac pierwsze 10 zer 10 jedynek i na małym zbiorze zrobić wybitnie dobry perceptron (kształt cyfr bardzo dobrze je separuje od siebie)


% może się zdarzyć że klasyfikator zacznie oscylowac, lepiej ćwiczyć na łatwo rozróżnialnych cyfrach (łatwe 1 i 0, trudne są 3 i 5)

% jak już mamy perceptron, to bawimy się jak polepszyć

% poprawy pojedyńczych klasyfikatorów o 1.5% juz są ok

% 