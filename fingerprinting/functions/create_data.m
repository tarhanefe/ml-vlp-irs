function create_data(measurement_count, experiment_count, height, grid_resolution, irs_orientation,noise_var,data_type)   
    if data_type == "train"
        rng(42,'twister');
        led = placeLed(5,[2,2,3],[0,0.8,-0.6]);
        room = createRoom(4,4,3);
        nb = [0 0 1];
        pieces = roomDivider(room,[sqrt(measurement_count),sqrt(measurement_count)],height);
        grid_length = length(0:grid_resolution:4);
        for i = 1:measurement_count
            irs_list(i) = placeIRS([4,4,3],[21,21],[0.02,0.04],[0.01,0.02],4,irs_orientation,pieces(i)); %#ok<AGROW> 
        end
        x_y = [];
        power = [];
        cnt = 0;
        total_count = grid_length*grid_length*measurement_count;
        for x = 0:grid_resolution:4
            for y = 0:grid_resolution:4
                loc = [x,y,0.85];
                x_y = vertcat(x_y,[loc(1),loc(2)]);
                dum_power = [];
                for irs = irs_list
               
                    pwr = calcPower(loc,nb,irs,led,noise_var,0);
                    powers = mean(ones(experiment_count,1)*pwr.power + sqrt(noise_var)*randn(experiment_count,1));
                    dum_power = vertcat(dum_power,powers);
                    cnt = cnt +1;
                    fprintf('\r %% %.2f of jobs are completed!', cnt/total_count*100);
                end
                power = horzcat(power,dum_power);
            end
        end
        filename = sprintf('train-%d-measurement-%d-trial-experiment-%s-orientation-%d-dB-noise-var.csv', measurement_count, experiment_count,irs_orientation,log10(noise_var));
        data = horzcat(power',x_y);
        csvwrite(filename, data)

    else 
        rng(45,'twister');
        led = placeLed(5,[2,2,3],[0,0.8,-0.6]);
        room = createRoom(4,4,3);
        nb = [0 0 1];
        pieces = roomDivider(room,[sqrt(measurement_count),sqrt(measurement_count)],height);
        grid_length = length(0:grid_resolution:4);
        for i = 1:measurement_count
            irs_list(i) = placeIRS([4,4,3],[21,21],[0.02,0.04],[0.01,0.02],4,irs_orientation,pieces(i)); %#ok<AGROW> 
        end
        x_y = [];
        power = [];
        cnt = 0;
        total_count = experiment_count;
        for q = 1:experiment_count
            x = 4*rand(1);
            y = 4*rand(1);
            loc = [x,y,0.85];
            x_y = vertcat(x_y,[loc(1),loc(2)]);
            dum_power = [];
            for irs = irs_list
                pwr = calcPower(loc,nb,irs,led,noise_var,0);
                powers = mean(ones(experiment_count,1)*pwr.power + sqrt(noise_var)*randn(experiment_count,1));
                dum_power = vertcat(dum_power,powers);
                cnt = cnt +1;
                fprintf('\r %% %.2f of jobs are completed!', cnt/total_count*100);
            end
            power = horzcat(power,dum_power);
        end
        filename = sprintf('test-%d-measurement-%d-trial-experiment-%s-orientation-%d-dB-noise-var.csv', measurement_count, experiment_count,irs_orientation,log10(noise_var));
        data = horzcat(power',x_y);
        csvwrite(filename, data)


    end

end