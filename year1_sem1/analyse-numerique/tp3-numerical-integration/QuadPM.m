function tf = QuadPM(f, a, b, n)
    % Methode composite des points milieux
    % Donnees:
    %   f - fonction
    %   [a, b] - interval
    %   n - nombre des points
    %
    % Alexandru Fikl MACS 1
    
    h = (b - a) / n;
    x = [a:h:b] + h / 2;
    
    tf = 0;
    for i = 1:n
        tf = tf + f(x(i));
    end
    
    tf = h * tf;