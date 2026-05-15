function [irs_profiles,points_n] = optimizeIrsProfiles2(pd,led,irs,N,init_state,type,noise)

% optimizeIrsProfiles This function creates N different IRS profiles by
% minimizing CRLB for the given points

irs_profiles = cell(1,N);
r0 = 0.5;
g1d = ceil(sqrt(N));

%% Select Initial State of the IRS elements
if strcmp(init_state,"circular")
    points = selectCircularPoints(N,pd.lR',r0);
    for n = 1:N
        irs_profiles{n} = directIRS2POS(points(N,:)',led,irs,1);
    end

elseif strcmp(init_state,"square")
    points = [];
    dist = 0.3;
    x_vals = linspace((-(g1d-1)*0.5)*dist+pd.lR(1),(g1d-1)*0.5*dist+pd.lR(2),g1d);
    y_vals = linspace((-(g1d-1)*0.5)*dist+pd.lR(1),(g1d-1)*0.5*dist+pd.lR(2),g1d);
    for i = x_vals
        for j = y_vals
            points = vertcat(points,[i j]);
        end
    end
    for n = 1:N
        irs_profiles{n} = directIRS2POS(points(n,:)',led,irs,1);
    end
elseif strcmp(init_state,"random")
    irs_profiles = genIrsProfiles(led,pd,irs,21,N,'rand');

elseif strcmp(init_state,"uniform")
    points = [];
    x_vals = linspace(-1.5,1.5,ceil(sqrt(N)));
    y_vals = linspace(-1.5,1.5,ceil(sqrt(N)));
    for i = x_vals
        for j = y_vals
            points = vertcat(points,[i j]);
        end
    end
    for n = 1:N
        irs_profiles{n} = directIRS2POS(points(n,:)',led,irs,1);
    end
elseif strcmp(init_state,"custom")
    points = load("data/bounded_single_optim/N_9_pso.mat").points_n;
    for n = 1:N
        irs_profiles{n} = directIRS2POS(points(n,:)',led,irs,1);
    end
end


% %% Plotting the initial focus points.
% figure;
% subplot(1,2,1);
% for i = 1:N
%   plot(points(i,1),points(i,2),'rx');
%   hold on; grid on; box on;
% end
% plot(0.5,0.5,'bo');
% xlim([-2 2]);
% ylim([-2 2]);
% title(['INITAL IRS-FOCUSED POINTS (N_P = ' num2str(N) ')']);
% xlabel('x');
% ylabel('y');
%% Optimize the IRS focus points 
lb = repmat([-2 ; -2 ; 0],[N,1]);
ub = repmat([2 ; 2 ; 3],[N,1]);
%lb = -Inf(N*2,1);
%ub = Inf(N*2,1);

costFunc = @(x) costCRLB2(x,led,pd,irs_profiles,noise);
if strcmp(type, "pso")
    options = optimoptions('particleswarm', ...
    'SwarmSize', 50, ...              % Number of particles in the swarm
    'MaxIterations', 500, ...         % Maximum number of iterations
    'Display', 'off');
    [new_points,~,~] = particleswarm(costFunc,N*3,lb,ub,options);
    irs_profiles = directIRS2POSall(new_points,led,irs_profiles);
elseif strcmp(type,"fmincon")
    lR_opt = optimoptions(@fmincon);
    lR_opt.Display = 'iter';
    n_pts = reshape(points',[numel(points),1]);
    [new_points,~] = fmincon(costFunc,n_pts,[],[],[],[],lb,ub,[],lR_opt);
    irs_profiles = directIRS2POSall(new_points,led,irs_profiles,height);
elseif strcmp(type,"multistart")
    n_pts = reshape(points',[numel(points),1]);
    rng default % For reproducibility
    opts = optimoptions(@fmincon,'Algorithm','sqp','Display','iter');
    problem = createOptimProblem('fmincon','objective',...
    costFunc,'x0',n_pts,'lb',lb,'ub',ub,'options',opts);
    ms = MultiStart;
    [new_points,~] = run(ms,problem,15);
end

   
%% Plotting the final focus points.
points_n = reshape(new_points',[3,N])';
figure;
for i = 1:N
  scatter3(points_n(i,1),points_n(i,2),points_n(i,3),'rx');  
  hold on; grid on; box on;
end
hold on;
scatter3(0.5,0.5,0.85,'bo');
xlim([-2 2]);
ylim([-2 2]);
zlim([0 3]);
title(['FINAL IRS-FOCUSED POINTS (N_P = ' num2str(N) ')']);
xlabel('x');
ylabel('y');
zlabel('z');

end
