function [theta] = normalEqn(X, y)
%NORMALEQN Computes the closed-form solution to linear regression 
%   NORMALEQN(X,y) computes the closed-form solution to linear 
%   regression using the normal equations.

theta = zeros(size(X, 2), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Complete the code to compute the closed form solution
%               to linear regression and put the result in theta.
%

% ---------------------- Sample Solution ----------------------

% Put X transposed in a variable since for large datasets it
% would be computationally expensive to do this multiple times.
t_X = X';
theta = pinv(t_X*X) * t_X*y;

% -------------------------------------------------------------


% ============================================================

end
