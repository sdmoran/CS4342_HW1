% Load data
ratings = load('jester_ratings.dat');

% Get the sum of all joke ratings and the total number of jokes
ratings_total = sum(ratings(1:end, 3));
n = length(ratings(1:end, 3));

% Mu is simply the sum of all ratings divided by the number of ratings
mu = ratings_total / n;

sigma = 0;

% Calculate sigma
for i = 1 : length(ratings(1:end, 3))
    sigma = sigma + (1 / n) * (ratings(i, 3) - mu)^2;
end

% Take sqrt of sigma at the end
sigma = sqrt(sigma);

% Print statistics about the data
disp("Total # ratings: " + ratings_total);
disp("n = " + n);
disp("mu = " + ratings_total / n);
disp("sigma = " + sigma);

% Draw histogram

%histogram(ratings(1:end, 3), 5, 'Normalization', 'pdf');hold on
%histogram(ratings(1:end, 3), 10, 'Normalization', 'pdf');
%histogram(ratings(1:end, 3), 20, 'Normalization', 'pdf');
histogram(ratings(1:end, 3), 30, 'Normalization', 'pdf');
hold on

% Set up and draw the normal PDF we've found from MLE
pd = makedist('Normal','mu', mu,'sigma', sigma);
x = -20:20;
y = pdf(pd, x);

% Plot PDF on top of histogram
plot(x, y, 'r')