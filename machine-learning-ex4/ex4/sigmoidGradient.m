function g = sigmoidGradient(z)
%SIGMOIDGRADIENT returns the gradient of the sigmoid function
%evaluated at z
%   g = SIGMOIDGRADIENT(z) computes the gradient of the sigmoid function
%   evaluated at z. This should work regardless if z is a matrix or a
%   vector. In particular, if z is a vector or matrix, you should return
%   the gradient for each element.

g = zeros(size(z));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the gradient of the sigmoid function evaluated at
%               each value of z (z can be a matrix, vector or scalar).

g_z = sigmoid(z);
g = g_z .* (1-g_z);

% =============================================================

end

%!test
%! sg = sigmoidGradient([[-1 -2 -3] ; magic(3)]);
%! tol = 5e-05;
%! assert(sg(1,:), [1.9661e-001 1.0499e-001 4.5177e-002], tol);
%! assert(sg(2,:), [3.3524e-004 1.9661e-001 2.4665e-003], tol);
%! assert(sg(3,:), [4.5177e-002 6.6481e-003 9.1022e-004], tol);
%! assert(sg(4,:), [1.7663e-002 1.2338e-004 1.0499e-001], tol);

