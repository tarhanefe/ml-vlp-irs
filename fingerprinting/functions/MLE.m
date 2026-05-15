function [x_est,x0] = MLE(loc,x0,noise_var,measurement_count,irs_list)
    lb = [0, 0, 0]; % Lower bounds
    ub = [4, 4, 3]; % Upper bounds
    led = placeLed(5,[2,2,3],[0,0.8,-0.6]);
    options = optimoptions(@lsqnonlin);
    options.FiniteDifferenceType = 'Central';
    options.StepTolerance = 1e-6;
    options.FunctionTolerance = 1e-6;
    options.Display = 'off';
    %options = optimoptions('lsqnonlin','Algorithm', ...
    %    'trust-region-reflective','FunctionTolerance', ...
    %    1e-6,'StepTolerance',1e-6  , ...
    %    'MaxIterations',500,'MaxFunctionEvaluations',500);
    
    exp_power(1:measurement_count) = 0;
    for j = 1:measurement_count
        exp_power(j) = calcPower(loc,[0,0,1],irs_list(j),led,noise_var,1).power;
    end
    objective_fnc = @(x) objective(x,noise_var,measurement_count,irs_list,exp_power,led);
    x_est = lsqnonlin(objective_fnc, x0,lb,ub,options);
end
