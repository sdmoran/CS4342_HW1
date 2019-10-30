ratings = load('jester_ratings.dat');

ratings_total = sum(ratings(1:end, 3));
n = length(ratings(1:end, 3));

disp(ratings_total);
disp("n = " + n);
disp("mu = " + ratings_total / n);

mu = ratings_total / n;

sigma = 0;

for i = 1 : length(ratings(1:end, 3))
    sigma = sigma + (1 / n) * (ratings(i, 3) - mu)^2;
end

disp("sigma = " + sigma);

%histogram(ratings(1:end, 3), 5, 'Normalization', 'probability');
%histogram(ratings(1:end, 3), 10, 'Normalization', 'probability');

distr = normpdf(ratings(1:end, 3), mu, sigma);
plot(normpdf(ratings(1:end, 3), mu, sigma));