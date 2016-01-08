function [N,D] = formf2D(xi,eta)
    % Werte der Formfunktionen und ihrer Ableitungen bei xi
    
    N = zeros(3,1);
    D = zeros(3,2);
    
    N(1) = 1-xi-eta;
    N(2) = xi;
    N(3) = eta;
    
    D(1,:) = [-1 -1];
    D(2,:) = [ 1  0];
    D(3,:) = [ 0  1];
end