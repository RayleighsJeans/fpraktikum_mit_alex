function [lambda,eig,A,b,a]=keigen_symtridiag(A,k,tol);

lambda = 'undef';
eig = 'undef';
b = 'undef';
a = b;

[n,m]=size(A);
if (n==m)
    if (A'==A)
    
        ndia= diag(A,1);
        dia = diag(A);
        
        a = dia(1)-abs(ndia(1));
        b = dia(1)+abs(ndia(1));
        
        for i=2:n-2   
            
            if (dia(i)-abs(ndia(i-1))-abs(ndia(i))<a)
                
                a = dia(i)-abs(ndia(i-1))-abs(ndia(i));
            end
            if (dia(i)+abs(ndia(i-1))+abs(ndia(i))>b)
                
                b = dia(i)+abs(ndia(i-1))+abs(ndia(i));              
            end
            
        if (dia(n)-abs(ndia(n-1))<a)
            a = dia(n)-abs(ndia(n-1));
        end
        if (dia(n)+abs(ndia(n-1))>b)
            b = dia(n)+abs(ndia(n-1));
        end
            
        end
        
        while (b-a>2*tol)
            
            mu = 1/2*(a+b);
            B = A-eye(n)*mu;
            bdiag = diag(B);
            nu=0;
            
                for i=1:n
                    if (bdiag(i)<0)
                        nu=nu+1;
                    end
                end
            
            if (nu<k)
                a=mu;
            else 
                b=mu;
            end
            
        end
        
        lambda = 1/2*(a+b);
        
        eig = eigs(A);
        eig = sort(eig);
        eig = eig(k);
        
        fprintf(1,'\n Der approximierte Wert ist l* = %f , der wahre Wert ist l = %f .\n', lambda, eig);
        
    else        
        fprintf(1,'\n Matrix A ist nicht symmetrisch.\n');
        return
    end
    
else    
   fprintf(1,'\n Die Matrix A ist nicht quadratisch, dh. es können keine Eigenwerte gefunden werden.\n'); 
   return
end
   
save('keigen_symtridiag.mat');
end

%% PROTOKOLL
% >>A = [2 2 0 0 0;2 3 -1 0 0; 0 -1 5 -2 0; 0 0 -2 7 -1; 0 0 0 -1 11];
% >>[lambda,eig,A,b,a]=keigen_symtridiag(A,5,1e-6);
% 
%  Der approximierte Wert ist l* = 11.000000 , der wahre Wert ist l = 11.275842 .
% >>[lambda,eig,A,b,a]=keigen_symtridiag(A,3,1e-6);
% 
%  Der approximierte Wert ist l* = 5.000000 , der wahre Wert ist l = 4.894036 .
%
%###############################################################################
%%
%% Das Programm funktioniert gut um EW zu approximieren, vorausgesetzt man arbeitet mit symmetrischen, quadratischen Tridiagonalmatrizen.
%% Die Toleranz von 1e-6 reicht lediglich für eine Genauigkeit an den wahren EW in den ersten Stellen vor dem Komma. Unterschiedliche Toleranzen verändern das Ergebnis nicht merklich.


