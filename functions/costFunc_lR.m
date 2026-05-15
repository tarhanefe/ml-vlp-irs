function [F,J] = costFunc_lR(curr_lR,led,pd,irs_profiles,PR,type,alg)
%COSTFUNC_LR - Calculates the cost function for various algorithms
% curr_lR : Current position of the PD
% led     : LED struct
% pd      : PD struct
% irs     : IRS struct
% PR      : Received power
% type    : Solver type : {'lsq','pso','exh','ms'}
% alg     : Algorithm : {'LOS','LOS_IRS','LOS_IRS_DIR'}
% irs_dir : DIR_IRS struct

dim = size(curr_lR,1);
scale = 1e8;
% scale = 1e0;

N = length(irs_profiles);

if dim == 2
   curr_lR(3) = pd.lR(3);
end

if strcmp(alg,'IRS')
   P2 = zeros(N,1);
   for i = 1:N
      P2(i) = calcIRSPower(led,pd,irs_profiles{i},curr_lR);
   end

elseif strcmp(alg,'LOS_IRS')
    P2 = zeros(N,1);
    for i = 1:N
        P2(i) = calcReceivedPower(led,pd,curr_lR) + calcIRSPower(led,pd,irs_profiles{i},curr_lR);
    end
else
   error('Invalid algorithm!');
end

if strcmp(type,'lsq')
   F = scale * (PR-P2)';
elseif strcmp(type,'pso') || strcmp(type,'exh') || strcmp(type,'ms')
   F = 1e12*sum((PR-P2).^2);
else
   error('Invalid type!');
end

if nargout > 1
   c_hat = (led.m+1)/(2*pi)*led.PE'*pd.S*pd.Rp;
   
   u_hat = led.lT-repmat(curr_lR,1,led.K);
   
   g1_hat = diag(-transpose(led.nT)*u_hat);
   g2_hat = transpose(transpose(pd.nR)*u_hat);
   g3_hat = transpose(vecnorm(u_hat).^(led.m+3));

   d_hat = transpose(vecnorm(repmat(curr_lR,1,led.K)-led.lT));
   theta_hat = acosd(transpose(pd.nR'*u_hat)./d_hat);
   inFOV_hat = pd.FOV > theta_hat;
   
   g1_lrp = inFOV_hat' .* transpose(led.m*(diag(-transpose(led.nT)*u_hat)).^(led.m-1)).*led.nT;
   g2_lrp = inFOV_hat' .* repmat(-pd.nR,1,led.K);
   g3_lrp = inFOV_hat' .* ((led.m+3)*vecnorm(u_hat).^(led.m+1).*-u_hat);
   
   dfkn_dlrp = -scale*c_hat'.*(g3_hat' .* (g2_hat'.*g1_lrp + g1_hat'.*g2_lrp) - (g1_hat'.*g2_hat') .* g3_lrp)./(g3_hat.^2)';
   J = transpose(dfkn_dlrp);

   if dim == 2
      J = J(:,1:2);
   end
end
