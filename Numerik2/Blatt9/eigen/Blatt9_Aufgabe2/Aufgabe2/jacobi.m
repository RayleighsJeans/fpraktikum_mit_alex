function [x, res_norm, it] = jacobi(A,b,x0,tol,maxIt)
    % Startnäherung
    x = x0;
    
    % Residuum
    res = b-A*x;
    
    % Residuennorm
    res_norm = zeros(1,maxIt+1);
    res_norm(1) = norm(res);
    
    % Diagonale extrahieren
    d = spdiags(A,0); % oder d = diag(A);
    
    % Iterationen
    it = 0;
    
    while (res_norm(it+1) > tol && it < maxIt)
       x = res./d + x;
       res = b-A*x;
       it = it+1;
       res_norm(it+1) = norm(res);
    end
end