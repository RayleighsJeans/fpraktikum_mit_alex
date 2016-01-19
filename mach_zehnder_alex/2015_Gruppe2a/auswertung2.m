function auswertung()

data = "pol.txt";
data2 = "2xpol.txt";
data3 = "lambda4.txt";
X = importdata(data3)
%Y = importdata(data2);
%Z = importdata(data3);


figure;
plot(X(:,1),X(:,2),"linewidth",1);
title("lambda/4-Plaetchen","fontsize",24);
xlabel("Winkel / Grad","fontsize",24);
ylabel("Intensitaet / a.u.","fontsize",24);
set(gca, "linewidth", 2, "fontsize", 14)


%mesh(X,Y,Z')
%plot3(X,Y,Z);
