%% IVP1: Solution evolution subplots for each grid resolution
clc; clear; close all;


% Times, grid resolutions, and schemes

times = [1, 100];                       % times
grids = [100, 400, 1600];               % grid resolutions
schemes = {'Upwind','LaxF','LaxW'};     % scheme codes
scheme_names = {'Upwind','Lax-Friedrichs','Lax-Wendroff'};
colors = lines(length(schemes));        % colors for schemes
fontSize = 14;                         

for t_idx = 1:length(times)
    t_val = times(t_idx);
    
    figure('Name',sprintf('IVP1 Solutions at t=%d',t_val),'NumberTitle','off');
    set(gcf,'Units','inches')
    set(gcf,'Position',[1 1 12 4])
    
    for g_idx = 1:length(grids)
        P = grids(g_idx);
        subplot(1,length(grids),g_idx)
        hold on; grid on;
        
        % Plot all schemes
        for s = 1:length(schemes)
            fname = sprintf('T%d_P%d/IVP1_%s_results.dat', t_val, P, schemes{s});
            
            % Read numeric data
            data = readmatrix(fname,'FileType','text','NumHeaderLines',1);
            X = data(:,2);
            Fexact = data(:,3);
            FI = data(:,4);
            
            plot(X, FI, '--','Color',colors(s,:),'LineWidth',1.5,'DisplayName',scheme_names{s})
        end
        
        % Plot exact solution
        plot(X, Fexact, 'r-', 'LineWidth',1.5,'DisplayName','Exact')
        
        % Labels and title
        if g_idx == 1
            ylabel('Solution','FontSize',fontSize,'Interpreter','latex')
        end
        xlabel('X','FontSize',fontSize,'Interpreter','latex')
        title(sprintf('Grid P=%d',P),'FontSize',fontSize)
        set(gca,'FontSize',fontSize)
        
       
        if g_idx == 1
            legend('show','Location','southwest','Interpreter','latex','FontSize',fontSize-6)
        end
    end
    
    sgtitle(sprintf('IVP1 Solution Evolution at $t=%d$', t_val),'FontSize',fontSize+2,'Interpreter','latex')
    
    % Save figure as JPEG at 300 dpi
    filename = sprintf('IVP1_t%d_subplots.jpg', t_val);
    print(gcf, filename, '-djpeg','-r300')
end


%% help function
function data = read_data(filename)
    fid = fopen(filename,'r');
    if fid == -1
        error('Could not open file %s', filename);
    end
    fgetl(fid); % skip header
    data = fscanf(fid,'%d %f %f %f %f',[5,Inf])';
    fclose(fid);
end
