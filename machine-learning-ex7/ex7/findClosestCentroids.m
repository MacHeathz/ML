function [idx, dist] = findClosestCentroids(X, centroids)
%FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   [idx, dist] = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%   dist = m x 1 vector with for each example X, the distance to it's cluster centroid
%

% Set K
K = size(centroids, 1);

% You need to return the following variables correctly.
idx = zeros(size(X,1), 1);
dist = zeros(size(X,1), 1);
dist(:) = Inf;

% ====================== YOUR CODE HERE ======================
% Instructions: Go over every example, find its closest centroid, and store
%               the index inside idx at the appropriate location.
%               Concretely, idx(i) should contain the index of the centroid
%               closest to example i. Hence, it should be a value in the 
%               range 1..K
%
% Note: You can use a for-loop over the examples to compute this.
%

xs = size(X,1);

for i = 1:xs
  shortest_dist = Inf;
  for k = 1:K
    Diff = X(i, :) - centroids(k, :);
    d = sqrt(Diff * Diff');
    if (d < dist(i))
      dist(i) = d;
      idx(i) = k;
    end
  end
end

% =============================================================

end

