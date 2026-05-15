function irs = placeIRS(p1d,irsEn,r,mu)
%PLACEIRS - Places IRS elements
% p1d   : Number of IRS elements in one dimension, NR = p1d^2
% irsEn : Enabled walls on which IRS elements are located

%% IRS Parameters
if(mod(p1d,2) == 0)
   error('p1d must be an odd number for symmetry!');
end

hl = 0.04;              % Horizontal length of a single IRS element
vl = 0.02;              % Vertical length of a single IRS element
hd = 0.01;              % Horizontal distance barrier of a single IRS element
vd = 0.005;             % Vertical distance barrier of a single IRS element

Sk = hl*vl;             % Area of a single IRS element
rho_k = 0.95;           % Reflectance coefficient rho
r_k = r;                % Diffusing parameter r
mu_k = mu;              % Directivity parameter mu
mid_idx = (p1d+1)/2;    % Mid index

%% Wall 1 IRS
i1.hl = hl;
i1.vl = vl;
i1.hd = hd;
i1.vd = vd;
i1.rho = rho_k;
i1.r = r_k;
i1.mu = mu_k;
i1.NR = p1d^2;
i1.draw = 1;
i1.S = Sk;
i1.lT = zeros(3,p1d^2);
i1.rot = zeros(3,p1d^2);

for i = 1:p1d
   for j = 1:p1d
      idx = p1d*(i-1)+j;
      i1.lT(:,idx) = [(j-mid_idx)*(hl+2*hd);2-hl/2;(i-mid_idx)*(vl+2*vd)+1.5];
   end
end
i1.nT_0 = [0;-1;0];
i1.nT = repmat(i1.nT_0,1,p1d^2);

%% Wall 2 IRS
i2 = i1;
i2.lT = zeros(3,p1d^2);

for i = 1:p1d
   for j = 1:p1d
      idx = p1d*(i-1)+j;
      i2.lT(:,idx) = [2-hl/2;(j-mid_idx)*(hl+2*hd);(i-mid_idx)*(vl+2*vd)+1.5];
   end
end
i2.nT_0 = [-1;0;0];
i2.nT = repmat(i2.nT_0,1,p1d^2);

%% Wall 3 IRS
i3 = i1;
i3.lT = zeros(3,p1d^2);

for i = 1:p1d
   for j = 1:p1d
      idx = p1d*(i-1)+j;
      i3.lT(:,idx) = [(j-mid_idx)*(hl+2*hd);-2+hl/2;(i-mid_idx)*(vl+2*vd)+1.5];
   end
end

i3.nT_0 = [0;1;0];
i3.nT = repmat(i3.nT_0,1,p1d^2);

%% Wall 4 IRS
i4 = i1;
i4.lT = zeros(3,p1d^2);

for i = 1:p1d
   for j = 1:p1d
      idx = p1d*(i-1)+j;
      i4.lT(:,idx) = [-2+hl/2;(j-mid_idx)*(hl+2*hd);(i-mid_idx)*(vl+2*vd)+1.5];
   end
end

i4.nT_0 = [1;0;0];
i4.nT = repmat(i4.nT_0,1,p1d^2);

%% IRS enable
irs = [i1 i2 i3 i4];
irs = irs(irsEn);

end