% Load data
%ratings = load('jester_ratings.dat');

data = rand(54, 10);

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
disp(size(cv.training(1)))

alpha = 1.2404;
beta = 0.9265;
X = -10:.01:10;
y2=Scaled_BetaPDF(X, alpha, beta, -10, 10);



%x = 0:0.001:1;
%y1 = betapdf(x, 1.2404, 0.9265);
%y2 = Scaled_BetaPDF(x, 1.2404, 0.9265, -10, 10);

disp("LEN: " + length(x))

figure(1)
plot(X, y1, 'r', 'LineWidth', 3)
grid

figure(2)
plot(X, y2)
grid

function PDF = Scaled_BetaPDF(y, a, b, p, q)
PDF = ( (y-p).^(a-1) .* (q - y).^(b-1) ) ./ ( (q - p).^(a+b-1) .* beta(a,b) );
end