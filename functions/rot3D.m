function [R,Rx,Ry,Rz] = rot3D(a,b,g,varargin)
%ROT3D - Generates 3D rotation matrix
% a : Rotation around x axis
% b : Rotation around y axis
% g : Rotation around z axis

if nargin == 3
   Rx = [1 0       0;
         0 cosd(a) -sind(a);
         0 sind(a) cosd(a)];
   
   Ry = [cosd(b)  0 sind(b);
         0        1 0;
         -sind(b) 0 cosd(b)];
   
   Rz = [cosd(g) -sind(g) 0;
         sind(g) cosd(g)  0;
         0       0        1];
elseif nargin == 4
   if strcmpi(varargin{1},'rad')
      Rx = [1 0      0;
            0 cos(a) -sin(a);
            0 sin(a) cos(a)];
   
      Ry = [cos(b)  0 sin(b);
            0       1 0;
            -sin(b) 0 cos(b)];
      
      Rz = [cos(g) -sin(g) 0;
            sin(g)  cos(g) 0;
            0       0      1];
   elseif strcmpi(varargin{1},'deg')
      Rx = [1 0       0;
            0 cosd(a) -sind(a);
            0 sind(a) cosd(a)];
   
      Ry = [cosd(b)  0 sind(b);
            0        1 0;
            -sind(b) 0 cosd(b)];
      
      Rz = [cosd(g) -sind(g) 0;
            sind(g) cosd(g)  0;
            0       0        1];
   end
else
   error('Invalid number of parameters!');
end

R = Rz*Ry*Rx;  

end