function createPlots(figure_name,N)
    
    if N == 4
        points_fmincon = load("data/bounded_ensemble_optim/N_4_ensemble.mat").points_n;
        points_pso = load("data/bounded_single_optim/N_4_pso.mat").points_n;
        crlblist_pso = load("data/bounded_ensemble_optim/N_4_ensemble.mat").CRLBList;
        crlblist_fmincon = load("data/bounded_single_optim/N_4_pso.mat").CRLBList;
    elseif N == 9
        points_fmincon = load("data/bounded_ensemble_optim/N_9_ensemble.mat").points_n;
        points_pso = load("data/bounded_single_optim/N_9_pso.mat").points_n;
        crlblist_pso = load("data/bounded_ensemble_optim/N_9_ensemble.mat").CRLBList;
        crlblist_fmincon = load("data/bounded_single_optim/N_9_pso.mat").CRLBList;
    end
    
    points = [];
    x_vals = linspace(-1.5,1.5,ceil(sqrt(N)));
    y_vals = linspace(-1.5,1.5,ceil(sqrt(N)));
    for i = x_vals
        for j = y_vals
            points = vertcat(points,[i j]);
        end
    end

    figure;
    subplot(1,2,1)
    scatter(points(:,1),points(:,2),'rs','filled');
    hold on;
    grid on;
    box on;
    scatter(0.5,0.5,'bo','filled');
    xlim([-2 2]);
    ylim([-2 2]);
    title(['INITAL IRS-FOCUSED POINTS (N_P = ' num2str(N) ')']);
    xlabel('x');
    ylabel('y');
    legend('Initial Focus Points','PD Location');


    subplot(1,2,2)

    scatter(points_fmincon(:,1),points_fmincon(:,2),'^m','filled')
    hold on
    scatter(points_pso(:,1),points_pso(:,2),'vk','filled');
    hold on
    scatter(0.5,0.5,'bo','filled');
    grid on;
    box on;
    legend('PSO Points','PSO + Fmincon Points','PD Location');
    
    xlim([-2 2]);
    ylim([-2 2]);
    title(['FINAL IRS-FOCUSED POINTS (N_P = ' num2str(N) ')']);
    xlabel('x');
    ylabel('y');

    noise_range = 100:5:150;
    Test = open(figure_name);
    figure(Test);
    title(['CRLB Curves w/ (N_P = ' num2str(N) ')']);
    hold on;
    plot(noise_range,crlblist_pso,'k*-','DisplayName','PSO OPTIMIZED FOCUS');       
    hold on;
    plot(noise_range,crlblist_fmincon,'ks-','DisplayName','PSO + FMINCON OPTIMIZED FOCUS');       
end