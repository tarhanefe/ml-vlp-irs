function figureUpdate(figure_name,pso_data,fmincon_data)
    noise_range = 100:5:150;
    Test = open(figure_name);
    figure(Test);
    hold on;
    plot(noise_range,pso_data,'k*-','DisplayName','PSO OPTIMIZED FOCUS')        
    hold on;
    plot(noise_range,fmincon_data,'ks-','DisplayName','FMNCN OPTIMIZED FOCUS')       
end