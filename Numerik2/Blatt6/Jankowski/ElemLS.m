function [K_e,f_e] = ElemLS(p,Knoten, x)
   
   % Elementlänge
   if(p==1)
   h = x(Knoten(2)) - x(Knoten(1));
   % Speicherplatz reservieren
   K_e = zeros(2,2);
   f_e = zeros(2,1);
   else
   % Speicherplatz reservieren
   K_e = zeros(3,3);
   f_e = zeros(3,1);
   h = x(Knoten(3)) - x(Knoten(1));
   end
   % Gauß-Punkte
   [g,w] = gPunkt;
   

   % Gauss-Quadratur
   for i=1:length(w)
      % Werte der Formfunktion+Ableitung am Gauss-Punkt
      [N,D] = formf(p,g(i)); 
      
      % Ableitung transformieren (d/dx N -> N')
      D = 1/h*D;
      
      % Gewicht + Transformation
      Omi = h*w(i);
      
      % x (global) am Gauss-Punkt
      xg = x(Knoten(1)) + g(i)*h;
      
      % Element-Steifigkeitsmatrix und Lastvektor
      K_e = K_e + (D*D' + 11/(xg-3).^2*N*N')'*Omi;
      f_e = f_e +(-8*N+11*xg.^2/(xg-3).^3*N+44*xg.^2/(xg-3).^2*N)*Omi;
   end
end

