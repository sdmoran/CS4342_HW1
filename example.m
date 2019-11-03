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

x = [-10:10]
j = Scaled_BetaPDF(x, 3, 4, -10, 10)
plot(j)

function PDF = Scaled_BetaPDF(y, a, b, p, q)
PDF = ( (y-p).^(a-1) .* (q - y).^(b-1) ) ./ ( (q - p).^(a+b-1) .* beta(a,b) );
end