function tf = QuadTrapOpt(f, a, b, n)
    % Methode composite des trapezes (vectorial)
    % Donnees:
    %   f - fonction
    %   [a, b] - interval
    %   n - nombre des points
    %
    % Alexandru Fikl MACS 1
    
    h = (b - a) / n;
    x = a:h:b;
    y = f(x);
    
    tf = h / 2 * sum(y(1:n) + y(2:n+1));