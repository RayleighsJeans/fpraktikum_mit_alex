function [u_sor, res] = sor(A,b,x0,h,tol,maxIt,omega)
     x=x0;
     
     A1=1/omega*diag(diag(A))+tril(A);
     A2=A-A1;
     
     % Residuum
     res = b-A*x;
    
     % Residuennorm
     res_norm = zeros(1,maxIt+1);
     res_norm(1) = norm(res);
     
     %Iterationszahl
     it=0;
     
     tic
     while (res_norm(it+1)>tol) && (it<maxIt)
          it=it+1;
          x = A1\res+x;
          res = b-A*x;
          res_norm(it+1)=norm(res);
     endwhile
     u_sor=x;
     
     fprintf('Anzahl der Iterationen für omega = %e, h = %e: %d\n',omega,h,it);
     fprintf('Residuum: %e\n', res_norm(it+1));
     toc;
end