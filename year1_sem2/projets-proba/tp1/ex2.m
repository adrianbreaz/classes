% EXO 2.1
m = 10;
f = @(x, n) (floor(n * x) + 1) / n;

xa = 0:0.01:0.99;

hold on;
figure(1);
plot(xa, f(xa, m));
hold off;
