function p = predict(theta, X)
%PREDICT Predict whether the label is 0 or 1 using learned logistic 
%regression parameters theta
%   p = PREDICT(theta, X) computes the predictions for X using a 
%   threshold at 0.5 (i.e., if sigmoid(theta'*x) >= 0.5, predict 1)

m = size(X, 1); % Number of training examples

% You need to return the following variables correctly
p = zeros(m, 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Complete the following code to make predictions using
%               your learned logistic regression parameters. 
%               You should set p to a vector of 0's and 1's
%

% arrayfun maps values to a function. In this case, all values in the vector
% resulting from sigmoid(X*theta) are input an anonymous function that tests
% (and returns) if the value v is >= 0.5. Booleans are cast to 0 and 1.
% This is a vectorized solution, as opposed to using a for loop.
p = arrayfun(@(v) (double(v >= 0.5)), sigmoid(X * theta));

% =========================================================================


end

%% Define unit tests, see also https://www.gnu.org/software/octave/doc/interpreter/Test-Functions.html
%% Can be run by using: 'test predict' in Octave!

%!test assert (predict([0 1 10]', magic(3)), [1;1;1])
%!test assert (predict([4 3 -8]', magic(3)), [0;0;1])
%!test assert (predict([3 0 -8]', magic(3)), [0;0;0])
%!test assert (predict([0.3; 0.2], [1 2.4; 1 -17; 1 0.5]), [1;0;1])



