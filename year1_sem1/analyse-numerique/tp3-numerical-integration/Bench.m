% Alexandru Fikl MACS 1
% benchmark
% DOES NOT WORK
a = 0;
b = pi/2;
f = @(x) cos(x);
arr_n = [1:10:1000];
arr_time = 0 * arr_n;

i = 1;
for n = arr_n
    profile on;
    QuadSim(f, a, b, n);
    QuadSimOpt(f, a, b, n);
    profile off;
    
    p = profile('info');
    arr_time(i) = p.FunctionTable(1).TotalTime - p.FunctionTable(3).TotalTime;
    i = i + 1;
end

hold on;
plot(arr_n, arr_time);
hold off;