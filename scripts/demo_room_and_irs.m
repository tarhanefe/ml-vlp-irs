%% Clean up
clear;
clc;
close all;


%% System model
% Room dimensions: 4m x 4m x 3m
pd = placePDs(1,[0.5;0.5;0.85],[0;0;0]);
led = placeLEDs(1);
irs_p1d = 21;
r = 0.5;
mu = 5;
irs = placeIRS(irs_p1d,[1],r,mu);

%% Visualization of the system
visualizeRoom(led,pd,irs);

%% IRS-perpendicular configuration received power
p1d_mesh = 81;
[X,Y] = meshgrid(linspace(-2,2,p1d_mesh),linspace(-2,2,p1d_mesh));
Z = 0.85*ones(p1d_mesh,p1d_mesh);

PR_IRS_PERP = zeros(p1d_mesh,p1d_mesh);

for mi = 1:p1d_mesh
   for mj = 1:p1d_mesh
      curr_lR = [X(mi,mj);Y(mi,mj);Z(mi,mj)];
      PR_IRS_PERP(mi,mj) = calcIRSPower(led,pd,irs,curr_lR);
   end
end

%% IRS-focused configuration received power
PR_IRS_FOCUS = zeros(p1d_mesh,p1d_mesh);

for mi = 1:p1d_mesh
   for mj = 1:p1d_mesh
      curr_lR = [X(mi,mj);Y(mi,mj);Z(mi,mj)];
      pd.lR = curr_lR;
      irs_dir = directIRS2LED(led,pd,irs,1,'fmincon','analytical');
      PR_IRS_FOCUS(mi,mj) = calcIRSPower(led,pd,irs_dir,curr_lR);
   end
end

%% IRS-random configuration received power
irs_rand = irs;
rand_ang = 40;

for w = [1 3]
   for k = 1:length(irs_rand(w).nT)
      % Rotate randomly around x&z axis
      irs_rand(w).nT(:,k) = rot3D(2*rand_ang*rand-rand_ang,0,2*rand_ang*rand-rand_ang)*irs_rand(w).nT_0;  
   end
end

for w = [2 4]
   for k = 1:length(irs_rand(w).nT)
      % Rotate randomly around y&z axis
      irs_rand(w).nT(:,k) = rot3D(0,2*rand_ang*rand-rand_ang,2*rand_ang*rand-rand_ang)*irs_rand(w).nT_0;  
   end
end

PR_IRS_RAND = zeros(p1d_mesh,p1d_mesh);

for mi = 1:p1d_mesh
   for mj = 1:p1d_mesh
      curr_lR = [X(mi,mj);Y(mi,mj);Z(mi,mj)];
      PR_IRS_RAND(mi,mj) = calcIRSPower(led,pd,irs_rand,curr_lR);
   end
end

%% Plots
figure;
surf(X,Y,PR_IRS_PERP); 
colorbar;
colormap turbo;
xlabel('x (m)');
ylabel('y (m)');
title('Received Power for IRS-perpendicular');
saveas(gcf,'../figures/pr_irs_perp.fig');

figure;
surf(X,Y,PR_IRS_FOCUS); 
colorbar;
colormap turbo;
xlabel('x (m)');
ylabel('y (m)');
title('Received Power for IRS-focused');
saveas(gcf,'../figures/pr_irs_focus.fig');

figure;
surf(X,Y,PR_IRS_RAND); 
colorbar;
colormap turbo;
xlabel('x (m)');
ylabel('y (m)');
title('Received Power for IRS-random');
saveas(gcf,'../figures/pr_irs_rand.fig');

%% Save
save('../data/example.mat');