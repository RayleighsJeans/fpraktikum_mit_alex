function [u, Coords] = Blatt10_Hausaufgabe_rataj(n, tau, T, tol, maxIt, sigma, loes) % T: Endzeit in Sekunden

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

    figure;
    trisurf(Element3, Coords(:,1), Coords(:,2), zeros(n_k,1));

    % Speicherplatz reservieren
    M = sparse(n_k,n_k);
    K = sparse(n_k, n_k);
    f = zeros(n_k,1);
     
    % für jedes Element zeitunabhängige Matrizen/Vektoren berechnen und zusammensetzen
    n_e = size(Element3,1);
    for i=1:n_e
        Knoten = Element3(i,:);
        [M_e, K_e, f_e] = ElemLS(Knoten, Coords);
        M(Knoten, Knoten) = M(Knoten, Knoten) + M_e;
        K(Knoten, Knoten) = K(Knoten, Knoten) + K_e;
        f(Knoten) = f(Knoten) + f_e;
        %c(i,1) = c(i,1) + tau*sin(pi*x(i,1))*sin(pi*x(i,2));
    end
    x0 = zeros(n_k,1); % Startlösung cg
    iter = zeros(n_t-1,1);
    
    % Speicherplatz + Anfangslösung
    c = zeros(n_k, n_t);
    c(:,1) = tau*(sin(pi*Coords(:,1)).*sin(pi*Coords(:,2)));
    
    n_r = size(Robin,1);
    
    % Zeitmessung
    tic;
    
    % Für jeden Zeitschritt...
    for k=1:n_t-1
        
        % Robin-Bedingung einsetzen (zeitunabhängiger Anteil)
          for i=1:n_r
               Knoten = Kanten(Robin(i),1:2);
               [K_r, f_r] = robinLS(Knoten, Coords,tau,k);
               K(Knoten,Knoten) = K(Knoten,Knoten) + K_r;
               f(Knoten) = f(Knoten) + f_r;
          end
          
          % Dirichlet-Bedingung einsetzen
          n_d = size(Dirichlet,1);
          
          for i=1:n_d
               Knoten = Dirichlet(i);
               K(Knoten,Knoten) = K(Knoten,Knoten) + 1e15;
               M(Knoten,Knoten) = K(Knoten,Knoten) + 1e15;
               f(Knoten) = f(Knoten) + 1e15.*gD(Coords(Knoten,1),Coords(Knoten,2),tau,k);
          end
          
          S1=M+tau^2*K*sigma;
          S2=(2*M-(1-2*sigma)*tau^2*K);
          
          if k==1
               b = S2*c(:,1)+tau^2*f;                  %Anfangsbedingung mit Neumann (in 2)
          else
               b = S2*c(:,k) - S1*c(:,k-1)+tau^2*f;
          end
          
          
          switch loes
            case 1, % Matlab-Löser
              c(:,k+1) = S1\b;
              iter(k) = 1;
            case 2, % cg-Verfahren
              [c(:,k+1), iter(k)] = cg(S1,b,x0,tol,maxIt);               
            case 3, % cg-Verfahren mit besserem Startwert
              [c(:,k+1), iter(k)] = cg(S1,b,c(:,k),tol,maxIt);  
            otherwise
              c(:,k+1) = S1\b;
              iter(k) = 1;  
          end
          trisurf(Element3, Coords(:,1), Coords(:,2), c(:,k+1), 'EdgeColor','None');
          axis([0 4 0 2 -1 1]);
          title(sprintf('t = %f', (k+1)*tau));
          drawnow;
    end
    
    t_LGS = toc;
    fprintf('Zeit zum Lösen der Gleichungssysteme: %f\n', t_LGS);
    figure()
    plot(iter(:))
    % Lösung plotten (animiert), auskommentieren, falls zu langsam!
%     figure;
%     for i = 1:n_t
%         trisurf(Element3, Coords(:,1), Coords(:,2), zeros(n_k,1), u(:,i), 'EdgeColor','None');
%         colorbar;
%         caxis([0 160]);
%         axis([-2 2 -2 2 0 160]);
%         view(0,90);
%         shading interp;
%         title(sprintf('t = %f', t(i)));
%         drawnow;
%     end

    % Lösung plotten, Endzeit
    figure;
    trisurf(Element3, Coords(:,1), Coords(:,2), c(:,n_t), 'EdgeColor','None');
    shading interp;
    title(sprintf('t = %f', t(n_t)));
    
    fprintf('Durchschnittliche Iterationszahl: %2.0f\n', mean(iter));
end

% Protokoll der Ausgabe:
%
% Blatt9_Hausaufgabe(5, 1, 720, 1e-8, 1000, 1);
% Zeit zum Lösen der Gleichungssysteme: 13.413853
% Durchschnittliche Iterationszahl:  1
%
% [u,Coords] = Blatt9_Hausaufgabe(5, 1, 720, 1e-6, 1000, 2);
% Zeit zum Lösen der Gleichungssysteme: 5.829567
% Durchschnittliche Iterationszahl: 21
% [u,Coords] = Blatt9_Hausaufgabe(5, 1, 720, 1e-6, 1000, 3);
% Zeit zum Lösen der Gleichungssysteme: 4.316512
% Durchschnittliche Iterationszahl: 13
% 
% Offenbar ist cg wesentlcih schneller als das direkte Lösen mit dem
% \-Operator. Die Verwendung der besseren Startlösung verringert die
% Iterationszahl und damit die Rechenzeit noch weiter.
%
%