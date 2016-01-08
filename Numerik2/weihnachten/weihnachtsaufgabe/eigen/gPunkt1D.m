function [g,w] = gPunkt1D
    % Zwei-Punkte Gauss-Quadratur im Intervall [-1,1]
    g(1) = -1/sqrt(3);
    g(2) =  1/sqrt(3);
    w(1) = 1;
    w(2) = 1;
    
    % Transformation auf [0,1]
    g = 0.5*(1+g);  
    w = 0.5*w;
end