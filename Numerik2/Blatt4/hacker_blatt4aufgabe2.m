function [] = hacker_blatt4aufgabe2;

%%Hintergrund-Gemurmel aus.%%
warning off;

%%Wie immer, Diskretisierung.%%
dx = 0.1;

dt = 0.01;

x = -1:dx:1;
t = 0:dt:3;

nx = length(x);
nt = length(t);

%%Variante 1%%

u = zeros(nt,nx);

%%Keine Randbedingungen, aber hier die 'Randbedingung' aus Aufgabe 1 mit
%%der Angabe aus Aufgabe 2 eingesetzt?!%%

u(1,:) = (sign(x(:)).*(abs(x(:))).^(1/2))';

%%Schleife für Variante 1. Hier wird der Zeitschritt j+1 durch den j
%%ausgedrückt. Else/if Fallunterscheidung.ACHTUNG: Integers der Laufparameter gehen nicht ganzbis zum Ende (schon vorher definiert bzw. wegen j+1 nicht nötig%%

    for j=1:nt-1
        for i=2:nx-1
            
            if(u(j,i)>0)
                
                u(j+1,i) = u(j,i)-dt/dx*((u(j,i))^2-u(j,i-1)*u(j,i));
                
            else
                
                u(j+1,i) = u(j,i)-dt/dx*(u(j,i)*u(j,i+1)-(u(j,i))^2);
                
            end;
            
        end;
        
    end;

clear i j;

%%Mache Animation, damit verfolgt werden kann, wie gut Lösung und Näherung
%%nach welchen Zeitschritt wie gut übereinstimmen
%%(Veranschaulichung).%%

figure;
    for j = 1:nt
        f = sign(x).*(((j*dt)^2+abs(2*x)).^(1/2)-dt*j);
        plot(x, u(j,:), x, f);
        title(sprintf('Variante 1, t = %f', t(j)));
        axis([-1 1 -1.5 1.5]);
        drawnow;
    end;

clear f i j;
    
%%Variante 2%%
%%Nenne z meine Lösung für Variante 2%%

z = zeros(nt,nx);

z(1,:) = (sign(x(:)).*(abs(x(:))).^(1/2))';

%%Schleife für Variante 2. Hier wird der Zeitschritt j+1 durch den j
%%ausgedrückt. Else/elseif/if Fallunterscheidung.%%

    for j=1:nt-1
        for i=2:nx
            
            if(z(j,i)>0)
                
                z(j+1,i) = z(j,i)-dt/(2*dx)*((z(j,i))^2-(z(j,i-1))^2);
                
            elseif(z(j,i)==0)
                
                z(j+1,i) = 0;
                
            else
                
                z(j+1,i) = z(j,i)-dt/(2*dx)*((z(j,i+1))^2-(z(j,i))^2);
                
            end;
            
        end;
        
    end;

clear f i j;

%%Mache Animation, damit verfolgt werden kann, wie gut Lösung und Näherung
%%nach welchen Zeitschritt wie gut übereinstimmen (Veranschaulichung).§§

figure;
    for j = 1:nt
        f = sign(x).*(((j*dt)^2+abs(2*x)).^(1/2)-dt*j);
        plot(x, z(j,:), x, f);
        title(sprintf('Variante 2, t = %f', t(j)));
        axis([-1 1 -1.5 1.5]);
        drawnow;
    end;

%%Meshgrid/surface für beide Approximationen z,u. Speicherung entsprechend.%%
    
[X,T] = meshgrid(x,t);

figure; hold on;
surf(X,T,u, 'EdgeColor', 'none');
        xlabel('x');
        ylabel('t');
        zlabel('u(x,t)');
        savefig('hacker_blatt4var1.fig');
hold off;
 
figure;
hold on;
surf(X,T,z, 'EdgeColor', 'none');
        xlabel('x');
        ylabel('t');
        zlabel('z(x,t)');
        savefig('hacker_blatt4var2.fig');
hold off;

%%Graphischer Vergleich der Lösungen/Approximationen. Interessanter
%%Bereiche etwa dem von axis([...]}.%%

figure;
hold on;
    plot(x,z(201,:),x,u(201,:),x,sign(x).*(((2)^2+abs(2*x)).^(1/2)-2));
    axis([0.09 0.11 0.04 0.08]);
    xlabel('x');
    ylabel('u(x,t=2), z(x,t=2), f(x,t=2)');
    legend('u(x,t=2)','z(x,t=2)','exakte Lösung');
    savefig('hacker_blatt4vergleich.fig');
hold off;

%%Werfe noch alle Daten aus, nur zur Sicherheit.%%

save('hacker_blat4_daten.mat','u','z','t','x','X','T');
    
clear all
    
end