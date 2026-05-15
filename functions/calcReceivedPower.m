function [P,h] = calcReceivedPower(led,pd,curr_lR)

led.m = led.m(1);

c = (led.m+1)/(2*pi)*pd.S;

u = led.lT-repmat(curr_lR,1,led.K);
g1 = diag(-transpose(led.nT)*u).^led.m;
g2 = transpose(transpose(pd.nR)*u);
g3 = transpose(vecnorm(u).^(led.m+3));

d = transpose(vecnorm(u));

theta = acosd(transpose(pd.nR'*u)./d);
inFOV = pd.FOV > theta;

g = g1.*g2./g3;

P = c*pd.Rp*led.PE'.*g.*inFOV;
if nargout > 0
   h = c*g.*inFOV;
end