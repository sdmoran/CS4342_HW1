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


% Take sqrt of sigma at the end
sigma = sqrt(sigma);

% Print statistics about the data
disp("Total sum of ratings: " + ratings_total);
disp("n = " + n);
disp("mu = " + ratings_total / n);
disp("sigma = " + sigma);

% Draw histogram
%bins = 50;
%histogram(ratings(1:end, 3), bins, 'Normalization', 'pdf');
histogram(ratings(1:end, 3), 'Normalization', 'pdf');
hold on

% Set up and draw the normal PDF we've found from MLE
pd = makedist('Normal','mu', mu,'sigma', sigma);
x = -10:10;
y = pdf(pd, x);
%plot(x, y, 'r', 'LineWidth', 2);

% Set up MLE of the logistic normal PDF


disp("0 idx: " + find(norm_data==0)) % log of 0 is undefined, so we can't use the function there.

% We can't include 0 and 1 in our MLE calculation, because our function is
% undefined at both 0 (log(0) undefined) and 1 (division by 0 undefined).

% There is one data point that normalizes to 0, and 27 data points that
% normalize to 1. So we calculate the MLE using indices [1, n-28].
sorted = sort(norm_data);
range = (2:n-28);

% Normalized the data for this distribution, now we normalize the mean and
% variance
mu_lognormal = (mu - min(data)) / ((max(data)-min(data)));
sigma_lognormal = (sigma - min(data)) / ((max(data)-min(data)));
%mu_lognormal = sum(log(sorted(range))) / length(range);
%sigma_lognormal = (sum(log(sorted(range).^2)) - sum(log(sorted(range)).^2)) / length(range);

disp("Mu_Lognormal: " +  mu_lognormal)
disp("Sigma_Lognormal: " + sigma_lognormal)

% Generate logistic normal function between 0 and 1 with the mu and sigma
% calculated
l = Logistic_NormalPDF(0:0.001:1, mu_lognormal,  sigma_lognormal);
norm_l = (l - min(l)) / ((max(l)-min(l)));



% Scale down the distribution so it's the same size as the others. 11.618
% chosen because it is the mu divided by the interval.
plot(x_vals, norm_l/11.618, 'LineWidth', 2);

% Generate a Beta Distribution from the alpha and beta found by using
% fitdist() on the data.
alpha = 1.2404;
beta = 0.9265;
beta_xvals = -10:.01:10;
scaled_beta=Scaled_BetaPDF(beta_xvals, alpha, beta, -10, 10);

plot(beta_xvals, scaled_beta, 'LineWidth', 2);


m = mle(sorted(range), 'distribution', 'Lognormal');
disp(m)

% Function declarations
function logit = calc_logit(x)
logit = log(x ./ (1 - x ));
end

function lognormal = Logistic_NormalPDF(x, mu, sigma)
lognormal = (1 ./ (sigma .* sqrt(2*pi))).* (1./(x .* (1-x))) .* exp(-(calc_logit(x) - mu).^2 / (2 .* sigma^2));
end

function PDF = Scaled_BetaPDF(y, a, b, p, q)
PDF = ( (y-p).^(a-1) .* (q - y).^(b-1) ) ./ ( (q - p).^(a+b-1) .* beta(a,b) );
end