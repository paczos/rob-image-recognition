% implement actf & check it on a graph
x = -5:0.1:5;
plot(x, actf(x))

% implement actdf 
% note that input value for actdf is not x itself but actf(x)
plot(x, actdf(actf(x)))

% implement backprop 
% it makes sense to start with a really small dataset
load tiny.txt
tlab = tiny(:,1);
tvec = tiny(:,2:end);
[hlnn olnn] = crann(columns(tvec), 4, 2);
[size(hlnn) size(olnn)]

clsRes = anncls(tvec, hlnn, olnn);
cfmx = confMx(tlab, clsRes);
errcf = compErrors(cfmx)

[hlnn olnn terr] = backprop(tvec, tlab, hlnn, olnn, 0.5)
clsRes = anncls(tvec, hlnn, olnn);
cfmx = confMx(tlab, clsRes);
errcf = compErrors(cfmx)
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

