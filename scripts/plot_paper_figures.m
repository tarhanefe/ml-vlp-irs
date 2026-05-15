clearvars;
close all;
%%

aligned_4 = load("data/data_rmse_crlb_all/N_4_orientation_aligned.mat");
focused_4 = load("data/data_rmse_crlb_all/N_4_orientation_focused.mat");
random_4 = load("data/data_rmse_crlb_all/N_4_orientation_random.mat");
%%

aligned_9 = load("data/data_rmse_crlb_all/N_9_orientation_aligned.mat");
focused_9 = load("data/data_rmse_crlb_all/N_9_orientation_focused.mat");
random_9 = load("data/data_rmse_crlb_all/N_9_orientation_random.mat");
%%

aligned_16 = load("data/data_rmse_crlb_all/N_16_orientation_aligned.mat");
focused_16 = load("data/data_rmse_crlb_all/N_16_orientation_focused.mat");
random_16 = load("data/data_rmse_crlb_all/N_16_orientation_random.mat");
%%

aligned_25 = load("data/data_rmse_crlb_all/N_25_orientation_aligned.mat");
focused_25 = load("data/data_rmse_crlb_all/N_25_orientation_focused.mat");
random_25 = load("data/data_rmse_crlb_all/N_25_orientation_random.mat");


%%
range = (1:11);

figure();
semilogy(aligned_4.sig_dB(range),aligned_4.RMSE(range),'v--',"Color","red");
hold on;
semilogy(aligned_4.sig_dB(range),aligned_4.CRLB(range),'v-',"Color","red");
hold on;

semilogy(focused_4.sig_dB(range),focused_4.RMSE(range),'s--',"Color","blue");
hold on;
semilogy(focused_4.sig_dB(range),focused_4.CRLB(range),'s-',"Color","blue");
hold on;

semilogy(random_4.sig_dB(range),random_4.RMSE(range),'o--',"Color","black");
hold on;
semilogy(random_4.sig_dB(range),random_4.CRLB(range),'o-',"Color","black");
grid on;
ylabel('RMSE (m)');
xlabel('$$\rm{10log_{10}(1/{\sigma}^2)}$$','Interpreter','LaTeX');
legend("MLE - Aligned Orientation", ...
       "CRLB - Aligned Orientation", ...
       "MLE - Focused Orientation", ...
       "CRLB - Focused Orientation", ...
       "MLE - Random Orientation", ...
       "CRLB - Random Orientation");
ylim([1e-3 1e2]);
%saveas(gcf,'figures/png/N_4_SLED.png');
%%

figure();
semilogy(aligned_9.sig_dB(range),aligned_9.RMSE(range),'v--',"Color","red");
hold on;
semilogy(aligned_9.sig_dB(range),aligned_9.CRLB(range),'v-',"Color","red");
hold on;
semilogy(focused_9.sig_dB(range),focused_9.RMSE(range),'s--',"Color","blue");
hold on;
semilogy(focused_9.sig_dB(range),focused_9.CRLB(range),'s-',"Color","blue");
hold on;
semilogy(random_9.sig_dB(range),random_9.RMSE(range),'o--',"Color","black");
hold on;
semilogy(random_9.sig_dB(range),random_9.CRLB(range),'o-',"Color","black");
grid on;
ylabel('RMSE (m)');
xlabel('$$\rm{10log_{10}(1/{\sigma}^2)}$$','Interpreter','LaTeX');
legend("MLE - Aligned Orientation", ...
       "CRLB - Aligned Orientation", ...
       "MLE - Focused Orientation", ...
       "CRLB - Focused Orientation", ...
       "MLE - Random Orientation", ...
       "CRLB - Random Orientation");
ylim([1e-3 1e2]);

%saveas(gcf,'figures/png/N_9_SLED.png');


%%

