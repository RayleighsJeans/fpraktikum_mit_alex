function [x, res_norm, it] = cg(A,b,x0,tol,maxIt)
    % Startnäherung
    x = x0;
        
    % Residuum = -Startsuchrichtung
    g = A*x-b;
    d = -g;
    
    % Residuennorm
    res_norm = zeros(1,maxIt+1);
    res_norm(1) = norm(g);
    
    % Iterationen
    it = 0;
    
    while (res_norm(it+1) > tol && it < maxIt)
      alpha = (g'*g)/(d'*A*d);
      x = x + alpha*d;
      g_neu = g + alpha*A*d;
      beta = (g_neu'*g_neu)/(g'*g);
      g = g_neu;
      d = -g + beta*d;
       
      it = it+1;
      res_norm(it+1) = norm(g);
    end
end