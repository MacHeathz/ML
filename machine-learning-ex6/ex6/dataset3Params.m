function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

Cs = sigmas = [ 0.001; 0.003; 0.01; 0.03; 0.1; 0.3; 1; 3; 10; 30 ];

highest_acc = 0; best_C = 0; best_sigma = 0;

for c = 1:length(Cs)
	cur_c = Cs(c);
	for s = 1:length(sigmas)
    gamma = 1/(2*(sigmas(s)^2));
    model = svmtrain(y, X, ['-q -s 0 -t 2 -g ' num2str(gamma) ' -c ' num2str(cur_c)]);
    [predictions, acc, dec] = svmpredict(yval, Xval, model, "-q");
		if (acc(1) > highest_acc)
      highest_acc = acc(1);
      best_C = cur_c;
      best_sigma = sigmas(s);
    end
	end
end

C = best_C;
sigma = best_sigma;

% =========================================================================

end