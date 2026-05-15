function [ledVis] = ledVisibility(led,pd)

ledVis = zeros(1,led.K);

for i = 1:led.K
   if ((led.lT(:,i)-pd.lR)'*pd.nR) >= (norm(led.lT(:,i)-pd.lR) * cosd(pd.FOV))
      ledVis(1,i) = 1; % indicators (visibility in FOV) 
   end
end

end

