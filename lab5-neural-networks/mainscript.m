% implement actf & check it on a graphx = -5:0.1:5;plot(x, actf(x))% implement actdf % note that input value for actdf is not x itself but actf(x)plot(x, actdf(actf(x)))% implement backprop % it makes sense to start with a really small datasetload tiny.txttlab = tiny(:,1);tvec = tiny(:,2:end);[hlnn olnn] = crann(columns(tvec), 4, 2);[size(hlnn) size(olnn)]clsRes = anncls(tvec, hlnn, olnn);cfmx = confMx(tlab, clsRes);errcf = compErrors(cfmx)[hlnn olnn terr] = backprop(tvec, tlab, hlnn, olnn, 0.5)clsRes = anncls(tvec, hlnn, olnn);cfmx = confMx(tlab, clsRes);errcf = compErrors(cfmx)% now you can (probably) play with ann_training