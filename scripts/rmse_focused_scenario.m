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
nOfSamples = 100;
sig_dB = 100:5:150;
sig = 10.^(-sig_dB/20);

%% Visualization of the system
% visualizeRoom(led,pd,irs);
% saveas(gcf,'../figures/irs_scen/room.fig');

%% Create different IRS profiles
N = 16;

irs_prof_focused = genIrsProfiles(led,pd,irs,irs_p1d,N,'focused');

%% Visualize irs_profiles
% for n = 1:N
%    visualizeRoom(led,pd,irs_profiles{n});
% end

%% Calculate CRLB
CRLB_IRS = calcCRLB(led,pd,irs_prof_focused,sig,dim,'IRS');
disp(CRLB_IRS');

%% ML Estimator
PR_IRS = zeros(N,1);

for i = 1:N
   PR_IRS(i) = calcIRSPower(led,pd,irs_prof_focused{i},pd.lR);
end

lR_hat_irs = zeros(3,length(sig),nOfSamples);

for i = 1:length(sig)
   disp([num2str(i) '/' num2str(length(sig)) '...']);
   tic;
   disp("%");
   fprintf("\b")
   number = 0;
   fprintf(num2str(number));
   for j = 1:nOfSamples
      PR = PR_IRS + sig(i)*randn(N,1);
      lR_hat_irs(:,i,j) = lR_lsq(led,pd,irs_prof_focused,PR,dim,'IRS');
      numLength = length(num2str(number));
      fprintf(repmat('\b', 1, numLength));
      number = j/nOfSamples*100;
      fprintf(num2str(number));
   end
   toc;
end

lR_rep = repmat(pd.lR,1,length(sig),nOfSamples);

lR_irs_err = reshape(vecnorm(lR_rep-lR_hat_irs),length(sig),nOfSamples);
lR_irs_rmse = sqrt(sum(lR_irs_err.^2,2)/nOfSamples);

%% Plots
figure;
semilogy(sig_dB,CRLB_IRS,'x--');
hold on;
semilogy(sig_dB,lR_irs_rmse,'o-');
grid on;

ylabel('RMSE (m)');
xlabel('$$\rm{10log_{10}(1/{\sigma}^2) (dB)}$$','Interpreter','LaTeX');
legend({'CRLB IRS-FOCUSED','MLE IRS-FOCUSED'});

% figname = ['../figures/irs_scen_focused/irs_p1d_' num2str(irs_p1d) '_mse_' num2str(nOfSamples)];
% 
% saveas(gcf,[figname '.fig']);
% saveas(gcf,[figname '.eps'],'epsc');
% save(['../data/irs_scen_focused/irs_p1d_' num2str(irs_p1d) '_mse_' num2str(nOfSamples) '.mat']);
% 
