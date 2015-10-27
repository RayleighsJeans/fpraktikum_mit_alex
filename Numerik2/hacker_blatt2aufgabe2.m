function [daten] = hacker_blatt2aufgabe2(gitterweite);

h = gitterweite;

x=-2:h:2;                   %'Gitter'-Vektoren für x und y erzeugen.
y=-2:h:2;

[A,B] = meshgrid(x,y);      %Das Gitter schließlich durch übereinanderlegen von x&y erstellen.

a = length(x);
b = length(y);

n=a*b;                      %Diagonal-Länge bestimmen.

z = ones(n,1);              %Vektor-Templates gemacht.
z_oben = z;
z_unten = z;
z_oben(1:a:end) = 0;
z_unten(a:a:end) = 0;

D = spdiags([(h/2+1)*z, z_unten, -4*z, z_oben, (h/2+1)*z], [-a, -1, 0, 1, a], n, n);       %Matrix des GLS erstellen.

f = zeros(a,b);             %Initialisierung der rechten Seite/dessen Erstellung.
r_s = zeros(n,1);

f = 2+6*B-3*B.^2;           %Die rechte Seite der PDE im Gebiet (2,2)^2

f(:,end) = B(:,end).^3-A(:,end)+A(:,end).^2;
f(:,1) = B(:,1).^3-A(:,1)+A(:,1).^2;
f(1,:) = B(1,:).^3-A(1,:)+A(1,:).^2;
f(end,:) = B(end,:).^3-A(end,:)+A(end,:).^2;

r_s = reshape(f',n,1);

solu = reshape(D\r_s, a, b);

surf(X,Y,u, 'EdgeColor', 'none');

end;

