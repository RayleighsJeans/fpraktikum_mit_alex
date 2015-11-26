function Blatt6_Aufgabe1(m) % m: Anzahl der Elemente
    
    % m Elemente -> m+1 Knoten
    x = linspace(1, 4, m+1);
       
    % Zuordnung Elemente -> Knoten
    elemKnot = [(1:m)', (2:m+1)'];
    
    % Speicherplatz Steifigkeitsmatrix
    K = sparse(m+1,m+1);
    
    % Speicherplatz für Lastvektor
    f = zeros(m+1,1);
    
    % Elementweiser Aufbau
    for k=1:m
        % Element-Knoten
        Knoten = elemKnot(k,:);
       
        % Element-Steifigkeit und Lastvektor
        [K_e,f_e] = ElemLS(Knoten,x);
       
        % Einfügen in Steifigkeitsmatrix
        K(Knoten,Knoten) = K(Knoten,Knoten) + K_e;
                
        % Einfügen in Lastvektor
        f(Knoten) =  f(Knoten) + f_e;
    end
    
    % Randbedingung Dirichlet
    
    % Straftechnik
    K(1,1) = K(1,1) + 1e8;
    f(1) = f(1) + 1e8;
    
    % Zeile ersetzen
    % K(1,:) = 0; K(1,1) = 1; f(1) = 1;
    
    % Randbedingung Neumann
    f(m+1) = f(m+1)-0.5;
    
    % LGS Lösen
    u = K\f;
    
    % Lösung plotten
    plot(x,u);
    
    % mit exakter Lösung vergleichen
    ex = x-2*log(x);
    hold on;
    plot(x,ex,'r*');
    fprintf('Maximale Abweichung an den Knotenpunkten: %f\n', max(abs(u-ex')));
end
    

