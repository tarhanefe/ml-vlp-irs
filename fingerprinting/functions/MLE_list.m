function error_list = MLE_list(loc,var_list,irs_list,count,measurement_count,uniform_rand)
    error_list(1:length(var_list)) = 0;
    A = length(var_list)*count;
    cnt = 0;
    for i = 1:length(var_list)
        for j = 1:count
            x0 = loc + -1*uniform_rand + 2*uniform_rand*rand(1,3);
            x_est = MLE(loc,x0,var_list(i),measurement_count,irs_list);
            error_list(i) = error_list(i) + norm(x_est-loc)^2;
            cnt = cnt + 1;
            fprintf('\r %% %.2f of jobs are completed!', cnt/A*100);
        end
    end
    error_list = (error_list/count).^0.5;
end
