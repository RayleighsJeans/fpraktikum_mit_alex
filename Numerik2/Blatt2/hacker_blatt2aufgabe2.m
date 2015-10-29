function [daten] = hacker_blatt2aufgabe2(gitterweite);

h = gitterweite;            %Gitterabstand etwas kürzer schreiben.

x=-2:h:2;                   %'Gitter'-Vektoren für x und y erzeugen.
y=-2:h:2;

[A,B] = meshgrid(x,y);      %Das Gitter schließlich durch übereinanderlegen von x&y erstellen.

a = length(x);              %Definiere etwas für die Längen (in Zukunft maximaler Laufindex).
b = length(y);

n=a*b;                      %Diagonal-Länge bestimmen.

z = ones(n,1);              %Vektor-Templates gemacht.
z_oben = z;
z_unten = z;
z_oben(1:a:end) = 0;        %Die Ecken/Kanten einer Matrix beachtet.
z_unten(a:a:end) = 0;

D = (1/h^2)*spdiags([(h/2+1)*z, z_unten, -4*z, z_oben, (h/2+1)*z], [-a, -1, 0, 1, a], n, n);       %Matrix des GLS erstellen.

f = zeros(a,b);             %Initialisierung der Hilfe zur Erstellung der rechten Seite.
r_s = zeros(n,1);           %Rechte Seite initialisiert.

f = 2+6*B-3*B.^2;           %Die Hilfe für die rechte Seite der PDE im Gebiet (2,2)^2 definiert.

f(:,end) = B(:,end).^3-A(:,end)+A(:,end).^2;        %Die Ränder in die Hilfe f(i,j) eingearbeitet.
f(:,1) = B(:,1).^3-A(:,1)+A(:,1).^2;                %
f(1,:) = B(1,:).^3-A(1,:)+A(1,:).^2;                %
f(end,:) = B(end,:).^3-A(end,:)+A(end,:).^2;        %

r_s = reshape(f',n,1);                              %Aus der Hilfe f(i,j) schließlich über reshape(-) die rechte Seite in ihrer korrekten Form (siehe Blatt) erzeugt.

solu = reshape(D\r_s, a, b);                        %Lösung 'solu' ist die Wieder-Entfaltung - und demnach eine Fläche - von dem Gleichungssystem D\r_s.

surf(A,B,solu, 'EdgeColor', 'none');                %Plot der Lösung über den Bereich [X,Y]
  
xlabel('x');                                        %Plot aufhübschen.
ylabel('y');
zlabel('u(x,y)');

set(gcf,'PaperPositionMode','auto')                 %Feste Blickrichtung für den Plot in gfc.
print('hacker_blatt2','-dpng','-r0')                %Bild machen, *.png-Format.

save('hacker_blatt2aufgabe2.mat');                  %Alle Daten in *.mat-Datei auswerfen uns sichern.

clear;
end

