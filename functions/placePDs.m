function [pd] = placePDs(N,lR,oR)

pd.N = N;
pd.lR = lR;
pd.S = 1e-4*ones(1,N);
pd.Rp = 1;
pd.draw = 1;
pd.aware = 0;

pd.nBar = [0;0;1];
pd.FOV = 90;
pd.beta = 30;
pd.r_layout = 0.1;

if N == 1
   pd.nR_bar = [0;0;1];
   pd.an_bar = [0;0;0];
elseif N > 1
   pd.nR_bar = pd_normal_gen(N,pd.beta);
   pd.an_bar = circular_lg(N,pd.r_layout);
else
   error('N must be positive.');
end

pd.a = oR(1);
pd.b = oR(2);
pd.g = oR(3);
pd.oR = oR;

pd.R = rot3D(pd.a,pd.b,pd.g);
pd.nR = pd.R*pd.nR_bar;
pd.an = pd.R*pd.an_bar;

end

function [layout] = circular_lg(N, r_layout)

%CIRCULAR_LG
%this function calculates the relative positions of PDs with respect
%to the center of circular layout
%it returns 3xN matrix
%:x3 components are all zero

angle = 2*pi/N;
layout = zeros(3,N);
for i = 1:N
  layout(1,i) = cos(angle*(i-1))*r_layout;
  layout(2,i) = sin(angle*(i-1))*r_layout;
end

end

function [nR] = pd_normal_gen(N,beta)

%NORMAL_GEN
%this function calculates the normal vectors of PDs
%beta is the angle between normal of the layout and PD
%beta is towards outwards

angle = 2*pi/N;
nR = zeros(3, N);

for i = 1:N
  nR(1,i) = sind(beta)*cos(angle*(i-1));
  nR(2,i) = sind(beta)*sin(angle*(i-1));
  nR(3,i) = cosd(beta);
end

end