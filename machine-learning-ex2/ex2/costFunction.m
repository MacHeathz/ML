function [J, grad] = costFunction(theta, X, y)
%COSTFUNCTION Compute cost and gradient for logistic regression
%   J = COSTFUNCTION(theta, X, y) computes the cost of using theta as the
%   parameter for logistic regression and the gradient of the cost
%   w.r.t. to the parameters.

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
%
% Note: grad should have the same dimensions as theta
%

h_x = sigmoid(X * theta);
% Vectorized form:
J = -1/m * (log(h_x)' * y + log(1 - h_x)' * (1-y));
grad = 1/m * X' * (h_x - y);

% =============================================================

end

%% Define unit tests, see also https://www.gnu.org/software/octave/doc/interpreter/Test-Functions.html
%% Can be run by using: 'test costFunction' in Octave!

%!shared tol
%! tol = 5e-05

%!test
%! X = [magic(3); magic(3)];
%! y = [1 0 1 0 1 0]';
%! [j g] = costFunction([0 1 0]', X, y);
%! assert(j, 2.6067, tol);
%! assert(g, [1.7760; 2.3988; 1.9464], tol);

%!test
%! X = [ones(4); magic(4)];
%! y = [1 0 1 0 1 0 1 0]';
%! [j g] = costFunction([0 1 0 1]', X, y);
%! assert(j, 4.8135, tol);
%! assert(g, [1.3154 3.3154 3.3154 1.3154]', tol)

