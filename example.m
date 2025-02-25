% Load data
ratings = load('jester_ratings.dat');
data = ratings(1:end, 3);
norm_data = (data - min(data)) / ((max(data)-min(data)));

sorted = sort(norm_data);
range = (2:n-28);

d = fitdist((sorted(range)), 'Normal');
disp(d);

l = makedist('Lognormal', (1.618), (5.3026));
x = 0:0.001:1;
y = pdf(l, x);
disp(l);
plot(x, y);


%plot(d);