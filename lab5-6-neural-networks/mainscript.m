% this small NN for tiny data should be 100% correct

% now you can (probably) play with ann_training

% use PCA to reduce dimensionality  
% other method: use PCA and use all dimensions -> decorrelate data

% results must be better than the reference, 
% the logic of classification function could be different, now a simple max is used
% 
% passing: basic backpropagation for a network, calc derivative, 
% 
% fastest path may not be the best in this case, more than one element
% this ds has never been used before, free to suggest new methods
% 
% when to stop trainig? maybe we should wait longer?
%
% seeded random -> in project files there should be serialized state of generator -> repeatability
% 
% 
% 
%


% best so far: 0.16080


[tvec tlab tstv tstl] = readSets();
limSize = rows(tvec)
limIdx = randperm(rows(tvec));

tlab += 1;
tstl += 1;

tlab = tlab(limIdx,:);
tvec = tvec(limIdx,:);

noHiddenNeurons = 100;
noEpochs = 50;
learningRate = 0.01;

rand()
rndstate = rand("state");
save rndstate.txt rndstate
%load rndstate.txt
%rand("state", rndstate);

[hlnn olnn] = crann(columns(tvec), noHiddenNeurons, 10);
trainError = zeros(1, noEpochs);
testError = zeros(1, noEpochs);
trReport = [];
for epoch=1:noEpochs
	tic();
	[hlnn olnn terr] = backprop(tvec, tlab, hlnn, olnn, learningRate);
	clsRes = anncls(tvec, hlnn, olnn);
	cfmx = confMx(tlab, clsRes);   % it is worth looking into the cfmx in order to know which clothes are incorrectly classified
	errcf = compErrors(cfmx);
	trainError(epoch) = errcf(2);
	epochTime = toc();
	disp([epoch epochTime trainError(epoch) testError(epoch)])
	trReport = [trReport; epoch epochTime trainError(epoch) testError(epoch)];
	fflush(stdout);
end



