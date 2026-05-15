function sol = binarySolver(fun,range)
%BİNARYSOLVER Summary of this function goes here
%   Detailed explanation goes here

if length(range) ~= 2
   error('Range must be a 1x2 vector');
end

maxIterNum = 100;

x_h = range(2);
x_l = range(1);

f_h = fun(x_h);
f_l = fun(x_l);

if sign(f_h)*sign(f_l) ~= -1
   warning('Potentially no solution');
end

x_m = (x_h+x_l)/2;

i = 0;
while i < maxIterNum

   i = i + 1;

   f_m = fun(x_m);

   if abs(f_m) < 1e-4
      break;
   end
   
   if sign(f_m)*sign(f_h) == -1
      x_l = x_m;
      x_m = (x_m+x_h)/2;
   elseif sign(f_m)*sign(f_l) == -1
      x_h = x_m;
      x_m = (x_m+x_l)/2;
   end

   if i == maxIterNum-1
      warning('Reached max number of iterations');
   end
end

sol = x_m;

end