figure();
semilogy(aligned_16.sig_dB(range),aligned_16.RMSE(range),'v--',"Color","red");
hold on;
semilogy(aligned_16.sig_dB(range),aligned_16.CRLB(range),'v-',"Color","red");
hold on;
semilogy(focused_16.sig_dB(range),focused_16.RMSE(range),'s--',"Color","blue");
hold on;
semilogy(focused_16.sig_dB(range),focused_16.CRLB(range),'s-',"Color","blue");
hold on;
semilogy(random_16.sig_dB(range),random_16.RMSE(range),'o--',"Color","black");
hold on;
semilogy(random_16.sig_dB(range),random_16.CRLB(range),'o-',"Color","black");
grid on;
ylabel('RMSE (m)');
xlabel('$$\rm{10log_{10}(1/{\sigma}^2)}$$','Interpreter','LaTeX');
legend("MLE - Aligned Orientation", ...
       "CRLB - Aligned Orientation", ...
       "MLE - Focused Orientation", ...
       "CRLB - Focused Orientation", ...
       "MLE - Random Orientation", ...
       "CRLB - Random Orientation");
ylim([1e-3 1e2]);

%saveas(gcf,'figures/png/N_16_SLED.png');

%%

figure();
semilogy(aligned_25.sig_dB(range),aligned_25.RMSE(range),'v--',"Color","red");
hold on;
semilogy(aligned_25.sig_dB(range),aligned_25.CRLB(range),'v-',"Color","red");
hold on;

semilogy(focused_25.sig_dB(range),focused_25.RMSE(range),'s--',"Color","blue");
hold on;
semilogy(focused_25.sig_dB(range),focused_25.CRLB(range),'s-',"Color","blue");
hold on;

semilogy(random_25.sig_dB(range),random_25.RMSE(range),'o--',"Color","black");
hold on;
semilogy(random_25.sig_dB(range),random_25.CRLB(range),'o-',"Color","black");

grid on;
ylabel('RMSE (m)');
xlabel('$$\rm{10log_{10}(1/{\sigma}^2)}$$','Interpreter','LaTeX');
legend("MLE - Aligned Orientation", ...
       "CRLB - Aligned Orientation", ...
       "MLE - Focused Orientation", ...
       "CRLB - Focused Orientation", ...
       "MLE - Random Orientation", ...
       "CRLB - Random Orientation");
ylim([1e-3 1e2]);

%saveas(gcf,'figures/png/N_25_SLED.png');
%%

%createFocusPlot(4);
%saveas(gcf,'figures/png/N_4_Focus.png');

createFocusPlot(9);
saveas(gcf,'figures/png/N_9_Focus.png');

createFocusPlot(16);
%saveas(gcf,'figures/png/N_16_Focus.png');

createFocusPlot(25);
saveas(gcf,'figures/png/N_25_Focus.png');




%%
createFocusPlot(4)
%%
createFocusPlot(9);
createFocusPlot(16);
createFocusPlot(25);
%%
clear;
clc;
close all;


%% System model
N = 25;
sig_dB = 100:5:170;
sig = 10.^(-sig_dB/20);

pd = placePDs(1,[0.5;0.5;0.85],[0;0;0]);
led = placeLEDs(1);
led.m = 1;
irs_p1d = 21;
r = 0;
mu = 5;
irs = placeIRS(irs_p1d,1,r,mu);
dim = 3;
irs_profiles = genIrsProfiles(led,pd,irs,irs_p1d,N,'focused');
CRLB_1 = calcCRLB(led,pd,irs_profiles,sig,dim,'IRS');


pd = placePDs(1,[0.5;0.5;0.85],[0;0;0]);
led = placeLEDs(1);
led.m = 5;
irs_p1d = 21;
r = 0;
mu = 5;
irs = placeIRS(irs_p1d,1,r,mu);
dim = 3;
irs_profiles = genIrsProfiles(led,pd,irs,irs_p1d,N,'focused');
CRLB_5 = calcCRLB(led,pd,irs_profiles,sig,dim,'IRS');

pd = placePDs(1,[0.5;0.5;0.85],[0;0;0]);
led = placeLEDs(1);
led.m = 10;
irs_p1d = 21;
r = 0;
mu = 5;
irs = placeIRS(irs_p1d,1,r,mu);
dim = 3;
irs_profiles = genIrsProfiles(led,pd,irs,irs_p1d,N,'focused');
CRLB_10 = calcCRLB(led,pd,irs_profiles,sig,dim,'IRS');

pd = placePDs(1,[0.5;0.5;0.85],[0;0;0]);
led = placeLEDs(1);
led.m = 20;
irs_p1d = 21;
r = 0;
mu = 5;
irs = placeIRS(irs_p1d,1,r,mu);
dim = 3;
irs_profiles = genIrsProfiles(led,pd,irs,irs_p1d,N,'focused');
CRLB_20 = calcCRLB(led,pd,irs_profiles,sig,dim,'IRS');

