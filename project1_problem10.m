ratings = load('jester_ratings.dat');
data = ratings(1:end, 3);

cv = cvpartition(size(data, 1), 'k', 10, 'Stratify', false);
    for i = 1:cv.NumTestSets
        trIdx = cv.training(i);
        teIdx = cv.test(i);
        % THIS LINE is how you get it to actually break up into the test samples.
        % Indices of data where cvpartition has nonzero values.
        testClasses = data(cv.test(i));
        disp(size(testClasses))
    end
    
disp(cv)
disp(size(data(cv.training(1))))

% Get training data from the partition

train_data = data(cv.training(1));
test_data = data(cv.test(1));

% Get the sum of all joke ratings and the total number of jokes
ratings_total = sum(train_data);
n = length(train_data);

% ========== NORMAL DISTRIBUTION ==========
% Mu is simply the sum of all ratings divided by the number of ratings
mu = ratings_total / n;
sigma = 0;

% Calculate sigma
for i = 1 : length(ratings(1:end, 3))
    sigma = sigma + (1 / n) * (ratings(i, 3) - mu)^2;
end
sigma = sqrt(sigma);

disp("MU: " + mu)
disp("SIGMA: " + sigma)

hold on

% Plot histogram of test data
histogram(test_data, 100, 'Normalization', 'pdf');

% Sample from our trained normal dist and plot histogram of sample data
y = sigma.*randn(length(test_data),1) + mu;
histogram(y, 100, 'Normalization', 'pdf');
xlim([-10, 10]);

pd = makedist('Normal','mu', mu,'sigma', sigma);
x = -10:10;
y = pdf(pd, x);
%plot(x, y, 'r', 'LineWidth', 2);