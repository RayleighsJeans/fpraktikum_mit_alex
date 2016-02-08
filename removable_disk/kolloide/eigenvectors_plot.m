function [] = eigenvectors_plot(modenumber, messung, save);
N = modenumber;

load('result_finiyukawa.mat')   

    for i=N
        figure
        clear VX VY VZ    
        VX = result_finiyukawa.sort_V_x(:,i);
        VY = result_finiyukawa.sort_V_y(:,i);
        VZ = result_finiyukawa.sort_V_z(:,i);
        x = result_finiyukawa.x';
        y = result_finiyukawa.y';
        z = result_finiyukawa.z';
% VX,VY,VZ are the projections of each eigenvector onto the x-,y-, and z
% axes
        c = quiver3(x,y,z,VX,VY,VZ); 
        xlabel('x');
        ylabel('y');
        zlabel('z')
 % The title  is the corresponding eigenvalue
        n = num2str(i);
        title(sprintf('Mode Nr. %s', n));
        set(gca,'YTickLabel',[]); set(gca,'ZTickLabel',[]); set(gca,'XTickLabel',[]);  
        set(c,'linewidth',2.0);
        set(gca,'linewidth',2.0);
        if save == 1
            saveas(gcf,sprintf('%sModeNr%s.fig', messung, n))
        end
        clear VX VY VZ
    end
