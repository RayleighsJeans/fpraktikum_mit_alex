% berechnet Element-Steifigkeitsmatrix und -Lastvektor

function [K_e,f_e] = ElemLS(Knoten, Coords)
      
   % Jacobi-Matrix der Koordinatentransformation
   x = Coords(Knoten,:)';
   J = [x(:,2) - x(:,1) x(:,3) - x(:,1)];
   
   % Determinante
   detJ = abs(det(J));
   
   % Inverse
   Jinv = inv(J);
   
   % Gauß-Punkte (2D)
   [g,w] = gPunkt2D;
   
   % Speicherplatz reservieren
   K_e = zeros(3,3);
   f_e = zeros(3,1);
   
   % Gauss-Quadratur
   for i=1:length(w)
      % Werte der Formfunktion+Ableitung am Gauss-Punkt
      [N,D] = formf2D(g(i,1), g(i,2)); 
      
      % Ableitung transformieren (D(x,y) N -> D(xi,eta) N)
      D = D*Jinv;
      
      % Gewicht + Transformation
      Omi = detJ*w(i);
            
      % Element-Steifigkeitsmatrix und Lastvektor
      K_e = K_e + (D*D' + 2*N*N')'*Omi;
      f_e = f_e + 2*N*Omi;
   end
end