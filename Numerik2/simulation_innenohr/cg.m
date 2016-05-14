function [x, it] = cg(A,b,x0,tol,maxIt)
    % Startnäherung
    x = x0;
        
    % Residuum = -Startsuchrichtung
    g = A*x-b;
    d = -g;
    tmp2 = g'*g; % spart eine Vektor-Vektor-Multiplikation
        
    % Iterationen
    it = 0;
    
    while (sqrt(tmp2) > tol && it < maxIt)
      tmp = A*d;   % spart eine Matrix-Vektor-Multiplikation
      
      alpha = tmp2/sum(d.*tmp); % schneller als d'*tmp
      x = x + alpha*d;
      g_neu = g + alpha*tmp;
      beta = (g_neu'*g_neu)/tmp2;
      g = g_neu;
      d = -g + beta*d;
      
      tmp2 = beta*tmp2; % spart eine Vektor-Vektor-Multiplikation
       
      it = it+1;
    end
end