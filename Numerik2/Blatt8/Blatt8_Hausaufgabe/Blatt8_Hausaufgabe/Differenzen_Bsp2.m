function [A,b] = Differenzen_Bsp2(h)
    
    % Gitter erzeugen
    x = -8:h:8;
    y = 0:h:8;
    
    n_x = length(x)-2;
    n_y = length(y)-2;
    
    n = (n_x+2)*n_y;
    
    % Matrix erstellen
    e = ones(n,1);
    e1 = e;
    e1(n_x+2:n_x+2:end) = 0;
    e2 = e;
    e2(1:n_x+2:end) = 0;
    
    A = spdiags([-e -e1 (4+h^2)*e -e2 -e], [-(n_x+2) -1 0 1 n_x+2], n, n);
       
    % rechte Seite
    b = zeros(n,1);
    
    % Randbedingungen einbauen
    % bei j = 1 ("unterer Rand"), Dirichlet
    b(1:n_x+2) = -5;
    
    % bei j = N_x ("oberer Rand"), Dirichlet
    b(end-(n_x+2)+1:end) = 5; 
    
    % bei i = 0 ("linker Rand"), Neumann
    A(sub2ind([n,n],1:n_x+2:n, 2:n_x+2:n)) = -2;
    b(1:n_x+2:end) = b(1:n_x+2:end) - 4*h;
    
    % bei i = n_x+1 ("rechter Rand"), Neumann
    A(sub2ind([n,n],n_x+2:n_x+2:n, n_x+1:n_x+2:n)) = -2;
    b(n_x+2:n_x+2:end) = b(n_x+2:n_x+2:end) + 10*h;
end