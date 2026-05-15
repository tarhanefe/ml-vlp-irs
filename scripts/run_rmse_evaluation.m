%% RMSE CALCULATOR 
clearvars
close all;
%% NP = 4
calc_RMSE(4,"random",500);
calc_RMSE(4,"aligned",500);
calc_RMSE(4,"focused",500);

%% NP = 9
calc_RMSE(9,"random",500);
calc_RMSE(9,"aligned",500);
calc_RMSE(9,"focused",500);

%% NP = 16
calc_RMSE(16,"random",500);
calc_RMSE(16,"aligned",500);
calc_RMSE(16,"focused",500);


%% NP = 25
calc_RMSE(25,"random",500);
calc_RMSE(25,"aligned",500);
calc_RMSE(25,"focused",500);

%%
calc_RMSE(4,"focused",500);
calc_RMSE(9,"focused",500);
calc_RMSE(16,"focused",500);
calc_RMSE(25,"focused",500);
