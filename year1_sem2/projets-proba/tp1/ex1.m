clear all;
close all;

a = 101;
c = 1;
m = 1024;
n = 200;
mdisc = 1:m;
adiscrete = 1:4:1021;
corr = zeros(n, 1);
j = 1;
T1 = 1;
f = @(x, b) mod(b * x + c, m);

% EXO 1.1 
x2 = zeros(20, 1);
x2(1) = 0;
for i = 1:n - 1
    x2(i + 1) = f(x2(i), a);
end

figure(1);
hold on;
plot(x2, ones(n, 1), 'r*');
plot(mdisc, ones(length(mdisc), 1));
hold off;

% EXO 1.2
x0 = 0;

while 1
    x0 = f(x0, a);
    if x0 == 0
        break;
    end
    T1 = T1 + 1;
end

disp(T1);

% EXO 1.4
x1 = randi(m - 1, n, 1);
for a = adiscrete
    for i=1:n - 1
        x2(i + 1) = f(x2(i), a);
    end
    corr(j) = corrempiric(x1, x2);
    j = j + 1;
end

[minc, ind] = min(abs(corr))
fprintf('best a ever is %d\n', adiscrete(ind));

figure(2);
plot(1:length(corr), corr, 'r*');
