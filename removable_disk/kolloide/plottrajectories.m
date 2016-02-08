function [] = plottrajectories(teilchennummer,frames,colorteilchen,colorframes)
load('/media/ba-hacker/daten/Messwerte/Auswertung/30062015/Messung03/result_tracking_3d_interp.mat')

z = teilchennummer;
nn = frames;
y = colorteilchen;
t = max(y);
mm = colorframes;
dist = length(mm);
inf = min(colorframes);

figure;
hold on;
for l=z;
        plot3(result_tracking3d{l}(nn,1),result_tracking3d{l}(nn,2),result_tracking3d{l}(nn,3));
    end;
xlabel('x in px');
ylabel('y in px');
zlabel('z in px');

figure;
hold on;
C = colormap(jet(dist));
for i=y;
    for j=1:dist;
        plot3(result_tracking3d{i}(j+inf,1),result_tracking3d{i}(j+inf,2),result_tracking3d{i}(j+inf,3),'^','MarkerSize',10,'Color',C(j,:));
    end;
    r = num2str(i);
    plot3(result_tracking3d{i}(mm,1),result_tracking3d{i}(mm,2),result_tracking3d{i}(mm,3),'-.','Color',C(i,:),'Displayname',sprintf('Teilchen Nr. %s',r))
end;
grid on; box on;
xlabel('x in px');
ylabel('y in px');
zlabel('z in px');
%legend('-DynamicLegend','Location','Best')
%r = num2str(i);
%legend(sprintf('Trajektorie des Teilchens %s', r);
%keyboard

end