function irs = directIRS2POS(pos,led,irs,i)
% directIRS2POS - Calculates the directed orientation of IRSs for ith LED
% led : LED struct
% pos  : [x y] struct
% irs : IRS struct
% i   : LED index


pos = reshape(pos,[3,1]);
x = pos;


for w = 1:length(irs)
   for k = 1:size(irs(w).lT,2)
      r_k = irs(w).r;
      mu_k = irs(w).mu;
      u = (led.lT(:,i)-irs(w).lT(:,k))/norm(led.lT(:,i)-irs(w).lT(:,k));
      v = (x-irs(w).lT(:,k))/norm(x-irs(w).lT(:,k));
     if r_k == 0
        K   = acosd(u'*v);
        A   = tand(K);
        if abs(K-90) < 1e-3
           alf_0 = atand(sqrt(mu_k/(1+mu_k)));
           bet_0 = K-alf_0;
        else
           a = 1;
           b = -2*mu_k*A-2*A;
           c = -4*mu_k-1;
           d = 2*A*mu_k;
  
           del_0 = b^2 - 3*a*c;
           del_1 = 2*b^3 - 9*a*b*c + 27*a^2*d;
  
           C1 = ((del_1 + sqrt(del_1^2-4*del_0^3))/2)^(1/3);
           C2 = ((del_1 - sqrt(del_1^2-4*del_0^3))/2)^(1/3);
  
           C = C1;
  
           eta = (-1+sqrt(-3))/2;
  
           x_0 = -1/(3*a)*(b+C+del_0/C);
           x_1 = -1/(3*a)*(b+eta^1*C+del_0/(eta^1*C));
           x_2 = -1/(3*a)*(b+eta^2*C+del_0/(eta^2*C));
  
           alf_s = [atand(real(x_0)) atand(real(x_1)) atand(real(x_2))];
           alf_0 = alf_s(alf_s < K & alf_s > 0);
           bet_0 = K-alf_0;
        end
  
        r = u'*v;
  
        P = (cosd(alf_0)-r*cosd(bet_0))/(1-r^2);
        Q = (r*cosd(alf_0)-cosd(bet_0))/(r^2-1);
  
        irs(w).nT(:,k) = P*u + Q*v;
     elseif r_k == 1
        r = u'*v;
        K = acosd(r);
        
        alf_0 = K/2;
        bet_0 = K/2;

        P = (cosd(alf_0)-r*cosd(bet_0))/(1-r^2);
        Q = (r*cosd(alf_0)-cosd(bet_0))/(r^2-1);
  
        irs(w).nT(:,k) = P*u + Q*v;
     else
        K = acosd(u'*v);

        fun = @(x) 2*r_k /((1-r_k)*(mu_k+1))*sind(K-2*x) + cosd(K-2*x).^(mu_k-1).*(-sind(x).*cosd(K-2*x)+2*mu_k*cosd(x).*sind(K-2*x));
        alf_0 = binarySolver(fun,[K/2-10 K/2]);
        bet_0 = K-alf_0;

        r = u'*v;
  
        P = (cosd(alf_0)-r*cosd(bet_0))/(1-r^2);
        Q = (r*cosd(alf_0)-cosd(bet_0))/(r^2-1);
  
        irs(w).nT(:,k) = P*u + Q*v;
     end    
   end
end
end