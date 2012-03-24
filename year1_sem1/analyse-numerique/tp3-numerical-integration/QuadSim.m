function tf = QuadSim(f, a, b, n)
    % Methode composite de Simpson
    % Donnees:
    %   f - fonction
    %   [a, b] - interval
    %   n - nombre des points
    %
    % Alexandru Fikl MACS 1
    
    h = (b - a) / n;
    x = a:h:b;
    y = f(x);
    
    tf = 0;
    for i = 1:n
        tf = tf + y(i) + 4 * f(x(i) + h / 2) + y(i + 1);
    end
    
    tf = h / 6 * tf;