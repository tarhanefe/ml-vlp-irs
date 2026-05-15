function [led] = placeLEDs(K)

led.K = K;
led.m = 5*ones(1,K);
led.PT = 5*ones(1,K);
led.PE = led.PT;
led.draw = ones(1,K);

irs_center = [0;2;1.5];

led.lT = [0;0;3];
led.nT = (irs_center-led.lT)/norm(irs_center-led.lT);

if K > 1
   error('Only 1 LED is supported!');
end
