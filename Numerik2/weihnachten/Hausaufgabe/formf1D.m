function [N,D] = formf1D(xi)
    % Werte der Formfunktionen und ihrer Ableitungen bei xi
    
    N = zeros(2,1);
    D = zeros(2,1);
    
    N(1) = 1-xi;
    N(2) = xi;
    
    D(1) = -1;
    D(2) = 1;
end

