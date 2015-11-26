function [K_e,f_e] = ElemLS(Knoten, x)
   
   % Elementlänge
   h = x(Knoten(2)) - x(Knoten(1));
   
   % Gauß-Punkte
   [g,w] = gPunkt;
   
   % Speicherplatz reservieren
   K_e = zeros(2,2);
   f_e = zeros(2,1);
   
   % Gauss-Quadratur
   for i=1:length(w)
      % Werte der Formfunktion+Ableitung am Gauss-Punkt
      [N,D] = formf(g(i)); 
      
      % Ableitung transformieren (d/dx N -> N')
      D = 1/h*D;
      
      % Gewicht + Transformation
      Omi = h*w(i);
      
      % x (global) am Gauss-Punkt
      xg = x(Knoten(1)) + g(i)*h;
      
      % Element-Steifigkeitsmatrix und Lastvektor
      K_e = K_e + (-D*D' + 1/xg*D*N')'*Omi;
      f_e = f_e + 1/xg*N*Omi;
   end
end

