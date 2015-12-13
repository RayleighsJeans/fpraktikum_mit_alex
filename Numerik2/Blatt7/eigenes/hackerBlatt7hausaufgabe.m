function [] = hackerBlatt7hausaufgabe(n) % n: Anzahl Verfeinerungen
   
close all

% for n=1:4

    % Triangulation laden
    load All; % Alle Informationen �ber das Trapez und die RB laden
        
    % Netz verfeinern
    for i=1:n
        [Coords, Kanten, Element3, Dirichlet, Robin] = ...
            verfeinerung(Coords, Kanten, Element3, Dirichlet, Robin);
    end
    
    % von Kantensicht auf Knotensicht wechseln
    [Element3, Dirichlet] = getKnot(Element3, Kanten, Dirichlet);
    
    % Netz plotten
    n_k = size(Coords,1);
%     figure;
%     trisurf(Element3, Coords(:,1), Coords(:,2), zeros(n_k,1));
    
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
        Knoten = Kanten(Robin(1),1:2);
        [K_r, f_r] = robinLS(Knoten, Coords);
        K(Knoten,Knoten) = K(Knoten,Knoten) + K_r;
        f(Knoten) = f(Knoten) + f_r;
        
        Knoten = Kanten(1,1:2);
        K(Knoten,Knoten) = 0;
        
        Knoten = Kanten(2,1:2);
        K(Knoten,Knoten) = 0;
        
    % Dirichlet-Bedingung einsetzen
    n_d = size(Dirichlet,1);
    for i=1:n_d
       Knoten = Dirichlet(i);
       K(Knoten,Knoten) = K(Knoten,Knoten) + 1e8*gD(Coords(Knoten,1), Coords(Knoten,2));
       f(Knoten) = f(Knoten) + 1/3*1e8*gD(Coords(Knoten,1), Coords(Knoten,2));
    end
    
    % System Lösen
    u = K\f;
    
    % Lösung plotten
    figure;
    trisurf(Element3,Coords(:,1), Coords(:,2), u, 'EdgeColor','None');
    shading interp;
    savefig(sprintf('hackerBlatt7hausaufgabe_n=%g.fig',n));
    
    fprintf('Elemente: %d \n',n_e);
    fprintf('Kanten  : %d \n',length(Kanten(:,1)));
    fprintf('Knoten  : %d \n',n_k);
    
% end
    
save(sprintf('hackerBlatt7hausaufgabe_n=%g.mat',n));
clear all
% close all
end