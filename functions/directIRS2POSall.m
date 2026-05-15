function irs_profiles = directIRS2POSall(points,led,irs_profiles)
% directIRS2POS - Calculates the directed orientation of IRSs for ith LED
% led : LED struct
% pos  : [x y] struct
% irs : IRS struct
% i   : LED index

i = 1;
for n = 1:length(irs_profiles)
    irs_profiles{n} = directIRS2POS(points(3*n-2:3*n),led,irs_profiles{n},i);
end

