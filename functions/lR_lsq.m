function [lR_hat,cost] = lR_lsq(led,pd,irs_profiles,PR,dim,alg)
%LR_LSQ
% This function estimates the position vector lR using lsqnonlin
% Recevier orientation oR is known

%% Initial conditions
if dim == 2
   lR_lim = [-2 -2; 2 2];
   % lR_init = [0 0];
   lR_init = transpose(pd.lR(1:2));
elseif dim == 3
   lR_lim = [-2 -2 0; 2 2 3];
   % lR_init = [0 0 0];
   lR_init = transpose(pd.lR);
else
   error('Invalid dimension');
end
       
lR_opt = optimoptions(@lsqnonlin);
lR_opt.FiniteDifferenceType = 'Central';
lR_opt.StepTolerance = 1e-6;
lR_opt.FunctionTolerance = 1e-6;
% lR_opt.UseParallel = true;

lR_opt.Display = 'off';
% lR_opt.Display = 'iter';
% lR_opt.Display = 'iter-detailed';
% lR_opt.Display = 'final-detailed';

% lR_opt.SpecifyObjectiveGradient = true;
% lR_opt.CheckGradients = true;

%% Run lsqnonlin
costFunc = @(x) costFunc_lR(x',led,pd,irs_profiles,PR,'lsq',alg);
lR_hat = lsqnonlin(costFunc, lR_init, lR_lim(1,:), lR_lim(2,:), lR_opt)';

%% Run PSO
% costFunc_pso = @(x) costFunc_lR(x',led,pd,irs,PR,'pso',alg,irs_dir);
% opts = optimoptions('particleswarm','Display','off');
% [X,~,EXITFLAG] = particleswarm(costFunc_pso,3,lR_lim(1,:),lR_lim(2,:),opts);
% lR_hat = X;

if dim == 2
   lR_hat(3) = pd.lR(3);
end
% cost = costFunc_lR(lR_hat,led,pd,irs,PR,'lsq',alg,irs_dir);