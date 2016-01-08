function [A,b] = Differenzen_Bsp1(h)
    
    % Gitter erzeugen
    x = 0:h:1;
    y = 0:h:1;
        
    n_x = length(x)-2;
    n_y = length(y)-2;
    
    n = n_x*n_y;
    
    % Matrix erstellen
    e = ones(n,1);
    e1 = e;
    e1(n_x:n_x:end) = 0;
    e2 = e;
    e2(1:n_x:end) = 0;
    
    A = spdiags([-e -e1 4*e -e2 -e], [-n_x -1 0 1 n_x], n, n);
    
    % rechte Seite
    b = h^2*ones(n,1);
end