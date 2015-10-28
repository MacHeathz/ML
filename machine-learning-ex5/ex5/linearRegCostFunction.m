function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the 
%   cost of using theta as the parameter for linear regression to fit the 
%   data points in X and y. Returns the cost in J and the gradient in grad

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost and gradient of regularized linear 
%               regression for a particular choice of theta.
%
%               You should set J to the cost and grad to the gradient.
%

Cost = (X * theta) - y;

% We've already used theta for h_x, so we can set the first theta
% to 0 so the bias variable is not considered for regularization.
theta(1,:) = 0;

% With vectors, A'*A == sum(A.^2)
J = 1/(2*m) * Cost' * Cost; 
J += lambda * (1/(2*m)) * theta' * theta; % add regularization

grad = 1/m * X' * Cost;
grad += lambda * (1/m) * theta; % add regularization

% =========================================================================

grad = grad(:);

end
