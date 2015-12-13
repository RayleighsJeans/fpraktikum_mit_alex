% Berechnet kantenweise Anteile für Robin- und Neumann-Kanten

function [K_r,f_r] = robinLS(Knoten, Coords)
   
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
      
      % Daten für Robin-Kanten
      alpha = alphaR(xg(1),xg(2));
      gamma = gammaR(xg(1),xg(2));
      
      % kantenweiser Anteil
      K_r = K_r + alpha*N*N'*Omi;
      f_r = f_r + gamma*x(1,:)'.*N*Omi;
   end
end