function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta

h_x = sigmoid(X * theta);
theta(1) = 0; % We don't want to regularize theta_0

J = -1/m * (log(h_x)' * y + log(1 - h_x)' * (1 - y)) + lambda / (2*m) * sum(theta .^ 2);

grad = 1/m * X' * (h_x - y) + lambda / m * theta;

% =============================================================

end

%% Define unit tests, see also https://www.gnu.org/software/octave/doc/interpreter/Test-Functions.html
%% Can be run by using: 'test costFunctionReg' in Octave

%!shared theta, X, y, tol
%! theta = [-2 -1 1 2]';
%! X = [ones(3,1) magic(3)];
%! y = [1 0 1]';
%! tol = 5e-05

%!test
%! [j g] = costFunctionReg(theta, X, y, 3);
%! assert(j, 7.6832, tol);
%! assert(g, [0.3172 -0.1277 2.6481 4.2379]', tol)

%!test
%! [j g] = costFunctionReg(theta, X, y, 5);
%! assert(j, 9.6832, tol);
%! assert(g, [0.3172 -0.7944 3.3148 5.5712]', tol);

