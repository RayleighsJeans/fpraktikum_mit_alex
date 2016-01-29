function auswertung()

data = "alles.dat";
X = importdata(data);

figure;

TitStr = ['Overview spectrum']
plot(X(:,1),X(:,2),"linewidth",1);
axis([0 1200 0 300]);
text(83,127,'Si 2p',"fontsize",18);
text(134, 130, 'Si 1s',"fontsize",18);
text(516, 252, 'O 1s',"fontsize",18);
text(750, 176, 'O (KVV)',"fontsize",18);
text(976, 155, 'C (KKL)',"fontsize",18);
text(269, 92, 'C 1s',"fontsize",18);
xlabel("Binding Energy / eV","fontsize",22);
ylabel("Intensity / a.u.","fontsize",22);
set(gca, "linewidth", 2, "fontsize", 18)
