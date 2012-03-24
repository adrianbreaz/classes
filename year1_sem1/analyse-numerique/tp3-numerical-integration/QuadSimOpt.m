function tf = QuadSimOpt(f, a, b, n)
    % Methode composite de Simpson (vectorial)
    % Donnees:
    %   f - fonction
    %   [a, b] - interval
    %   n - nombre des points
    %
    % Alexandru Fikl MACS 1
    
    h = (b - a) / n;
    x = a:h:b;
    y = f(x);
    
    tf = h / 6 * sum(y(1:n) + 4 * f(x(1:n) + h / 2) + y(2:n+1));