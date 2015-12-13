function [u, Coords] = Blatt7_Aufgabe1(n) % n: Anzahl Verfeinerungen
   
    % Triangulation laden
    load Coords; % Knoten mit Koordinaten
    load Kanten; % Kanten mit Knoten
    load Element3; % Elemente mit Kanten
    load Dirichlet; % Dirichlet-Kanten
    load Robin; % Robin-Kanten
        
    % Netz verfeinern
    for i=1:n
        [Coords, Kanten, Element3, Dirichlet, Robin] = ...
            verfeinerung(Coords, Kanten, Element3, Dirichlet, Robin);
    end
    
    % von Kantensicht auf Knotensicht wechseln
    [Element3, Dirichlet] = getKnot(Element3, Kanten, Dirichlet);
    
    % Netz plotten
    n_k = size(Coords,1);
    figure;
    trisurf(Element3, Coords(:,1), Coords(:,2), zeros(n_k,1));
    
    % Speicherplatz reservieren
    K = sparse(n_k, n_k);
    f = zeros(n_k,1);
    
    % für jedes Element Steifigkeitsmatrix berechnen und zusammensetzen
    n_e = size(Element3,1);
    for i=1:n_e
       Knoten = Element3(i,:);
       [K_e, f_e] = ElemLS(Knoten, Coords);
       K(Knoten, Knoten) = K(Knoten, Knoten) + K_e;
       f(Knoten) = f(Knoten) + f_e;
    end
              
    % Robin-Bedingung einsetzen
    n_r = size(Robin,1);
    for i=1:n_r
        Knoten = Kanten(Robin(i),1:2);
        [K_r, f_r] = robinLS(Knoten, Coords);
        K(Knoten,Knoten) = K(Knoten,Knoten) + K_r;
        f(Knoten) = f(Knoten) + f_r;
    end
        
    % Dirichlet-Bedingung einsetzen
    n_d = size(Dirichlet,1);
    for i=1:n_d
       Knoten = Dirichlet(i);
       K(Knoten,Knoten) = K(Knoten,Knoten) + 1e8*gD(Coords(Knoten,1), Coords(Knoten,2));
       f(Knoten) = f(Knoten) + 1e8*gD(Coords(Knoten,1), Coords(Knoten,2));
    end
    
    % System Lösen
    u = K\f;
    
    % Lösung plotten
    figure;
    trisurf(Element3,Coords(:,1), Coords(:,2), u, 'EdgeColor','None');    
    shading interp;
    
    fprintf('Elemente: %d \n',n_e);
    fprintf('Kanten  : %d \n',length(Kanten(:,1)));
    fprintf('Knoten  : %d \n',n_k);
end