function Blatt8_Hausaufgabe(h, tol, maxIt, omega)
    % Gitter erzeugen
    x = -8:h:8;
    y = 0:h:8;
    [X,Y] = meshgrid(x,y);
        
    n_x = length(x)-2;
    n_y = length(y)-2;
    
    [A,b] = Differenzen_Bsp2(h);
    
    % LÃ¶sung erstellen
    % Randbedingungen einsetzen  
    u = 10/8*Y-5;
    
    %Lösen mittles SOR-Verfahren
    x0=zeros((n_x+2)*n_y,1);
    [u_sor, res]=sor(A,b,x0,h,tol,maxIt,omega);
    
    u(2:n_y+1, 1:n_x+2) = reshape(u_sor, n_x+2, n_y)';
        
    figure;
    surf(X,Y,u, 'EdgeColor', 'none'); 
    
end