function pwr = calcPower(x,nb,irs,led,noise_variance,noise_bool)
lt = irs.xt;
nt = irs.nt;
l = led.l;
n = led.n;
P = led.power;
var = noise_variance;
m = 5;
A = irs.size(1)*irs.size(2);
pk = 0.95;
muk = 5;
rk = 0;
Apd = 1e-4;


d1 = dot((x-lt)',nt')';
d2 =  dot((l-lt)',nt')';
d3 = (lt-l)*n';
d4 = (lt-x)*nb';
n1 = nnorm(x-lt);
n2 = nnorm(l-lt);
nc1 = nnorm(ccros(x-lt,nt));
nc2 = nnorm(ccros(l-lt,nt));
%Calculation of NLoS gain
kcos1 = d1.*d2;
kcos2 = n1.*n2;
kcos3 = nc1.*nc2;
kcos = (kcos1 + kcos3)./kcos2;

k1 = (m+1)*d3.^m;
k1_1 = d2;
k2 = 4*pi^2.*n2.^(m+3).*n1.^3;
k3 = A*pk.*d4.*Apd;
k4 = 2*rk.*d1./n1;
k5 = (1-rk)*(muk+1).*(kcos).^muk;
pwr.nlos_gain = k1.*k1_1./k2.*k3.*(k4+k5);
f2 = irsVisibility(x,nb,irs,led);
pwr.nlos_power = P*sum(pwr.nlos_gain.*f2);
%pwr.nlos_power = P*sum(pwr.nlos_gain);

pwr.noise_power = sqrt(var)*randn();
pwr.power = pwr.nlos_power + pwr.noise_power*noise_bool;

end