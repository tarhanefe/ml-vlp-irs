%% Clean up
clear;
clc;
close all;

% Make sure setup_paths has been run from the repository root.

%% System model
% Room dimensions: 4m x 4m x 3m
pd = placePDs(1,[0.5;0.5;0.85],[0;0;0]);
led = placeLEDs(1);
irs_p1d = 21;
r = 0;
mu = 5;
irs = placeIRS(irs_p1d,1,r,mu);

dim = 3;
sig_dB = 100:5:150;
sig = 10.^(-sig_dB/20);

%% Visualization of the system
% visualizeRoom(led,pd,irs);
% saveas(gcf,'../figures/irs_scen/room.fig');

%% Create different IRS profiles
N = 4;

irs_prof_rand = genIrsProfiles(led,pd,irs,irs_p1d,N,'rand');
irs_prof_aligned = genIrsProfiles(led,pd,irs,irs_p1d,N,'aligned');
irs_prof_focused = genIrsProfiles(led,pd,irs,irs_p1d,N,'focused');
irs_prof_focused_3 = genIrsProfiles(led,pd,irs,irs_p1d,N,'focused_3');

%% Visualize irs_profiles
% for n = 1:N
%    visualizeRoom(led,pd,irs_prof_rand{n});
% end
% for n = 1:N
%    visualizeRoom(led,pd,irs_prof_aligned{n});
% end
% for n = 1:N
%    visualizeRoom(led,pd,irs_prof_focused{n});
% end

%% Calculate CRLB
CRLB_IRS_RAND = calcCRLB(led,pd,irs_prof_rand,sig,dim,'IRS');
CRLB_IRS_SYM = calcCRLB(led,pd,irs_prof_aligned,sig,dim,'IRS');
CRLB_IRS_FOCUSED = calcCRLB(led,pd,irs_prof_focused,sig,dim,'IRS');
CRLB_IRS_FOCUSED_3 = calcCRLB(led,pd,irs_prof_focused_3,sig,dim,'IRS');

%% Plots
figure;
semilogy(sig_dB,CRLB_IRS_RAND,'x--');
hold on; grid on; box on;
semilogy(sig_dB,CRLB_IRS_SYM,'o--');
semilogy(sig_dB,CRLB_IRS_FOCUSED,'v--');
semilogy(sig_dB,CRLB_IRS_FOCUSED_3,'p--');

ylabel('RMSE (m)');
xlabel('$$\rm{10log_{10}(1/{\sigma}^2) (dB)}$$','Interpreter','LaTeX');
legend({'CRLB IRS-RAND','CRLB IRS-ALIGNED','CRLB IRS-FOCUSED','CRLB IRS-FOCUSED_3'});

figname = ['../figures/irs_prof_comp/irs_p1d_' num2str(irs_p1d) '_N_' num2str(N)];

saveas(gcf,[figname '.fig']);
saveas(gcf,[figname '.eps'],'epsc');

