function tf = QuadPMOpt(f, a, b, n)
    % Methode composite des points milieux (vectorial)
    % Donnees:
    %   f - fonction
    %   [a, b] - interval
    %   n - nombre des points
    %
    % Alexandru Fikl MACS 1
    
    h = (b - a) / n;
    x = [a:h:b] + h / 2;
    
    tf = h * sum(f(x(1:n)));