pd = placePDs(1,[0.5;0.5;0.85],[0;0;0]);
led = placeLEDs(1);
led.m = 100;
irs_p1d = 21;
r = 0;
mu = 5;
irs = placeIRS(irs_p1d,1,r,mu);
dim = 3;
irs_profiles = genIrsProfiles(led,pd,irs,irs_p1d,N,'focused');
CRLB_100 = calcCRLB(led,pd,irs_profiles,sig,dim,'IRS');

pd = placePDs(1,[0.5;0.5;0.85],[0;0;0]);
led = placeLEDs(1);
led.m = 200;
irs_p1d = 21;
r = 0;
mu = 5;
irs = placeIRS(irs_p1d,1,r,mu);
dim = 3;
irs_profiles = genIrsProfiles(led,pd,irs,irs_p1d,N,'focused');
CRLB_1000 = calcCRLB(led,pd,irs_profiles,sig,dim,'IRS');

figure;
semilogy(sig_dB,CRLB_1,'x-');
hold on;
semilogy(sig_dB,CRLB_5,'s-');
hold on;
semilogy(sig_dB,CRLB_10,'^-');
hold on;
semilogy(sig_dB,CRLB_20,'v-');
hold on;
semilogy(sig_dB,CRLB_100,'o-');
hold on;
semilogy(sig_dB,CRLB_1000,'<-');
grid on;

ylabel('RMSE (m)');
xlabel('$$\rm{10log_{10}(1/{\sigma}^2) (dB)}$$','Interpreter','LaTeX');
legend({'m = 1', ...
        'm = 5', ...
        'm = 10', ...
        'm = 20', ...
        'm = 100', ...
        'm = 1000'});

%% System model
N = 16;
sig_dB = 100:5:170;
sig = 10.^(-sig_dB/20);
m = 40;

pd = placePDs(1,[0.5;0.5;0.85],[0;0;0]);
led = placeLEDs(1);
led.m = m;
irs_p1d = 21;
r = 0.5;
mu = 5;
irs = placeIRS(irs_p1d,1,r,mu);
dim = 3;
irs_profiles = genIrsProfiles(led,pd,irs,irs_p1d,N,'rand');
CRLB_1 = calcCRLB(led,pd,irs_profiles,sig,dim,'IRS');


pd = placePDs(1,[0.5;0.5;0.85],[0;0;0]);
led = placeLEDs(1);
led.m = m;
irs_p1d = 21;
r = 0;
mu = 5;
irs = placeIRS(irs_p1d,1,r,mu);
dim = 3;
irs_profiles = genIrsProfiles(led,pd,irs,irs_p1d,N,'aligned');
CRLB_5 = calcCRLB(led,pd,irs_profiles,sig,dim,'IRS');

pd = placePDs(1,[0.5;0.5;0.85],[0;0;0]);
led = placeLEDs(1);
led.m = m;
irs_p1d = 21;
r = 0;
mu = 5;
irs = placeIRS(irs_p1d,1,r,mu);
dim = 3;
irs_profiles = genIrsProfiles(led,pd,irs,irs_p1d,N,'rand');
CRLB_10 = calcCRLB(led,pd,irs_profiles,sig,dim,'LOS_IRS');

pd = placePDs(1,[0.5;0.5;0.85],[0;0;0]);
led = placeLEDs(1);
led.m = m;
irs_p1d = 21;
r = 0.5;
mu = 5;
irs = placeIRS(irs_p1d,1,r,mu);
dim = 3;
irs_profiles = genIrsProfiles(led,pd,irs,irs_p1d,N,'aligned');
CRLB_20 = calcCRLB(led,pd,irs_profiles,sig,dim,'LOS_IRS');

figure;
semilogy(sig_dB,CRLB_1,'x-');
hold on;
semilogy(sig_dB,CRLB_5,'s-');
hold on;
semilogy(sig_dB,CRLB_10,'^-');
hold on;
semilogy(sig_dB,CRLB_20,'v-');
grid on;

ylabel('RMSE (m)');
xlabel('$$\rm{10log_{10}(1/{\sigma}^2) (dB)}$$','Interpreter','LaTeX');
legend({'Random IRS', ...
        'Aligned IRS', ...
        'Random LOS + IRS', ...
        'Aligned LOS + IRS'});

