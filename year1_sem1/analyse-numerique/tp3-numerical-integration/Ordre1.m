% Alexandru Fikl MACS 1
% donnees
a = 0;
b = 2;
n = 10;

for d = 0:3
    f = @(x) x.^d;
    sol = quad(f, a, b);
    diffPM = abs(sol - QuadPMOpt(f, a, b, n));
    diffTrap = abs(sol - QuadTrapOpt(f, a, b, n));
    diffSim = abs(sol - QuadSimOpt(f, a, b, n));
    fprintf('P(x) = x.^%d:\n', d);
    fprintf('Erreurs: pm: %e trap: %e sim: %e\n', diffPM, diffTrap, diffSim);
end