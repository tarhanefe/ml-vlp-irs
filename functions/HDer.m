function [parDers] = HDer(led,pd)

parDers = zeros(3,led.K);

% Symbols to match the draft for easier tracing
A = pd.S;
x = pd.lR;
nbar = pd.nR;

for i = 1:led.K

   % Symbols to match the draft for easier tracing
   m_i = led.m(i);
   l_i = led.lT(:,i);
   n_i = led.nT(:,i);

   % Iterate over each dimension
   for l = 1:3

      nbar_l = pd.nR(l);
      n_il = n_i(l);
      l_il = l_i(l);
      x_l = x(l);
    
      t1 = -(m_i+1)*A/(2*pi*norm(x-l_i)^(m_i+3));
      t2 = nbar_l*((x-l_i)'*n_i)^m_i;
      t3 = -m_i*n_il*((x-l_i)'*n_i)^(m_i-1)*(l_i-x)'*nbar;
      t4 = (m_i+3)*(x_l-l_il)*((x-l_i)'*n_i)^m_i*(l_i-x)'*nbar/norm(x-l_i)^2;
    
      parDers(l,i) = t1*(t2+t3+t4);
      
   end
end