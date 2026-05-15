function [irsVis] = irsVisibility(led,pd,irs)
%IRSVISIBILITY - IRS visibility of IRS units from PD for all IRS and LEDs
%  irsVis : length(irs) x led.K*NR matrix

irsVis = zeros(length(irs),led.K*irs(1).NR);

for w = 1:length(irs)

   u = reshape(repmat(led.lT,irs(w).NR,1),3,irs(w).NR*led.K)-repmat(irs(w).lT,1,led.K);
   u = u./vecnorm(u);

   v = repmat(pd.lR,1,led.K*irs(w).NR)-repmat(irs(w).lT,1,led.K);
   v = v./vecnorm(v);

   ntil_k = repmat(irs(w).nT,1,led.K);
   n_bar = repmat(pd.nR,1,led.K*irs(w).NR);

   a = acosd(sum(u.*ntil_k,1));
   b = acosd(sum(v.*ntil_k,1));
   psi = acosd(sum(-v.*n_bar,1));

   irsVis(w,:) = (a < 90).* (b < 90) .* (psi < pd.FOV);
   
end
