function P = calcIRSPower(led,pd,irs,curr_lR)
%CALCIRSPOWER - Calculates total IRS power per LED
% P = calcIRSPower(led,pd,irs,curr_lR)
% led     : LED struct
% pd      : PD struct
% irs     : IRS struct
% curr_lR : Given position of PD
% P       : Total IRS power from each LED [Kx1]

pd.lR = curr_lR;

irsVis = irsVisibility(led,pd,irs);

P = zeros(length(irs),led.K);

for w = 1:length(irs)
   m = repelem(led.m,1,irs(w).NR);
   c = (m+1)./(4*pi^2).*(pd.S*irs(w).rho*ones(1,irs(w).NR*led.K));
   u = repmat(irs(w).lT,1,led.K)-reshape(repmat(led.lT,irs(w).NR,1),3,irs(w).NR*led.K);
   led_nT_rep = reshape(repmat(led.nT,irs(w).NR,1),3,led.K*irs(w).NR);
   irs_nT_rep = reshape(repmat(irs(w).nT,1,led.K),3,led.K*irs(w).NR);
   v =  repmat(repmat(curr_lR,1,irs(w).NR)-irs(w).lT,1,led.K);
   t1 = (sum(u.*led_nT_rep,1).^m) .* (sum(-u.*irs_nT_rep,1)) .* sum(-v.*pd.nR,1) ./ (vecnorm(u).^(m+3) .* vecnorm(v).^(3));
   cos_bik_aik = sum(v.*irs_nT_rep,1)./vecnorm(v) .* sum(-u.*irs_nT_rep,1)./vecnorm(u) ...
      + vecnorm(cross(v,irs_nT_rep))./vecnorm(v) .* vecnorm(cross(-u,irs_nT_rep))./vecnorm(u);
   t2 = 2*irs(w).r*sum(v.*irs_nT_rep,1) ./ vecnorm(v) + (1-irs(w).r)*(irs(w).mu+1)*cos_bik_aik.^irs(w).mu;
   A = irsVis(w,:).*repelem(led.PT,1,irs(w).NR).*irs(w).S.*c.*t1.*t2;
   P(w,:) = sum(reshape(A,irs(w).NR,led.K),1);
end
P = sum(P,1)';