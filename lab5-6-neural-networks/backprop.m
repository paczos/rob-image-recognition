function [hidlw outlw terr] = backprop(tset, tslb, inihidlw, inioutlw, lr)
% derivative of sigmoid activation function
% tset - training set (every row represents a sample)
% tslb - column vector of labels 
% inihidlw - initial hidden layer weight matrix
% inioutlw - initial output layer weight matrix
% lr - learning rate

% hidlw - hidden layer weight matrix
% outlw - output layer weight matrix
% terr - total squared error of the ANN

% 1. Set output matrices to initial values
	hidlw = inihidlw;
	outlw = inioutlw;
	
% 2. Set total error to 0
	terr = 0;
	
% foreach sample in the training set
	for i=1:rows(tset)
		% 3. Set desired output of the ANN
		desiredOut = zeros(1, columns(outlw));
		desiredOut(tslb(i)) = 1;

		% 4. Propagate input forward through the ANN
		% remember to extend input [tset(i, :) 1]
		hiddenLayerOut = actf([tset(i, :) 1] * hidlw);
		outLayerOut = actf([hiddenLayerOut 1] * outlw);

        % http://neuralnetworksanddeeplearning.com/chap2.html
		% 5. Adjust total error (just to know this value)
        sampleError = sum((desiredOut-outLayerOut).^2);
		terr += sampleError;
		% 6. Compute delta error of the output layer
		% how many delta errors should be computed here?
        outLayerDelta = actdf(outLayerOut) .* (desiredOut - outLayerOut);
        outLayerAdjustment = [hiddenLayerOut 1]' * outLayerDelta * lr;

		% 7. Compute delta error of the hidden layer
		% how many delta errors should be computed here?
		hiddenLayerDelta = actdf(hiddenLayerOut) .* (outlw(1:end-1,:)*outLayerDelta')';
		hiddenLayerAdjustment = [tset(i, :) 1]' * hiddenLayerDelta * lr;

		% 8. Update output layer weights
		outlw += outLayerAdjustment;

		% 9. Update hidden layer weights
		hidlw += hiddenLayerAdjustment;
	end
