% Berechnet kantenweise Anteile für Robin- und Neumann-Kanten

function [K_r,f_r] = robinLS(Knoten, Coords, tau, k)
   
   x = Coords(Knoten,:)';
   % Kantenlänge
   h = norm(x(:,2) - x(:,1));
   
   % Gauß-Punkte
   [g,w] = gPunkt1D;
   
   % Speicherplatz reservieren
   K_r = zeros(2,2);
   f_r = zeros(2,1);
   
   % Gauss-Quadratur
   for i=1:length(w)
      % Werte der Formfunktion+Ableitung am Gauss-Punkt
      [N,~] = formf1D(g(i)); 
            
      % Gewicht + Transformation
      Omi = h*w(i);
      
      % x (global) am Gauss-Punkt
      xg = x(:,1) + g(i)*(x(:,2) - x(:,1));

      gamma = gammaR(xg(1),xg(2));
      
      % kantenweiser Anteil
      if x(:,2) > 0
          K_r = K_r + N*N'*Omi*2*sin(pi*tau*k);
      end    
      f_r = f_r + gamma*N*Omi;     %gamma ist 0
   end
end