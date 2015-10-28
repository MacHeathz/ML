function [value_vec, error_train, error_val, best] = ...
    validationCurve(X, y, Xval, yval, validationKind)
%VALIDATIONCURVE Generate the train and validation errors needed to
%plot a validation curve that we can use to select lambda
%   [lambda_vec, error_train, error_val] = ...
%       VALIDATIONCURVE(X, y, Xval, yval) returns the train
%       and validation errors (in error_train, error_val)
%       for different values of lambda. You are given the training set (X,
%       y) and validation set (Xval, yval).
%

% Selected values of lambda (you should not change this)
p_vec = [1:12]';
lambda_vec = [0 0.001 0.003 0.01 0.03 0.1 0.3 1 3 10]';
%lambda_vec = [0 0.01 0.02 0.04 0.08 0.16 0.32 0.64 1.28 2.56 5.12 10.24]';

value_vec = [];
if (validationKind == 'lambda')
  value_vec = lambda_vec;
elseif (validationKind == 'p')
  value_vec = p_vec;
end

% You need to return these variables correctly.
error_train = zeros(length(value_vec), 1);
error_val = zeros(length(value_vec), 1);

% ====================== YOUR CODE HERE ======================

if (validationKind == 'lambda')
	for i = 1:length(value_vec)
		lambda = value_vec(i);
		[theta] = trainLinearReg(X, y, lambda);

		error_train(i) = linearRegCostFunction(X, y, theta, 0);
		error_val(i) = linearRegCostFunction(Xval, yval, theta, 0);
	end
elseif (validationKind == 'p')
	errors_train = zeros(size(p_vec), size(lambda_vec));
	errors_val = zeros(size(p_vec), size(lambda_vec));
	
	for i = 1:length(value_vec)
		m = size(X, 1);
		
		% Map X onto Polynomial Features
		X_poly = polyFeatures(X, i);
		[X_poly, mu, sigma] = featureNormalize(X_poly);  % Normalize
		X_poly = [ones(m, 1), X_poly];                   % Add Ones

		% Map X_poly_val and normalize (using mu and sigma)
		X_poly_val = polyFeatures(Xval, i);
		X_poly_val = bsxfun(@minus, X_poly_val, mu);
		X_poly_val = bsxfun(@rdivide, X_poly_val, sigma);
		X_poly_val = [ones(size(X_poly_val, 1), 1), X_poly_val];           % Add Ones
		
		for j = 1:length(lambda_vec)
			[theta] = trainLinearReg(X_poly, y, lambda_vec(j));
			errors_train(i,j) = linearRegCostFunction(X_poly, y, theta, 0);
			errors_val(i,j) = linearRegCostFunction(X_poly_val, yval, theta, 0);
		end
	end
	
	idx = nthargout(2, @min, errors_val(:));
	[r,c] = ind2sub(size(errors_val), idx);
	
	error_train = errors_train(:,c);
	error_val = errors_val(:,c);
end

[W, IW] = min(error_val);
best = value_vec(IW);

% =========================================================================

end
