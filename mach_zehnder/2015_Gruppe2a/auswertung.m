function auswertung()

data = "MZI.txt";
pixel = "MZI2.txt";
Z = importdata(data);
Y = [0	5	15	20	30	35	40	45	50	55	60	65	70	75	80	85	90];
X = importdata(pixel);

for i=1:length(Y)
figure;

TitStr = [num2str(Y(i)) 'Grad']
plot(X,Z(:,i),"linewidth",1);
title(TitStr,"fontsize",16);
xlabel("Pixel","fontsize",16);
ylabel("Intensitaet / a.u.","fontsize",16);
set(gca, "linewidth", 2, "fontsize", 12)
end

%mesh(X,Y,Z')
%plot3(X,Y,Z);
