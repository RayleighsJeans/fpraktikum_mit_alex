% Netz verfeinern
% Aus einem Dreieck werden vier neue Dreiecke

function [Coords, Kanten, Element3, Dirichlet, Robin] = verfeinerung(Coords, Kanten, Element3, Dirichlet, Robin)
    
    n_k = size(Coords,1); % Anzahl Knoten
    n_ka = size(Kanten,1); % Anzahl der Kanten
    n_e = size(Element3,1); % Anzahl Elemente
    
    % jede Kanten Teilen -> Mittelpunkte sind neue Knoten
    for i=1:n_ka
        mP = 0.5*(Coords(Kanten(i,1),:) + Coords(Kanten(i,2),:)); % Mittelpunkt
        Coords(n_k+i,:) = mP; % neuen Knoten speichern
        
        Kanten(n_ka+2*i-1,1:2) = [Kanten(i,1), n_k+i]; % neue Kanten erstellen
        Kanten(n_ka+2*i,1:2) = [Kanten(i,2), n_k+i];
        
        Kanten(i,3) = n_k+i; % Mittelpunkt speichern
        Kanten(i,4:5) = [n_ka+2*i-1, n_ka+2*i]; % Sohnkanten speichern
    end
    
    % Dirichlet-Kanten erneuern (Sohn-Kanten ersetzen Vaterkanten)
    Dirichlet = [Kanten(Dirichlet,4); Kanten(Dirichlet,5)];
    
    % Robin-Kanten erneuern (Sohn-Kanten ersetzen Vaterkanten)
    Robin = [Kanten(Robin,4); Kanten(Robin,5)];
    
    n_ka2 = size(Kanten,1); % Anzahl der Kanten aktualisieren
    
    % jedes Dreieck teilen -> vier neue Dreiecke
    for i=1:n_e
        % innere Kanten erstellen (Mittelpunkte verbinden)
        Kanten(n_ka2+3*i-2,1:2) = [Kanten(Element3(i,1),3) Kanten(Element3(i,2),3)];
        Kanten(n_ka2+3*i-1,1:2) = [Kanten(Element3(i,2),3) Kanten(Element3(i,3),3)];
        Kanten(n_ka2+3*i  ,1:2) = [Kanten(Element3(i,3),3) Kanten(Element3(i,1),3)];
        
        % Inneres Element erstellen
        Element3(n_e+4*i-3,:) = [n_ka2+3*i-2, n_ka2+3*i-1, n_ka2+3*i];
        
        % Für Kante 1 und 2 im Element: Sohn-Kanten gemeinsamen Knoten finden
        [Sohn1, Sohn2] = commonKnot(Kanten, Element3(i,1), Element3(i,2));
        Element3(n_e+4*i-2,:) = [Sohn1, Sohn2, n_ka2+3*i-2];
        
        % Für Kante 2 und 3 im Element: Sohn-Kanten gemeinsamen Knoten finden
        [Sohn1, Sohn2] = commonKnot(Kanten, Element3(i,2), Element3(i,3));
        Element3(n_e+4*i-1,:) = [Sohn1, Sohn2, n_ka2+3*i-1];
        
        % Für Kante 1 und 3 im Element: Sohn-Kanten gemeinsamen Knoten finden
        [Sohn1, Sohn2] = commonKnot(Kanten, Element3(i,1), Element3(i,3));
        Element3(n_e+4*i  ,:) = [Sohn1, Sohn2, n_ka2+3*i];
    end
    
    % Alte Elemente und Kanten vergessen
    Element3(1:n_e,:) = [];
    Element3 = Element3 - n_ka;
    Dirichlet = Dirichlet - n_ka;
    Robin = Robin - n_ka;
    Kanten(1:n_ka,:) = [];
end