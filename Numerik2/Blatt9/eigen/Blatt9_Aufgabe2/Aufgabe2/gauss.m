function [x, res_norm, it] = gauss(A,b,x0,tol,maxIt)
    % Startnäherung
    x = x0;
    n = length(x0);
    x_neu = x0;
    
    % Residuum
    res = b-A*x;
    
    % Residuennorm
    res_norm = zeros(1,maxIt+1);
    res_norm(1) = norm(res);
    
    % Unteren linken Teil extrahieren
    E = tril(A);
    
    % Iterationen
    it = 0;
    
    while (res_norm(it+1) > tol && it < maxIt)
       
%       for i=1:n
%          x_neu(i) = (res(i) - A(i,1:i-1)*x_neu(1:i-1))/A(i,i);
%       end
%       x = x_neu + x;

      x = E\res + x;
      res = b-A*x;
       
      it = it+1;
      res_norm(it+1) = norm(res);
    end
end