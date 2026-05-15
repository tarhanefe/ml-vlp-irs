function error = objective(x,noise_var,measurement_count,irs_list,exp_power,led)
    error(1:measurement_count) = 0;
    for j = 1:measurement_count
        theo_power = calcPower(x,[0,0,1],irs_list(j),led,noise_var,0).power;
        error(j) = 1e8*(exp_power(j)-theo_power);
    end
end
