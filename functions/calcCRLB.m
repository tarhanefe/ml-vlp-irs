function [CRLB] = calcCRLB(led,pd,irs_profiles,sig,dim,alg)
%CALCCRLB - Calculate Cramer-Rao Lower Bound
% led     : LED struct
% pd      : PD struct
% irs     : IRS struct
% sig     : Noise variance
% alg     : Algorithm : {'LOS','LOS_IRS','IRS','LOS_IRS_DIR','IRS_DIR'}

CRLB = zeros(1,length(sig));

ledVis = ledVisibility(led,pd);

parDers = HDer(led,pd);                      % partial derivatives for LOS
parDerTils = HtilDer(led,pd,irs_profiles);   % partial derivatives for IRS

if strcmpi(alg,'IRS')
   hji = parDerTils;
elseif strcmpi(alg,'LOS_IRS')
   hji = repmat(ledVis,3,1) .* parDers + parDerTils;
end

for k = 1:length(sig)
   FIM = zeros(dim,dim);
   for i=1:length(irs_profiles)
      if dim == 2
         htemp = [hji(1,i) hji(2,i)];
      elseif dim == 3
         htemp = [hji(1,i) hji(2,i) hji(3,i)];
      else
         error('Invalid dimension!');
      end

      FIM = FIM + (htemp'*htemp)*led.PT^2/sig(k).^2;
   end

   CRLB(k) = sqrt(trace(inv(FIM)));
end