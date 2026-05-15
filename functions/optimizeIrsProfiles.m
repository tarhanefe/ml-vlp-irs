function [irs_profiles,points_n] = optimizeIrsProfiles(pd,led,irs,N,init_state,type,noise)

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

end


%% Plotting the initial focus points.
figure;
subplot(1,2,1);
for i = 1:N
  plot(points(i,1),points(i,2),'rx');
  hold on; grid on; box on;
end
plot(0.5,0.5,'bo');
xlim([-2 2]);
ylim([-2 2]);
title(['INITAL IRS-FOCUSED POINTS (N_P = ' num2str(N) ')']);
xlabel('x');
ylabel('y');
%% Optimize the IRS focus points 
lb = [-2,-2]';
ub = [2,2]';
disp_opt = 'iter';
points_n = [];
for n = 1:N
    costFunc = @(x) costCRLB(x',led,pd,irs_profiles,n,noise);
    if strcmp(type, "pso")
        options = optimoptions('particleswarm', ...
        'SwarmSize', 50, ...              % Number of particles in the swarm
        'MaxIterations', 1000, ...         % Maximum number of iterations
        'MaxStallIterations', 10, ...     % Maximum number of iterations without improvement
        'Display', 'iter');
        [new_loc,~,~] = particleswarm(costFunc,2,lb,ub,options);
        irs_profiles{n} = directIRS2POS(new_loc',led,irs,1);
        points_n = vertcat(points_n,new_loc);
    elseif strcmp(type,"fmincon")
        lR_opt = optimoptions(@fmincon);
        lR_opt.Display = 'iter';
        [new_loc,fval] = fmincon(costFunc, points(n,1:2),[],[],[],[],lb,ub,[],lR_opt);
        points_n = vertcat(points_n,new_loc);
        irs_profiles{n} = directIRS2POS(new_loc(1:2)',led,irs,1);
    end

    

end

%% Plotting the final focus points.
subplot(1,2,2);
for i = 1:N
  plot(points_n(i,1),points_n(i,2),'rx');  
  hold on; grid on; box on;
end
hold on;
plot(0.5,0.5,'bo');
xlim([-2 2]);
ylim([-2 2]);
title(['FINAL IRS-FOCUSED POINTS (N_P = ' num2str(N) ')']);
xlabel('x');
ylabel('y');


end
