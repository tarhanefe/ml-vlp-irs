function cost = costCRLB2(points,led,pd,irs_profiles,noise_sig)
% COSTFUNC_LR - Calculates the cost function for various algorithms
% loc : Current position of the PD
% led     : LED struct
% pd      : PD struct
% irs_profiles     : IRS struct
% irs_idx      : Received power
% type    : Solver type : {'lsq', 'pso'}
% noise_sig : DIR_IRS struct 

for i = 1:length(irs_profiles)
    irs_profiles{i} = directIRS2POS(points(3*i-2:3*i)',led,irs_profiles{i},1);
end

cost = calcCRLB(led,pd,irs_profiles,noise_sig,3,'LOS_IRS');


