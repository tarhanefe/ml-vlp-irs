%% Clean up
clear;
clc;
close all;

%% System model
% Room dimensions: 4m x 4m x 3m
pd = placePDs(1,[0.5;0.5;0.85],[0;0;0]);
led = placeLEDs(1);
led.m = 20;
irs_p1d = 21;
r = 0.5;
mu = 5;
irs = placeIRS(irs_p1d,1,r,mu);
dim = 3;
sig_dB = 150;
sig = 10.^(-sig_dB/20);

%% Create an NxN meshgrid for the 2D surface map

N = 20;
step = 4/N;


[X,Y] = meshgrid(-2:step:2,-2:step:2);


irs_profiles = cell(sum(size(X).*[1 0]),sum(size(X).*[0 1]));
focus_points = cell(sum(size(X).*[1 0]),sum(size(X).*[0 1]));
crlb_vals = zeros(sum(size(X).*[1 0]),sum(size(X).*[0 1]));
tot = sum(size(X).*[0 1])*sum(size(X).*[1 0]);

cntr = 0;
for x_ind = 1:sum(size(X).*[1 0])
    for y_ind = 1:sum(size(X).*[0 1])
        close all
        x = X(x_ind,y_ind);
        y = Y(x_ind,y_ind);
        pd = placePDs(1,[x;y;0.85],[0;0;0]);
        [irs_profiles{x_ind,y_ind},focus_points{x_ind,y_ind}] = optimizeIrsProfiles2(pd,led,irs,16,"random","pso",sig);
        crlb_vals(x_ind,y_ind) = calcCRLB(led,pd,irs_profiles{x_ind,y_ind},sig,dim,'LOS_IRS');
        cntr = cntr + 1;
        save('data/grid_results/irs_profiles.mat', 'irs_profiles');
        save('data/grid_results/focus_points.mat', 'focus_points');
        save('data/grid_results/crlb_vals.mat', 'crlb_vals');
        disp([num2str(cntr) '/' num2str(tot)])

    end
end
