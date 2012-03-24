function x = ResTriInf(A, b)
    % ResTriInf
    %   Resolution du systeme lineaire A*x=b
    %   ou A est une matrice triangulaire inferieure inversible de
    %   dimension n, b un vecteur de R^n.
    % USAGE
    %   x=ResTriInf(A,b);
    % REMARQUE :
    %   Non Matlab-optimisee (pour "coller" au poly d'algorithmique)
    % AUTEUR :
    %   F. Cuvelier
    % VERSION :
    %   du 18/11/2011
    n = size(b, 1);
    x = zeros(n, 1);

    for i = 1:n
        S = 0;
        for j = 1:i - 1
            S = S + A(i, j) * x(j);
        end

        if A(i, i) == 0
            error('Matrice non inversible');
        end

        x(i) = (b(i) - S) / A(i, i);
    end
