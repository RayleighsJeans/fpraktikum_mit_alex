function [] = mie_spektren_rechner

clear all;

%Wellenlänge (aus Energie der Photonen über lambda=h*c/E) und Vektor
lambda=(1239.841974)./[1.2:0.2:2.0 2.1 2.2 2.4 2.5 2.6 2.7 2.8 2.9 3.0 3.1]';
lambi=[min(lambda):0.01:max(lambda)]';

%Werte von n und Interpolation dazwischen
n=[0.1 0.08 0.08 0.09 0.13 0.18 0.24 0.5 0.82 1.24 1.43 1.46 1.5 1.54 1.54]';
ni=interp1(lambda,n,lambi,'spline');

%Werte von k und Interpolation dazwischen
k=[6.54 5.44 4.56 3.82 3.16 2.84 2.54 1.86 1.59 1.54 1.72 1.77 1.79 1.8 1.81]';
ki=interp1(lambda,k,lambi,'spline');

%e_m für wässrige Lösung mit Glasplatte, f=0.2
e_m=1.77;
f=0.2;

figure;
hold all;
title('Real- und Imaginärteil der Brechnung');
xlabel('\lambda/nm');
ylabel('\kappa,n');
plot(lambi,ki);
plot(lambi,ni);
legend('\kappa','n');
axis([400 1000 0 6.5]);
hold off;

%Berechnen des Imaginär- und Realteils von eilon
e_re=-(ki.^2-ni.^2);
e_im=sqrt(4*(ni.^2-e_re/2).^2-e_re.^2);

figure;
hold all;
title('Real- und Imaginärteil der dielektrischen Funktion');
xlabel('\lambda/nm');
ylabel('\epsilon_{Re/Im}');
plot(lambi,e_re);
plot(lambi,e_im);
legend('\epsilon_{Re}','\epsilon_{Im}');
axis([400 1000 min(e_re)-0.1*min(e_re) max(e_im)+0.1*max(e_im)]);
hold off;

%Lambda(Maxwell-Garnett) in imag und real aufteilen
L_re=(e_re.^2+e_im.^2-2.*e_m.^2+e_re.*e_m)./((e_re+2*e_m).^2+e_im.^2);
L_im=(3*e_im.*e_m)./((e_re+2*e_m).^2+e_im.^2);

%Real und Imag von effektiver dielektrischen Funktion
e_effre=e_m*(L_re*f+1-2*f^2.*L_re.^2-2*f^2.*L_im.^2)./((1-L_re*f).^2+L_im.^2*f^2);
e_effim=e_m*(3*f.*L_im)./((1-L_re*f).^2+L_im.^2*f^2);

figure;
hold all;
title('Real- und Imaginärteil der effektiven dielektrischen Funktion');
xlabel('\lambda/nm');
ylabel('\epsilon_{eff,Re/Im}');
plot(lambi,e_effre);
plot(lambi,e_effim);
legend('\epsilon_{eff,Re}','\epsilon_{eff,Im}');
axis([400 1000 min(e_effim) max(e_effre)]);
hold off;

kap=sqrt(-e_effre./2+sqrt(e_effre.^2+e_effim.^2)./(2));

figure;
title('exp(-\kappa)');
plot(lambi, exp(-kap));
legend('exp(\kappa)');
xlabel('\kappa');
ylabel('exp(-\kappa)');
axis([400 800 min(exp(-kap))-0.1 max(exp(-kap))+0.1]);

figure;
hold on;
xlabel('\lambda/nm');
ylabel('\kappa');
plot(lambi, kap);
legend('\kappa');
axis([400 800 min(kap)-0.1*min(kap) max(kap)+0.1*max(kap)]);
hold off;

clear all;

end