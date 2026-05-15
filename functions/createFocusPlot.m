function createFocusPlot(N)
    
    points_pso = load("data/bounded_single_optim/N_" + string(N) + "_pso.mat").points_n;
    
    figure;
    scatter3(points_pso(:,1),points_pso(:,2),points_pso(:,3),'rx')
    hold on
    scatter3(0.5,0.5,0.85,'bo','filled');
    grid on;
    box on;
    legend('Focus Locations','VLC Receiver');
    
    xlim([-2 2]);
    ylim([-2 2]);
    zlim([0 3]);
    xlabel('x (m)');
    ylabel('y (m)');
    zlabel('z (m)');

    end