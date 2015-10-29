function Blatt2_Aufgabe2(n)
    
    % Gitter erzeugen
    x = linspace(0, 2, n+2);
    h = x(2)-x(1);
    
    % Matrix erzeugen
    e = ones(n+1,1);
    A = spdiags([e (h^2*pi^2 - 2)*e e], [-1 0 1], n+1, n+1);
    A(n+1, n) = -h;
    A(n+1, n+1) = h;
    
    % rechte Seite erzeugen
    b = zeros(n+1,1);
    b(n+1) = h^2*pi;
    
    % Lösung erstellen
    u(2:n+2) = A\b;
    u(1) = 0;
    
    % Plotten
    plot(x, u); 
end

