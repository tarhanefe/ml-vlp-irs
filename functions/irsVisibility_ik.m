function [irsVis] = irsVisibility_ik(led,pd,irs,i,w,k)
%IRSVISIBILITY_IK - IRS visibility of ith LED and kth IRS at wth wall

irs_led_vec = (led.lT(:,i)-irs(w).lT(:,k))/norm(led.lT(:,i)-irs(w).lT(:,k));
irs_pd_vec = (pd.lR-irs(w).lT(:,k))/norm(pd.lR-irs(w).lT(:,k));

theta = acosd(irs_led_vec'*irs_pd_vec);
a_ik = acosd(irs_led_vec'*irs(w).nT(:,k));
b_ik = acosd(irs_pd_vec'*irs(w).nT(:,k));
psi_ik = acosd(-irs_pd_vec'*pd.nR);

if a_ik < 90 && b_ik < 90 && psi_ik < pd.FOV
    irsVis = 1;
else
    irsVis = 0;
end

% irsVis = zeros(length(irs),irs(1).NR);
% 
% for w = 1:length(irs)
%    for k = 1:irs(w).NR
%       % if ((irs(w).lT(:,j)-pd.lR)'*pd.nR) >= (norm(irs(w).lT(:,j)-pd.lR) * cosd(pd.FOV))
%       %    irsVis(w,j) = 1; % indicators (visibility in FOV)
%       % end
% 
%       % tetha = 
%       cos_bik = (pd.lR-irs(w).lT(:,k))'*irs(w).nT(:,k)/norm(pd.lR-irs(w).lT(:,k));
% 
%       if cos_bik > 0
%          irsVis(w,k) = 1; % indicators (visibility in FOV)
%       end
%    end
% end

end
