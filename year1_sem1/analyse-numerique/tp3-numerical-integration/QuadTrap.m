function tf = QuadTrap(f, a, b, n)
    % Methode composite des trapezes
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
        tf = tf + y(i) + y(i + 1);
    end
    
    tf = h / 2 * tf;