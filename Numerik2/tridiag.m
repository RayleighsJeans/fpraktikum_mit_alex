function T =tridiag(dimension,oberediag,unterediag,hauptdiag)

unterediag = c;

oberediag = b;

hauptdiag = a;

dimension = n;

A = diag(ones(n-1,1),1);

T=a*eye(n)+b*A+c*A';

clear

end