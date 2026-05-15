function rmse_list = KNNRegression(nearest_neighbours,orientation,height,measurement_count,grid_resolution,train_noise,test_count)
    rmse_list = [];
    % Creation of the training data 
    rng(42,'twister');
    led = placeLed(5,[2,2,3],[0,0.8,-0.6]);
    room = createRoom(4,4,3);
    nb = [0 0 1];
    pieces = roomDivider(room,[sqrt(measurement_count),sqrt(measurement_count)],height);
    grid_length = length(0:grid_resolution:4);
    for i = 1:measurement_count
        irs_list(i) = placeIRS([4,4,3],[21,21],[0.02,0.04],[0.01,0.02],4,orientation,pieces(i)); %#ok<AGROW> 
    end
    % IRS and other elements of the room are initialized
    x_y = [];
    power = [];
    cnt = 0;
    total_count = grid_length*grid_length*measurement_count;
    for x = 0:grid_resolution:4
        for y = 0:grid_resolution:4
            loc = [x,y,0.85];
            x_y = vertcat(x_y,[x,y]);
            dum_power = [];
            for irs = irs_list
                pwr = calcPower(loc,nb,irs,led,train_noise,0);
                powers = mean(ones(1000,1)*pwr.power + sqrt(train_noise)*randn(1000,1));
                dum_power = vertcat(dum_power,powers);
                cnt = cnt +1;
                fprintf('\r %% %.2f of training data  are completed!', cnt/total_count*100);
            end
            power = horzcat(power,dum_power);
        end
    end
    train_data = horzcat(power',x_y);
    
   

    % Training data has been created 

    noise_variances = 10.^(-10:-1:-20);
    cnt = 0;
    total_cnt = length(noise_variances);
    for noise_var = noise_variances
        % Test Data will be created next 
        rng(45,'twister');
        nb = [0 0 1];
        x_y = [];
        power = [];
        for q = 1:test_count
            a = 4*rand(1,2);
            x = a(1);
            y = a(2);
            loc = [x,y,0.85];
            x_y = vertcat(x_y,[loc(1),loc(2)]);
            dum_power = [];
            for irs = irs_list
                pwr = calcPower(loc,nb,irs,led,noise_var,0);
                powers = pwr.power + sqrt(noise_var)*randn(1);
                dum_power = vertcat(dum_power,powers);
            end
            power = horzcat(power,dum_power);
        end
        test_data = horzcat(power',x_y);    

        testX = test_data(:, 1:end-2);   % Features from testing data
        testY = test_data(:, end-1:end);       % Target from testing data
        trainX = train_data(:, 1:end-2); % Features from training data
        trainY = train_data(:, end-1:end);     % Target from training data
        k = nearest_neighbours; % Number of neighbors
        predictedY = fitrKNN(trainX, trainY, testX, k);
        % Calculate evaluation metrics, e.g., Mean Squared Error (MSE)
        mse = sum(mean((predictedY - testY).^2));
        rmse = sqrt(mse);
        rmse_list = horzcat(rmse_list,rmse);
        cnt = cnt + 1;
        fprintf('\r %% %.2f of tests are completed!', cnt/total_cnt*100);
    end
