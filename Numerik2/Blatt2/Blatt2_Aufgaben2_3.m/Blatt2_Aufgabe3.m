function Blatt2_Aufgabe3(h)
    
    % Gitter erzeugen
    x = 0:h:6;
    y = 0:h:9;
    [X, Y] = meshgrid(x,y);
    
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
    b = 4*h^2*e;
    
    % Randbedingungen einbauen
    % bei j = n_y ("oberer Rand")
    b(end-n_x+1:end) = b(end-n_x+1:end) + 9;
    
    % bei i = 1 ("linker Rand")
    b(1:n_x:end) = b(1:n_x:end) + y(2:end-1)';
    
    % bei i = n_x ("rechter Rand")
    b(n_x:n_x:end) = b(n_x:n_x:end) + y(2:end-1)';
    
    % Lösung erstellen
    % Randbedingungen einsetzen
    u = Y;
    
    u(2:n_y+1, 2:n_x+1) = reshape(A\b, n_x, n_y)';
    
    surf(X,Y,u, 'EdgeColor', 'none');    
end