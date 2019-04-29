function lab = anncls(tset, hidlw, outlw)
% simple ANN classifier
% tset - data to be classified (every row represents a sample) 
% hidlw - hidden layer weight matrix
% outlw - output layer weight matrix

% lab - classification result (index of output layer neuron with highest value)
% ATTENTION: we assume that constant value IS NOT INCLUDED in tset rows

	hlact = [tset ones(rows(tset), 1)] * hidlw; % value for a neuron
	hlout = actf(hlact); %activation function 
	
	olact = [hlout ones(rows(hlout), 1)] * outlw; % out layer, the ones at the end are used for bias
	olout = actf(olact);

	% this could be more complex, now only a single hidden layer is used

	[~, lab] = max(olout, [], 2); % final decision 
