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

% Normalize data
data = ratings(1:end, 3);
norm_data = (data - min(data)) / ((max(data)-min(data)));
disp(norm_data(1:10))

% Take sqrt of sigma at the end
sigma = sqrt(sigma);

% Print statistics about the data
disp("Total # ratings: " + ratings_total);
disp("n = " + n);
disp("mu = " + ratings_total / n);
disp("sigma = " + sigma);

% Draw histogram
bins = 10;
%histogram(ratings(1:end, 3), bins, 'Normalization', 'pdf');
%histogram(ratings(1:end, 3), 'Normalization', 'pdf');
title(bins + " bins");
hold on

% Set up and draw the normal PDF we've found from MLE
pd = makedist('Normal','mu', mu,'sigma', sigma);
x = -100:100;
y = pdf(pd, x);

hf = histfit(norm_data, 60, 'beta');
disp(hf(1))
disp(get(hf(2),'XData')); 
disp(get(hf(2),'YData'));

%scaledx = -10:10;
%j = Scaled_BetaPDF(scaledx, 2, 2, -10, 10);
%plot(j)

% Plot PDF on top of histogram
%plot(x, y, 'r')

function PDF = Scaled_BetaPDF(y, a, b, p, q)
PDF = ( (y-p).^(a-1) .* (q - y).^(b-1) ) ./ ( (q - p).^(a+b-1) .* beta(a,b) );
end