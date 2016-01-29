function auswertungO1s()

data1 = "Si2p.dat";
data2 = "Si2ppeak.dat";
X = importdata(data1);
Y = importdata(data2);

figure;
plot(X(:,1),X(:,2),'b',"linewidth",1,Y(:,1),Y(:,4),'k',"linewidth",1,Y(:,1),Y(:,5),'g',"linewidth",0.5,Y(:,1),Y(:,6),'g',"linewidth",0.5,Y(:,1),Y(:,3),'r',"linewidth",1.5);
axis([95 105 0 550]);
xlabel("Binding Energy / eV","fontsize",22);
ylabel("Intensity / a.u.","fontsize",22);
set(gca, "linewidth", 2, "fontsize", 18)
