%% Machine Learning Online Class
%  Exercise 5 | Regularized Linear Regression and Bias-Variance
%
%  Instructions
%  ------------
% 
%  This file contains code that helps you get started on the
%  exercise. You will need to complete the following functions:
%
%     linearRegCostFunction.m
%     learningCurve.m
%     validationCurve.m
%
%  For this exercise, you will not need to change any code in this file,
%  or any other files other than those mentioned above.
%

%% Initialization
clear ; close all; clc

%% =========== Part 1: Loading and Visualizing Data =============
%  We start the exercise by first loading and visualizing the dataset. 
%  The following code will load the dataset into your environment and plot
%  the data.
%

% Load Training Data
fprintf('Loading and Visualizing Data ...\n')

% Load from ex5data1: 
% You will have X, y, Xval, yval, Xtest, ytest in your environment
load ('ex5data1.mat');

% Repartition data
allData = [X y ; Xval yval ; Xtest ytest];
%rand("seed", 19020711);
shuffledData = allData(randperm(size(allData,1)),:);

% Partition sizes: train/test/val = 60/20/20
totalsize = length(shuffledData);
testsize = valsize = idivide(totalsize, 5, 'ceil');
trainsize = totalsize - testsize - valsize;

assert(trainsize + valsize + testsize, totalsize);

% Partition data
traindata = shuffledData(1:trainsize,:);
testdata = shuffledData((trainsize+1):(trainsize+testsize),:);
valdata = shuffledData((trainsize+testsize+1):(totalsize),:);

assert(size(traindata,1) + size(testdata,1) + size(valdata,1), size(shuffledData,1));

X = traindata(:,1);
y = traindata(:,2);
Xval = valdata(:,1);
yval = valdata(:,2);
Xtest = testdata(:,1);
ytest = testdata(:,2);

% m = Number of examples
m = size(X, 1);

% Plot training data
plot(X, y, 'rx', 'MarkerSize', 10, 'LineWidth', 1.5);
xlabel('Change in water level (x)');
ylabel('Water flowing out of the dam (y)');

fprintf('Program paused. Press enter to continue.\n');
pause;

%% =========== Part 2: Regularized Linear Regression Cost =============
%  You should now implement the cost function for regularized linear 
%  regression. 
%

%theta = [1 ; 1];
%J = linearRegCostFunction([ones(m, 1) X], y, theta, 1);

%fprintf(['Cost at theta = [1 ; 1]: %f '...
%         '\n(this value should be about 303.993192)\n'], J);

%fprintf('Program paused. Press enter to continue.\n');
%pause;

%% =========== Part 3: Regularized Linear Regression Gradient =============
%  You should now implement the gradient for regularized linear 
%  regression.
%

%theta = [1 ; 1];
%[J, grad] = linearRegCostFunction([ones(m, 1) X], y, theta, 1);
%
%fprintf(['Gradient at theta = [1 ; 1]:  [%f; %f] '...
%         '\n(this value should be about [-15.303016; 598.250744])\n'], ...
%         grad(1), grad(2));
%
%fprintf('Program paused. Press enter to continue.\n');
%pause;


%% =========== Part 4: Train Linear Regression =============
%  Once you have implemented the cost and gradient correctly, the
%  trainLinearReg function will use your cost function to train 
%  regularized linear regression.
% 
%  Write Up Note: The data is non-linear, so this will not give a great 
%                 fit.
%

%  Train linear regression with lambda = 0
lambda = 0;
[theta] = trainLinearReg([ones(m, 1) X], y, lambda);

%  Plot fit over the data
plot(X, y, 'rx', 'MarkerSize', 10, 'LineWidth', 1.5);
xlabel('Change in water level (x)');
ylabel('Water flowing out of the dam (y)');
hold on;
plot(X, [ones(m, 1) X]*theta, '--', 'LineWidth', 2)
hold off;

fprintf('Program paused. Press enter to continue.\n');
pause;


%% =========== Part 5: Learning Curve for Linear Regression =============
%  Next, you should implement the learningCurve function. 
%
%  Write Up Note: Since the model is underfitting the data, we expect to
%                 see a graph with "high bias" -- slide 8 in ML-advice.pdf 
%

lambda = 0;
[error_train, error_val] = ...
    learningCurve([ones(m, 1) X], y, ...
                  [ones(size(Xval, 1), 1) Xval], yval, ...
                  lambda);

plot(1:m, error_train, 1:m, error_val);
title('Learning curve for linear regression')
legend('Train', 'Cross Validation')
xlabel('Number of training examples')
ylabel('Error')
axis([0 trainsize 0 150])

fprintf('# Training Examples\tTrain Error\tCross Validation Error\n');
for i = 1:m
    fprintf('  \t%d\t\t%f\t%f\n', i, error_train(i), error_val(i));
end

fprintf('Program paused. Press enter to continue.\n');
pause;

%% =========== Part 5 1/2: Automatically choosing the best polynomial degree =
% :TODO: Because we don't take lambda into consideration, this tends to choose
% a relatively low p which results in a low lambda and a slightly underfitting
% model. It would be better to test several p, lambda combinations later on
% (starting with the p selected here), since lambda can remedy overfitting but
% not high bias.

[p_vec, error_train, error_val, p] = ...
    validationCurve(X, y, Xval, yval, 'p');

close all;
plot(p_vec, error_train, p_vec, error_val);
legend('Train', 'Cross Validation');
xlabel('Polynomial degree');
ylabel('Error');

fprintf('Polynomial\t\tTrain Error\tValidation Error\n');
for i = 1:length(p_vec)
	fprintf(' %f\t%f\t%f\n', ...
            p_vec(i), error_train(i), error_val(i));
end

