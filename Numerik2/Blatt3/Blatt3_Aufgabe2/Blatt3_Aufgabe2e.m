function yEnd = Blatt3_Aufgabe2e(dx, dt)
   
    % Gitter in x-Richtung
    x = 0:dx:4;
    n_x = length(x)-2;
    
    % Zeitgitter
    TEnd = 20;
    t = 0:dt:TEnd;
    n_t = length(t);
    
    r = dt/dx^2;
        
    % Matrix (linke Seite) erstellen (unabhängig von t_k)
    e = ones(n_x+1,1);
    A = spdiags([e, -2*(1+1/r)*e, e], [-1 0 1], n_x+1, n_x+1);
    A(n_x+1,n_x) = 2; % Zentraler-DQ rechte Seite
    
    % Matrix rechte Seite erstellen (unabhängig von t_k)
    B = spdiags([-e, 2*(1-1/r)*e, -e], [-1 0 1], n_x+1, n_x+1);
    B(n_x+1,n_x) = -2; % Zentraler-DQ rechte Seite
            
    % Speicherplatz für Lösung
    Y = zeros(n_t, n_x+2);
    Y(1,:) = (x-4).^2; % Anfangswerte
    Y(:,1) = 15*exp(-t.^2)+1; % Linker Rand
    
    % für jeden Zeitschritt Trapezregel
    for k=1:n_t-1     
        % Vektor rechte Seite erstellen
        b = zeros(n_x+1,1);
        b(1) = -15*(exp(-t(k+1)^2)+exp(-t(k)^2)) - 2;
        
        % Zeitschritt
        Y(k+1,2:end) = A\(B*Y(k,2:end)' + b);
    end
            
    % Lösung plotten
    figure;
    for i = 1:n_t-1
        plot(x, Y(i,:));
        axis([0 4 0 18]);
        title(sprintf('t = %f', t(i)));
        drawnow;
        pause(0.5*(t(i+1)-t(i)));
    end
    plot(x, Y(end,:));
    axis([0 4 0 18]);
    title(sprintf('t = %f', t(end)));
    
    yEnd = Y(end,:);
end
