% Berechnet kantenweise Anteile für Robin- und Neumann-Kanten

function [K_r] = robinLS(Knoten, Coords, time)
   
   x = Coords(Knoten,:)';
   % Kantenlänge
   h = norm(x(:,2) - x(:,1));
   
   % Gauß-Punkte
   [g,w] = gPunkt1D;
   
   % Speicherplatz reservieren
   K_r = zeros(2,2);
   
   % Gauss-Quadratur
   for i=1:length(w)
      % Werte der Formfunktion+Ableitung am Gauss-Punkt
      [N,~] = formf1D(g(i)); 
            
      % Gewicht + Transformation
      Omi = h*w(i);
      
      % x (global) am Gauss-Punkt
      xg = x(:,1) + g(i)*(x(:,2) - x(:,1));
      
      % kantenweiser Anteil, darauf achten: nur ab y>=2
      if x(:,2) > 0
        K_r = K_r + N*N'*Omi*2*sin(pi*time);
      end
   end
end