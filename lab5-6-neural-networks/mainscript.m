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

tlab = tlab(limIdx, :);
tvec = tvec(limIdx, :);
tstv = tstv(limIdx, :);
tstl = tstl(limIdx, :);

noHiddenNeurons = 300;
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

	clsRes = anncls(tstv, hlnn, olnn);
	cfmx = confMx(tstl, clsRes);
	errcf2 = compErrors(cfmx);
	testError(epoch) = errcf2(2);
	epochTime = toc();
	disp([epoch epochTime trainError(epoch) testError(epoch)])
	trReport = [trReport; epoch epochTime trainError(epoch) testError(epoch)];
	fflush(stdout);
end


%noHiddenNeurons = 200;
%noEpochs = 50;
%learningRate = 0.01;
%ans =  0.17400
%    1.00000   79.63110    0.23483    0.00000
%    2.00000   79.52931    0.18032    0.00000
%   3.00000   79.36038    0.16568    0.00000



%noHiddenNeurons = 400;
%noEpochs = 60;
%learningRate = 0.015;

%cnt =  60000
%nel =  60000
%cnt =  10000
%nel =  10000
%limSize =  60000
%ans =  0.99220
%     1.00000   158.12970     0.19852     0.20910
%     2.00000   158.73796     0.16570     0.17950
%     3.00000   158.90055     0.15362     0.16870
%     4.00000   158.75812     0.14622     0.16340
%     5.00000   159.11237     0.14167     0.15790
%     6.00000   158.16983     0.13813     0.15320
%     7.00000   158.66217     0.13397     0.15030
%     8.00000   158.99951     0.13125     0.14790
%     9.00000   158.16743     0.12847     0.14690
%    10.00000   158.67155     0.12585     0.14500
%    11.00000   158.09115     0.12380     0.14230
%    12.00000   158.43752     0.12172     0.14170
%    13.00000   157.91327     0.12007     0.14010
%    14.00000   157.85690     0.11817     0.13840
%    15.00000   158.38921     0.11640     0.13760
%    16.00000   158.06481     0.11453     0.13570
%    17.00000   158.19411     0.11290     0.13410
%    18.00000   158.23308     0.11135     0.13340
%    19.00000   156.77038     0.10965     0.13270
%    20.00000   159.27643     0.10803     0.13180
%    21.00000   156.86002     0.10663     0.13100
%    22.00000   156.72536     0.10567     0.12990
%    23.00000   157.16665     0.10453     0.12940
%    24.00000   157.15799     0.10350     0.12820
%    25.00000   156.60208     0.10230     0.12750
%    26.00000   156.70280     0.10137     0.12680
%    27.00000   156.93318     0.10058     0.12540
%    28.000000   157.205459     0.099400     0.124800
%    29.000000   156.754662     0.098233     0.124600
%    30.000000   156.397384     0.097417     0.123100
%    31.000000   156.759514     0.096267     0.123100
%    32.000000   156.293580     0.095283     0.122700
%    33.000000   156.751140     0.094433     0.122500
%    34.000000   157.106400     0.093500     0.121900
%    35.000000   157.000432     0.092483     0.121400
%    36.000000   156.894188     0.091600     0.121200
%    37.000000   156.674338     0.090800     0.121000
%    38.000000   156.887200     0.089917     0.120500
%    39.000000   157.058863     0.089183     0.119500
%    40.000000   156.684943     0.088167     0.119400
%    41.000000   157.944792     0.087383     0.119200
%    42.000000   157.033987     0.086450     0.118700
%    43.000000   157.632600     0.085517     0.118700
%    44.000000   157.369003     0.084867     0.118300
%    45.000000   156.518994     0.083850     0.118900
%    46.000000   156.914155     0.082883     0.119000
%    47.000000   157.467678     0.081900     0.118300
%    48.000000   156.623075     0.081133     0.117900
%    49.000000   157.144239     0.080233     0.117200
%    50.000000   156.344235     0.079633     0.116700
%    51.000000   157.155496     0.078917     0.116300
%    52.000000   156.682843     0.078283     0.116500
%    53.000000   156.637566     0.077717     0.116300
%    54.000000   156.764728     0.077033     0.115700
%    55.000000   156.958661     0.076400     0.115200
%    56.000000   157.207272     0.075783     0.114500
%    57.000000   156.944841     0.075167     0.114400
%    58.000000   156.211678     0.074350     0.114400
%    59.000000   156.574942     0.073817     0.114100
%    60.000000   156.913653     0.073183     0.114200