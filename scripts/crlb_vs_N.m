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
r = 0;
mu = 5;
irs = placeIRS(irs_p1d,1,r,mu);

dim = 3;
sig_dB = 150;
sig = 10.^(-sig_dB/20);

%% Visualization of the system
visualizeRoom(led,pd,irs);
saveas(gcf,'../figures/irs_scen/room.fig');
%% Create different IRS profiles
N = 4;
irs_prof = optimizeIrsProfiles(pd,led,irs,N,"circular","pso",1e-8);

%% Create different IRS profiles
N = (2:7).^2;
irs_prof = cell(length(N),1);

for n = 1:length(N)
   irs_prof{n} = genIrsProfiles(led,pd,irs,irs_p1d,N(n),'aligned');
end

%% Calculate CRLB
CRLB_IRS_FOCUSED = zeros(length(N),1);


for n = 1:length(N)
   CRLB_IRS_FOCUSED(n) = calcCRLB(led,pd,irs_prof{n},sig,dim,'IRS');
end

%% Plots
figure;
plot(N,CRLB_IRS_FOCUSED,'x--');
grid on;

ylabel('RMSE (m)');
xlabel('N');
title('IRS-FOCUSED RMSE vs. N');

% figname = ['../figures/irs_prof_comp/irs_p1d_' num2str(irs_p1d) '_N_' num2str(N)];
% 
% saveas(gcf,[figname '.fig']);
% saveas(gcf,[figname '.eps'],'epsc');

