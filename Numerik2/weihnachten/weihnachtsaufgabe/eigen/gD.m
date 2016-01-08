function dirichlet = gD(x,y,tau,k)
    if(x<=1)
        dirichlet = 0;
    else
        if ((k*tau) < 2)
             dirichlet = sin(pi*tau*k)*y*(2-y);
        else
             dirichlet = 0;
        end
    end
end