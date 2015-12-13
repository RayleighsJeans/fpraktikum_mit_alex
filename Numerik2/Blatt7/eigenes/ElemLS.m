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
      % Werte der Formfunktion+Ableitung am Gauss-Punkt
      N = formf2D(g(1,1), g(1,2))+formf2D(g(2,1),g(2,2))+formf2D(g(3,1),g(3,2));
      Z = zeros(3,1);
      [Z,D] = formf2D(0,0);
      D = 3.*D;
      clear Z
      
      % Ableitung transformieren (D(x,y) N -> D(xi,eta) N)
      D = D*Jinv;
      
      % Gewicht + Transformation
      Omi = detJ*w(1);
            
      % Element-Steifigkeitsmatrix und Lastvektor
      K_e = K_e + (D*D' + (D(:,1)*x(1,:)+D(:,2)*x(2,:))*N*N')*Omi;
      f_e = f_e - 5.*x(2,:)'.*N*Omi;
end