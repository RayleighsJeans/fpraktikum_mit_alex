% berechnet Element-Steifigkeitsmatrix, -Massematrix und -Lastvektor

function [M_e,K_e,f_e] = ElemLS(Knoten, Coords)
      
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
   M_e = zeros(3,3);
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
      
      % x (global) am Gaußpunkt
      xg = x(:,1) + J*g(i,:)';
      % Parameter der Gleichung
      a = au(xg(1),xg(2));
      c = cu(xg(1),xg(2));
      d = du(xg(1),xg(2));
            
      % Element-Steifigkeitsmatrix und Lastvektor
      M_e = M_e + (N*N')*Omi;
      K_e = K_e + (D*D')*Omi;
      f_e = f_e + rhs(x(1,1),x(2,1))*N*Omi;
   end
end