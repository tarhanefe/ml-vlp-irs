function [parDerTils] = HtilDer(led,pd,irs_profiles)

% Symbols to match the draft for easier tracing
A = pd.S;
x = pd.lR;
nbar = pd.nR;

parDerTils = zeros(3,length(irs_profiles),length(irs_profiles{1}));

% Iterate over each IRS profile
for i = 1:length(irs_profiles)

   % Iterate over each wall
   for w = 1:length(irs_profiles{i})

      % Iterate over each IRS
      for k = 1:irs_profiles{i}(w).NR

         ntil_k = irs_profiles{i}(w).nT(:,k);
         ltil_k = irs_profiles{i}(w).lT(:,k);
         r_k = irs_profiles{i}(w).r;
         mu_k = irs_profiles{i}(w).mu;

         irsVis = irsVisibility_ik(led,pd,irs_profiles{i},1,w,k);

         m_i = led.m;
         l_i = led.lT;
         n_i = led.nT;

         cos_aik = (l_i-ltil_k)'*ntil_k/norm(l_i-ltil_k);
         sin_aik = sqrt(1-cos_aik^2);
         cos_bik_aik = ((x-ltil_k)'*ntil_k)/norm(x-ltil_k)*((l_i-ltil_k)'*ntil_k)/norm(l_i-ltil_k) ...
            + norm(cross(x-ltil_k,ntil_k))/norm(x-ltil_k)*norm(cross(l_i-ltil_k,ntil_k))/norm(l_i-ltil_k);

         % Iterate over each dimension
         for l=1:3

            % Symbols to match the draft for easier tracing
            ltil_kl = ltil_k(l);
            ntil_kl = ntil_k(l);
            nbar_l = nbar(l);
            x_l = x(l);

            t1 = (m_i+1)*A*((ltil_k-l_i)'*n_i)^m_i*((l_i-ltil_k)'*ntil_k)/(4*pi^2*norm(l_i-ltil_k)^(m_i+3));
            t2 = irsVis*irs_profiles{i}(w).rho*irs_profiles{i}(w).S;
            t31 = (ntil_kl*(ltil_k-x)'*nbar - nbar_l*(x-ltil_k)'*ntil_k)*norm(x-ltil_k)^(-4);
            t32 = -4*norm(x-ltil_k)^(-6)*(x_l-ltil_kl)*(x-ltil_k)'*ntil_k*(ltil_k-x)'*nbar;
            t3 = 2*r_k*(t31+t32);
            t41 = cos_bik_aik^mu_k*(-nbar_l*norm(x-ltil_k)^(-3)-3*(ltil_k-x)'*nbar*norm(x-ltil_k)^(-5)*(x_l-ltil_kl));
            t421 = mu_k*cos_bik_aik^(mu_k-1)*(ltil_k-x)'*nbar/norm(x-ltil_k)^3;
            t4221 = cos_aik*(ntil_kl*norm(x-ltil_k)^(-1)-(x-ltil_k)'*ntil_k*norm(x-ltil_k)^(-3)*(x_l-ltil_kl));
            t4222 = ntil_k(f(l+1))*((x_l-ltil_kl)*ntil_k(f(l+1))-(x(f(l+1))-ltil_k(f(l+1)))*ntil_kl)...
                     -ntil_k(f(l+2))*((x(f(l+2))-ltil_k(f(l+2)))*ntil_kl-(x_l-ltil_kl)*ntil_k(f(l+2)));
            t4222 = sin_aik*(norm(cross(x-ltil_k,ntil_k))^(-1)*t4222*norm(x-ltil_k)^(-1)-norm(x-ltil_k)^(-3)*(x_l-ltil_kl)*norm(cross(x-ltil_k,ntil_k)));
            t422 = t4221+t4222;
            t42 = t421*t422;
            t4 = (1-r_k)*(mu_k+1)*(t41+t42);
            parDerTils(l,i,w) = parDerTils(l,i,w) + t1*t2*(t3+t4);
         end
      end
   end
end

parDerTils = sum(parDerTils,3);

end

function y = f(l)
if l <= 3
   y = l;
else
   y = l-3;
end
end