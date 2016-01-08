function [] = weihnachtsaufgabe_hacker;

warning off
close all

% T: Endzeit in Sekunden
sig = 0.25;
tau = 0.02;
n = 5;
T = 5;

    % Triangulation laden
    load Coords; % Knoten mit Koordinaten
    load Kanten; % Kanten mit Knoten
    load Element3; % Elemente mit Kanten
    load Dirichlet; % Dirichlet-Kanten
    load Robin; % Robin-Kanten

    % Zeitschrittweite und Gitter
    t = 0:tau:T;
    n_t = length(t);
    
    % Netz verfeinern
    for i=1:n
        [Coords, Kanten, Element3, Dirichlet, Robin] = ...
        verfeinerung(Coords, Kanten, Element3, Dirichlet, Robin);
    end

    % von Kantensicht auf Knotensicht wechseln
    [Element3, Dirichlet] = getKnot(Element3, Kanten, Dirichlet);

    n_k = size(Coords,1);
    % Speicherplatz reservieren
    M = sparse(n_k,n_k);
    K = sparse(n_k, n_k);
    f = zeros(n_k,1);

    % fÃ¼r jedes Element zeitunabhÃ¤ngige Matrizen/Vektoren berechnen und zusammensetzen
    n_e = size(Element3,1);
    for i=1:n_e
        Knoten = Element3(i,:);
        [M_e, K_e, f_e] = ElemLS(Knoten, Coords);
        M(Knoten, Knoten) = M(Knoten, Knoten) + M_e;
        K(Knoten, Knoten) = K(Knoten, Knoten) + K_e;
        f(Knoten) = f(Knoten) + f_e;
    end
        
    % Speicherplatz + AnfangslÃ¶sung
    c = zeros(n_k, n_t);
    % Nach zweiter Anfangsbedingung gemacht
    c(:,1) = tau.*sin(pi.*Coords(:,1)).*sin(pi.*Coords(:,2));

    % FÃ¼r jeden Zeitschritt...
    for k=1:n_t-1
            
        time = k*tau;
        n_r = size(Robin,1);
        
        % Robin-RB einsetzen, für f kommt nichts dazu, für K schon
        % RB mit -2*sin(...)
        for j=1:n_r
            Knoten = Kanten(Robin(j),1:2);
            [K_r] = robinLS(Knoten, Coords, time);
            K(Knoten,Knoten) = K(Knoten,Knoten) + K_r;
        end
        
            % Dirichlet-Bedingung einsetzen
            n_d = size(Dirichlet,1);
            
            for i=1
                Knoten = Dirichlet(i);
                if (k*tau<2) && (i==1)
                    % Für f kommt, mit der Strafmethode, die Anregung der
                    % Schwingung rein
                    M(Knoten,Knoten) = M(Knoten,Knoten) + 1e8;
                    K(Knoten,Knoten) = K(Knoten,Knoten) + 1e8;
                    f(Knoten) = f(Knoten) + 1e8*sin(pi*time)*Coords(Knoten,2)*(2-Coords(Knoten,2));
                else
                    % Sonst passiert nichts
                    M(Knoten,Knoten) = M(Knoten,Knoten) + 1e8;
                    K(Knoten,Knoten) = K(Knoten,Knoten) + 1e8;
                    f(Knoten) = f(Knoten) + 1e8;
                end
            end
            
            % Schreibe 2 kurze Matrizen, die ich günstig benutzen kann
            % später
            A=M+tau^2*K*sig;
            B=(2*M-(1-2*sig)*tau^2*K);
          
              % Differenziere zwischen erstem Zeitschritt und allen
              % weiteren
              if k==1
                   b = B*c(:,1)+tau^2*f;
              else
                  % Sonst, wie auf Blatt vorgeschlagen
                   b = B*c(:,k) - A*c(:,k-1)+tau^2*f;
              end

          % Ganz einfach \-Operator
          c(:,k+1) = A\b;
          
    end

    % Schaue mir die Lösung an
    figure;
    for i = 1:5:n_t
        trisurf(Element3, Coords(:,1), Coords(:,2), c(:,i), 'EdgeColor','None');
        colorbar;
        caxis([0 1.7]);
        axis([0 5 0 2 -1 2.5]);
        shading interp;
        title(sprintf('t = %f', t(i)));
        drawnow;
    end
    savefig('endzeit_plot.fig');
        
save('weihnachten.mat');   
        
end

%% Protokoll

%% >> weihnachtsaufgabe_hacker
%% >>
