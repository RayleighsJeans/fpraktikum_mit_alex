function hacker_blatt9hausaufgabe % T: Endzeit in Sekunden

warning off
clear all
close all

T = 60;
n = 5;
tau = 0.2;

    % Triangulation laden
    load AllData
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

%     % Speicherplatz reservieren
%     M = sparse(n_k,n_k);
%     K = sparse(n_k, n_k);
%     f = zeros(n_k,1);
% 
%     % fÃ¼r jedes Element zeitunabhÃ¤ngige Matrizen/Vektoren berechnen und zusammensetzen
%     n_e = size(Element3,1);
%     for i=1:n_e
%         Knoten = Element3(i,:);
%         [M_e, K_e, f_e] = ElemLS(Knoten, Coords);
%         M(Knoten, Knoten) = M(Knoten, Knoten) + M_e;
%         K(Knoten, Knoten) = K(Knoten, Knoten) + K_e;
%         f(Knoten) = f(Knoten) + f_e;
%     end
% 
%     % Robin-Bedingung einsetzen (zeitunabhÃ¤ngiger Anteil)
%     n_r = size(Robin,1);
%     for i=1:n_r
%         Knoten = Kanten(Robin(i),1:2);
%         [K_r, f_r] = robinLS(Knoten, Coords);
%         K(Knoten,Knoten) = K(Knoten,Knoten) + K_r;
%         f(Knoten) = f(Knoten) + f_r;
%     end
% 
%     % Masse- und Steifigkeitsmatrix zusammensetzen
%     S = M+tau/2*K;
%     S2 = (M-tau/2*K);
% 
%     % Dirichlet-Bedingung einsetzen (keine vorhanden, nur formal drin)
%     n_d = size(Dirichlet,1);
%     for i=1:n_d
%         Knoten = Dirichlet(i);
%         S(Knoten,Knoten) = S(Knoten,Knoten) + 1e10;
%     end
% 
%     % Speicherplatz + AnfangslÃ¶sung
%     u = zeros(n_k, n_t);
%     u(:,1) = 20;
% 
%     % Für jeden Zeitschritt...
%     
%     % Zeitschritte
%     time_it = 1:1:n_t-1;
%     
%     % \-Operator
%     
%         %Zeitmessung
%         tic;
%         bs_time = zeros(n_t-1,1);
% 
%         for k=1:n_t-1
%             b = S2*u(:,k) + tau*f;
% 
%             % Dirichlet-Bedingung einsetzen (keine vorhanden, nur formal drin)
%             for i=1:n_d 
%                 Knoten = Dirichlet(i);
%                 b(Knoten) = b(Knoten) + 1e10*gD(Coords(Knoten,:));
%             end
%             
%             %Operator anwenden
%             u(:,k+1) = S\b;
%             bs_time(k) = toc;
%         end
%         
%     %mittlere Dauer ausrechnen
%     mean_bs_time = sum(bs_time(:))/length(bs_time);
%     
%         % Lösung plotten, Endzeit
%         figure;
%         title('Backslash-Operator');
%         trisurf(Element3, Coords(:,1), Coords(:,2), zeros(n_k,1), u(:,n_t), 'EdgeColor','None');
%         colorbar;
%         caxis([0 160]);
%         axis([-2 2 -2 2 -1 1]);
%         view(0,90);
%         shading interp;
%         title(sprintf('t = %f', t(n_t)));
%         savefig('bs_operator.fig');
%         
%         %Lösung plotten (animiert), auskommentieren, falls zu langsam!
%         figure;
%         title('Backslash-Operator');
%         for i = 1:10:n_t
%             trisurf(Element3, Coords(:,1), Coords(:,2), zeros(n_k,1), u(:,i), 'EdgeColor','None');
%             colorbar;
%             caxis([0 160]);
%             axis([-2 2 -2 2 -1 1]);
%             view(0,90);
%             shading interp;
%             title(sprintf('t = %f', t(i)));
%             drawnow;
%         end
%         close
% 
%     
%     u_cg = zeros(n_k, n_t);
%     % cg-Verfahren
%     
%         %Zeitmessung
%         tic;
%         cg_time = zeros(n_t-1,1);
%         rounds_cg = zeros(n_t-1,1);
% 
%         for k=1:n_t-1
%             %Starvektor und rechte Seite
%             x0 = zeros(n_k,1);
%             b = S2*u_cg(:,k) + tau*f;
% 
%             % Dirichlet-Bedingung einsetzen (keine vorhanden, nur formal drin)
%             for i=1:n_d 
%                 Knoten = Dirichlet(i);
%                 b(Knoten) = b(Knoten) + 1e10*gD(Coords(Knoten,:));
%             end
% 
%             %für jeden Schritt in der Zeit cg-Verfahren mit x0 = 0
%             [u_cg(:,k+1),it] = cg(S,b,x0,1e-6,1000);
%             %Iterationen und Zeit aufschreiben
%             cg_time(k) = toc;
%             rounds_cg(k) = it;
%         end
%     
%     %mittleren Dauern/Iterationen ausrechnen
%     mean_cg_time = sum(cg_time(:))/length(cg_time);
%     mean_cg_it = sum(rounds_cg(:))/length(rounds_cg);
%     
%         % Lösung plotten, Endzeit
%         figure;
%         title('cg-Verfahren');
%         trisurf(Element3, Coords(:,1), Coords(:,2), zeros(n_k,1), u_cg(:,n_t), 'EdgeColor','None');
%         colorbar;
%         caxis([0 160]);
%         axis([-2 2 -2 2 -1 1]);
%         view(0,90);
%         shading interp;
%         title(sprintf('t = %f', t(n_t)));
%         savefig('cg_verfahren.fig');
%         
%         %Lösung plotten (animiert), auskommentieren, falls zu langsam!
%         figure;
%         title('cg-Verfahren');
%         for i = 1:10:n_t
%             trisurf(Element3, Coords(:,1), Coords(:,2), zeros(n_k,1), u_cg(:,i), 'EdgeColor','None');
%             colorbar;
%             caxis([0 160]);
%             axis([-2 2 -2 2 -1 1]);
%             view(0,90);
%             shading interp;
%             title(sprintf('t = %f', t(i)));
%             drawnow;
%         end
%         close
%         
%     u_cg_b = zeros(n_k, n_t);
%     % besseres cg-Verfahren
%         
%         %Zeitmessung
%         tic;
%         cg_b_time = zeros(n_t-1,1);
%         rounds_cg_b = zeros(n_t-1,1);
% 
%         for k=1:n_t-1
%             b = S2*u_cg_b(:,k) + tau*f;
% 
%             % Dirichlet-Bedingung einsetzen (keine vorhanden, nur formal drin)
%             for i=1:n_d 
%                 Knoten = Dirichlet(i);
%                 b(Knoten) = b(Knoten) + 1e10*gD(Coords(Knoten,:));
%             end
%             
%             %verbessertes cg-Verfahren mit dem u aus dem k-1-ten
%             %Zeitschritt (vorher)
%             [u_cg_b(:,k+1),it] = cg(S,b,u_cg_b(:,k),1e-6,1000);
%             cg_b_time(k) = toc;
%             rounds_cg_b(k) = it;
%         end
%    
%     %Mittel ausrechnen
%     mean_cg_b_time = sum(cg_b_time(:))/length(cg_b_time);
%     mean_cg_b_it = sum(rounds_cg_b(:))/length(rounds_cg_b);
%     
%         % Lösung plotten, Endzeit
%         figure;
%         title('besseres cg-Verfahren');
%         trisurf(Element3, Coords(:,1), Coords(:,2), zeros(n_k,1), u_cg_b(:,n_t), 'EdgeColor','None');
%         colorbar;
%         caxis([0 160]);
%         axis([-2 2 -2 2 -1 1]);
%         view(0,90);
%         shading interp;
%         title(sprintf('t = %f', t(n_t)));
%         savefig('cg_b_verfahren.fig');
%         
%         %Lösung plotten (animiert), auskommentieren, falls zu langsam!
%         figure;
%         title('besseres cg-Verfahren');
%         for i = 1:10:n_t
%             trisurf(Element3, Coords(:,1), Coords(:,2), zeros(n_k,1), u_cg_b(:,i), 'EdgeColor','None');
%             colorbar;
%             caxis([0 160]);
%             axis([-2 2 -2 2 -1 1]);
%             view(0,90);
%             shading interp;
%             title(sprintf('t = %f', t(i)));
%             drawnow;
%         end
%         close
% 
%     
%     %Betrachte den Verlauf der Rechendauern über die Zeitschritte
%     figure;
%     hold on;
%     plot(time_it,cg_time,'-.r','Linewidth',2);
%     plot(time_it,cg_b_time,':b','Linewidth',2);
%     plot(time_it,bs_time,'--g','Linewidth',2); 
%     legend('cg-Verfahren','besseres cg-Verfahren','Backslash-Operator');
%     grid on; grid minor;
%     savefig('zeitverlauf_cg_b.fig');
%     hold off;
%     
%     %Betrachte den Verlauf der Rechendauern über die Zeitschritte
%     figure;
%     hold on;
%     plot(time_it,rounds_cg,'-.r','Linewidth',2);
%     plot(time_it,rounds_cg_b,':b','Linewidth',2);    
%     legend('cg-Verfahren','besseres cg-Verfahren');
%     grid on; grid minor;
%     savefig('iterationverlauf_cg_b.fig');
%     hold off;
% 
% %Gebe die ausgerechneten Werte aus.
%     
% fprintf(1,'Die durchschnittlichen Dauern von Backslash-Operator, cg-Verfahren und verbessertem cg-Verfahren sind:\n');
% 
%     disp(mean_bs_time);
%     disp(mean_cg_time);
%     disp(mean_cg_b_time);
%     
% fprintf(1,'Die durchschnittlichen Iterationszahlen von cg-Verfahren und verbessertem cg-Verfahren sind:\n');
% 
%     disp(mean_cg_it);
%     disp(mean_cg_b_it);
%     
% save('hacker_blatt9_daten.mat');
% 
% clear all
end