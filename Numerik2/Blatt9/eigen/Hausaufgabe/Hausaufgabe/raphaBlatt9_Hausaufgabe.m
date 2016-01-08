% Aufruf [u, Coords] = Blatt9_Hausaufgabe(5, 1, 720);

function [u, Coords] = raphaBlatt9_Hausaufgabe(n, tau, T, loeser) % T: Endzeit in Sekunden

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

    % Netz plotten
    n_k = size(Coords,1);
    figure;
    trisurf(Element3, Coords(:,1), Coords(:,2), zeros(n_k,1));

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

    % Robin-Bedingung einsetzen (zeitunabhÃ¤ngiger Anteil)
    n_r = size(Robin,1);
    for i=1:n_r
        Knoten = Kanten(Robin(i),1:2);
        [K_r, f_r] = robinLS(Knoten, Coords);
        K(Knoten,Knoten) = K(Knoten,Knoten) + K_r;
        f(Knoten) = f(Knoten) + f_r;
    end

    % Masse- und Steifigkeitsmatrix zusammensetzen
    S = M+tau/2*K;
    S2 = (M-tau/2*K);

    % Dirichlet-Bedingung einsetzen (keine vorhanden, nur formal drin)
    n_d = size(Dirichlet,1);
    for i=1:n_d
        Knoten = Dirichlet(i);
        S(Knoten,Knoten) = S(Knoten,Knoten) + 1e10;
    end

    % Speicherplatz + AnfangslÃ¶sung
    u = zeros(n_k, n_t);
    u(:,1) = 20;

    % FÃ¼r jeden Zeitschritt...
    
    if loeser == 1       %lösen mit dem \-Operator
          laufzeit=zeros(n_t-1,1);
          for k=1:n_t-1
               b = S2*u(:,k) + tau*f;

               % Dirichlet-Bedingung einsetzen (keine vorhanden, nur formal drin)
               for i=1:n_d 
                    Knoten = Dirichlet(i);
                    b(Knoten) = b(Knoten) + 1e10*gD(Coords(Knoten,:));
               end
               tic
               u(:,k+1) = S\b;
               laufzeit(k)=toc;
          end
          fprintf('Durchschnittliche Laufzeit: %e \n', sum(laufzeit)/length(laufzeit))
    elseif loeser == 2   %lösen mit dem cg-Verfahren und dem Anfangswert 0
          x0=zeros(n_k,1);
          laufzeit=zeros(n_t-1,1);
          iterationen=zeros(n_t-1,1);
          for k=1:n_t-1
               b = S2*u(:,k) + tau*f;

               % Dirichlet-Bedingung einsetzen (keine vorhanden, nur formal drin)
               for i=1:n_d 
                    Knoten = Dirichlet(i);
                    b(Knoten) = b(Knoten) + 1e10*gD(Coords(Knoten,:));
               end
               tic
               [u(:,k+1),it] = cg(S,b,x0,10^-6,1000);
               laufzeit(k)=toc;
               iterationen(k) = it;
          end
          fprintf('Durchschnittliche Iterationszahl: %e \n Durchschnittliche Laufzeit: %e \n',sum(iterationen)/length(iterationen), sum(laufzeit)/length(laufzeit))
    else                 %lösen mit dem cg-Verfahren und der vorhergehenden Temperatur als Anfangswert
         laufzeit=zeros(n_t-1,1);
         iterationen=zeros(n_t-1,1);
         for k=1:n_t-1
               b = S2*u(:,k) + tau*f;

               % Dirichlet-Bedingung einsetzen (keine vorhanden, nur formal drin)
               for i=1:n_d 
                    Knoten = Dirichlet(i);
                    b(Knoten) = b(Knoten) + 1e10*gD(Coords(Knoten,:));
               end
               tic
               [u(:,k+1),it] = cg(S,b,u(:,k),10^-6,1000);
               laufzeit(k)=toc;
               iterationen(k) = it;
          end
          fprintf('Durchschnittliche Iterationszahl: %e \n Durchschnittliche Laufzeit: %e \n',sum(iterationen)/length(iterationen), sum(laufzeit)/length(laufzeit))
    endif
    
    % LÃ¶sung plotten (animiert), auskommentieren, falls zu langsam!
%         figure;
%         for i = 1:n_t
%             trisurf(Element3, Coords(:,1), Coords(:,2), zeros(n_k,1), u(:,i), 'EdgeColor','None');
%             colorbar;
%             caxis([0 160]);
%             axis([-2 2 -2 2 -1 1]);
%             view(0,90);
%             shading interp;
%             title(sprintf('t = %f', t(i)));
%             drawnow;
%         end

    % LÃ¶sung plotten, Endzeit
    figure;
    trisurf(Element3, Coords(:,1), Coords(:,2), zeros(n_k,1), u(:,n_t), 'EdgeColor','None');
    colorbar;
    caxis([0 160]);
    axis([-2 2 -2 2 -1 1]);
    view(0,90);
    shading interp;
    title(sprintf('t = %f', t(n_t)));
end

%Protokoll:
%n=5, maxIt=1000, tol=10^-6, tau=1
%zu a)
%     Durchschnittliche Laufzeit: 1.264656e-002
%zu b)
%     Durchschnittliche Iterationszahl: 2.138194e+001
%     Durchschnittliche Laufzeit: 6.644822e-003
%zu c)
%     Durchschnittliche Iterationszahl: 1.339306e+001
%     Durchschnittliche Laufzeit: 4.246074e-003
%     
%Das cg-Verfahren ist für beide Anfangsbedingungen schneller als der \-Operator. Wählt man den Anfangswert zusätzlich noch klug ( in c) ), 
%kann die Iterationszahl zum Lösen des Gleichungssystems nocheinmal um fast die Hälfte verkleinert werden.