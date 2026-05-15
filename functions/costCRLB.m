function cost = costCRLB(loc,led,pd,irs_profiles,irs_idx,noise_sig)
% COSTFUNC_LR - Calculates the cost function for various algorithms
% loc : Current position of the PD
% led     : LED struct
% pd      : PD struct
% irs_profiles     : IRS struct
% irs_idx      : Received power
% type    : Solver type : {'lsq', 'pso'}
% noise_sig : DIR_IRS struct


irs_profiles{irs_idx} = directIRS2POS(loc,led,irs_profiles{irs_idx},1);
cost = calcCRLB(led,pd,irs_profiles,noise_sig,3,'IRS');


