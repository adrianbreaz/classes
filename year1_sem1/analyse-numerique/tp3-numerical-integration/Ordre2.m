clear all;
close all;
% Alexandru Fikl MACS 1
% donnees
a = 0;
b = pi/2;
f = @(x) cos(x);

% inits
na = 100:100:800;
err1 = 0 * na;
err2 = err1;
err3 = err1;
h = (b - a) ./ na;

% compute errors
for i = 1:length(na)
    err1(i) = abs(1 - QuadPM(f, a, b, na(i)));
    err2(i) = abs(1 - QuadTrap(f, a, b, na(i)));
    err3(i) = abs(1 - QuadSim(f, a, b, na(i)));
end

% compute order
ordre_pm = robustfit(log(h), log(err1));
ordre_pm = sprintf('pts milieux: h^{%f}', ordre_pm(2));

ordre_trap = robustfit(log(h), log(err2));
ordre_trap = sprintf('trapezes: h^{%f}', ordre_trap(2));

ordre_sim = robustfit(log(h), log(err3));
ordre_sim = sprintf('simpson: h^{%f}', ordre_sim(2));

% draw
%hold on;
loglog(h, err1);
hold on;
grid on;
loglog(h, err2, 'r');
loglog(h, err3, 'g');

legend(ordre_pm, ordre_trap, ordre_sim, 'Location', 'SouthEast');
hold off;
