%% Combined IVP1 & IVP2 Error Evolution Plots
clc; clear; close all;

fontSize = 14; % font size for labels, titles, ticks


%% IVP1: Error evolution
grids_ivp1 = [100, 400, 1600];             % Grid resolutions
schemes = {'LAXF','LAXW','UPWIND'};        % Scheme codes
scheme_names = {'Lax-Friedrichs','Lax-Wendroff','Upwind'};
colors = lines(length(grids_ivp1));        % Colors for grids

error_names = {'L_1','L_2','L_{\infty}'};
num_errors = length(error_names);

for s = 1:length(schemes)
    figure('Name',scheme_names{s},'NumberTitle','off');
    set(gcf,'Units','inches')
    set(gcf,'Position',[1 1 12 4])
    
    for e = 1:num_errors
        subplot(1,num_errors,e)
        hold on; grid on;
        
        for g = 1:length(grids_ivp1)
            P = grids_ivp1(g);
            fname = sprintf('Error_IVP1/error_%s_P%d.dat',schemes{s},P);
            data = readmatrix(fname,'FileType','text','NumHeaderLines',1);
            t    = data(:,1);
            L1   = data(:,2);
            L2   = data(:,3);
            Linf = data(:,4);
            
            % Select error norm
            switch e
                case 1, err = L1;
                case 2, err = L2;
                case 3, err = Linf;
            end
            
            loglog(t,err,'-','Color',colors(g,:),'LineWidth',1.5,'DisplayName',sprintf('P=%d',P))
        end
        
        title(['$', error_names{e}, '$ Error'],'FontSize',fontSize,'Interpreter','latex')
        if e == 1
            ylabel('Error','FontSize',fontSize,'Interpreter','latex')
        end
        if e == 2
            xlabel('Time','FontSize',fontSize,'Interpreter','latex')
        end
        if e == num_errors
            legend('show','Location','best','Interpreter','latex','FontSize',fontSize-2)
        end
        set(gca,'FontSize',fontSize)
    end
    
    sgtitle(['IVP1: ' scheme_names{s} ' Scheme Error Evolution'],...
            'FontSize',fontSize+2,'Interpreter','latex')
    
    set(gcf,'Color','w');
    linkaxes(findall(gcf,'Type','axes'),'xy');
    
    filename = sprintf('%s_ivp1_errorplot.jpg', schemes{s});
    print(gcf, filename, '-djpeg', '-r300')
end


%% IVP2: Error evolution
grids_ivp2 = [100, 400, 2000];            % Grid resolutions for IVP2
colors = lines(length(grids_ivp2));       % Update colors for IVP2

for s = 1:length(schemes)
    figure('Name',scheme_names{s},'NumberTitle','off');
    set(gcf,'Units','inches')
    set(gcf,'Position',[1 1 12 4])
    
    for e = 1:num_errors
        subplot(1,num_errors,e)
        hold on; grid on;
        
        for g = 1:length(grids_ivp2)
            P = grids_ivp2(g);
            fname = sprintf('Error_IVP2/error_%s_P%d.dat',schemes{s},P);
            data = readmatrix(fname,'FileType','text','NumHeaderLines',1);
            t    = data(:,1);
            L1   = data(:,2);
            L2   = data(:,3);
            Linf = data(:,4);
            
            % Select error norm
            switch e
                case 1, err = L1;
                case 2, err = L2;
                case 3, err = Linf;
            end
            
            loglog(t,err,'-','Color',colors(g,:),'LineWidth',1.5,'DisplayName',sprintf('P=%d',P))
        end
        
        title(['$', error_names{e}, '$ Error'],'FontSize',fontSize,'Interpreter','latex')
        if e == 1
            ylabel('Error','FontSize',fontSize,'Interpreter','latex')
        end
        if e == 2
            xlabel('Time','FontSize',fontSize,'Interpreter','latex')
        end
        if e == num_errors
            legend('show','Location','best','Interpreter','latex','FontSize',fontSize-2)
        end
        set(gca,'FontSize',fontSize)
    end
    
    sgtitle(['IVP2: ' scheme_names{s} ' Scheme Error Evolution'],...
            'FontSize',fontSize+2,'Interpreter','latex')
    
    set(gcf,'Color','w');
    linkaxes(findall(gcf,'Type','axes'),'xy');
    

    filename = sprintf('%s_ivp2_errorplot.jpg', schemes{s});
    print(gcf, filename, '-djpeg', '-r300')
end
