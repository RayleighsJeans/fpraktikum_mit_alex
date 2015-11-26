function [N,D] = formf(p,xi)

    %%Fallunterscheidung, wie in Hauptprogramm.

    if (p == 1)
        
        %%Formfunktionen und ihre Ableitungen bei xi, linear.
        
        N = zeros(2,1);
        D = zeros(2,1);
        
        N(1) = 1-xi;
        N(2) = xi;
        
        D(1) = -1;
        D(2) = 1;    
    else
        
        %%Formfunktionen und ihre Ableitungen bei xi, quadratisch.
        
        N = zeros(3,1);
        D = zeros(3,1);
        
        N(1) =  2*xi.^2 - 3*xi + 1;
        N(2) = -4*xi.^2 + 4*xi    ;
        N(3) =  2*xi.^2 -   xi    ;
        
        D(1) =  4*xi - 3;
        D(2) = -8*xi + 4;
        D(3) =  4*xi - 1; 
    end  
end