fprintf('Polynomial Degree chosen: %f\n', p);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% =========== Part 6: Feature Mapping for Polynomial Regression =============
%  One solution to this is to use polynomial regression. You should now
%  complete polyFeatures to map each example into its powers
%
%:TODO: This is probably superfluous since we already normalized in
% validationCurve.m while selecting a polynomial degree
% Map X onto Polynomial Features and Normalize
X_poly = polyFeatures(X, p);
[X_poly, mu, sigma] = featureNormalize(X_poly);  % Normalize
X_poly = [ones(m, 1), X_poly];                   % Add Ones

% Map X_poly_test and normalize (using mu and sigma)
X_poly_test = polyFeatures(Xtest, p);
X_poly_test = bsxfun(@minus, X_poly_test, mu);
X_poly_test = bsxfun(@rdivide, X_poly_test, sigma);
X_poly_test = [ones(size(X_poly_test, 1), 1), X_poly_test];         % Add Ones

% Map X_poly_val and normalize (using mu and sigma)
X_poly_val = polyFeatures(Xval, p);
X_poly_val = bsxfun(@minus, X_poly_val, mu);
X_poly_val = bsxfun(@rdivide, X_poly_val, sigma);
X_poly_val = [ones(size(X_poly_val, 1), 1), X_poly_val];           % Add Ones

fprintf('Normalized Training Example 1:\n');
fprintf('  %f  \n', X_poly(1, :));

fprintf('\nProgram paused. Press enter to continue.\n');
pause;



%% =========== Part 7: Learning Curve for Polynomial Regression =============
%  Now, you will get to experiment with polynomial regression with multiple
%  values of lambda. The code below runs polynomial regression with 
%  lambda = 0. You should try running the code with different values of
%  lambda to see how the fit and learning curve change.
%
%
%lambda = 1;
%[theta] = trainLinearReg(X_poly, y, lambda);
%
% Plot training data and fit
%figure(1);
%plot(X, y, 'rx', 'MarkerSize', 10, 'LineWidth', 1.5);
%plotFit(min(X), max(X), mu, sigma, theta, p);
%xlabel('Change in water level (x)');
%ylabel('Water flowing out of the dam (y)');
%title (sprintf('Polynomial Regression Fit (lambda = %f)', lambda));
%
%figure(2);
%[error_train, error_val] = ...
%    learningCurve(X_poly, y, X_poly_val, yval, lambda);
%plot(1:m, error_train, 1:m, error_val);
%
%title(sprintf('Polynomial Regression Learning Curve (lambda = %f)', lambda));
%xlabel('Number of training examples')
%ylabel('Error')
%axis([0 trainsize 0 100])
%legend('Train', 'Cross Validation')
%
%fprintf('Polynomial Regression (lambda = %f)\n\n', lambda);
%fprintf('# Training Examples\tTrain Error\tCross Validation Error\n');
%for i = 1:m
%    fprintf('  \t%d\t\t%f\t%f\n', i, error_train(i), error_val(i));
%end
%
%fprintf('Program paused. Press enter to continue.\n');
%pause;

%% =========== Part 8: Validation for Selecting Lambda =============
%  You will now implement validationCurve to test various values of 
%  lambda on a validation set. You will then use this to select the
%  "best" lambda value.
%

[lambda_vec, error_train, error_val, best_lambda] = ...
    validationCurve(X_poly, y, X_poly_val, yval, 'lambda');

close all;
plot(lambda_vec, error_train, lambda_vec, error_val);
legend('Train', 'Cross Validation');
xlabel('lambda');
ylabel('Error');

fprintf('lambda\t\tTrain Error\tValidation Error\n');
for i = 1:length(lambda_vec)
	fprintf(' %f\t%f\t%f\n', ...
            lambda_vec(i), error_train(i), error_val(i));
end

fprintf('Lambda chosen: %f\n', best_lambda);

fprintf('Program paused. Press enter to continue.\n');
pause;

% We try our model plus the selected lambda on the test set.
lambda = best_lambda;
[theta] = trainLinearReg(X_poly, y, lambda);

figure(2);
[error_train, error_test] = ...
    learningCurve(X_poly, y, X_poly_test, ytest, lambda);
plot(1:m, error_train, 1:m, error_test);

title(sprintf('Polynomial Regression Learning Curve (lambda = %f)', lambda));
xlabel('Number of training examples')
ylabel('Error')
axis([0 trainsize 0 50])
legend('Train', 'Test')

fprintf('Polynomial Regression (lambda = %f)\n\n', lambda);
fprintf('# Training Examples\tTrain Error\tTest Error\n');
for i = 1:m
    fprintf('  \t%d\t\t%f\t%f\n', i, error_train(i), error_test(i));
end

% Final plot showing model fit for all data points. Points are colored according to train/test/val dataset.

% Plot training data and fit
figure(1);
plot(X, y, 'rx', 'MarkerSize', 10, 'LineWidth', 1.5, 'markeredgecolor', 'red', 'markerfacecolor', 'red');
hold on;
plot(Xval, yval, 'rx', 'MarkerSize', 10, 'LineWidth', 1.5, 'markeredgecolor', 'blue', 'markerfacecolor', 'blue');
plot(Xtest, ytest, 'rx', 'MarkerSize', 10, 'LineWidth', 1.5, 'markerfacecolor', 'green', 'markeredgecolor', 'green');
legend('Train data', 'CV data', 'Test data');
plotFit(min([X;Xval;Xtest]), max([X;Xval;Xtest]), mu, sigma, theta, p);
xlabel('Change in water level (x)');
ylabel('Water flowing out of the dam (y)');
title (sprintf('Polynomial Regression Fit (lambda = %f; poly degree = %f)', lambda, p));

