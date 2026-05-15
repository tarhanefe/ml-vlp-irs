function visualizeRoom(led,pd,irs)
%VISUALIZEROOM - Creates a visual representation of the simulation room
% led : LED struct
% pd  : PD struct
% irs : IRS struct

scale = 0.2;

K = size(led.lT,2);
N = size(pd.nR,2);

figure;

for w = 1:K
   if led.draw(w)
      quiver3(led.lT(1,w),led.lT(2,w),led.lT(3,w),led.nT(1,w)*scale,led.nT(2,w)*scale,led.nT(3,w)*scale,'k');
      hold on;
      text(led.lT(1,w)-0.2,led.lT(2,w),led.lT(3,w)+0.15,['LED ' num2str(w) ': [' num2str(led.lT(1,w)) ' ' num2str(led.lT(2,w)) ' ' num2str(led.lT(3,w)) ']^T'],'FontSize',10);

      plot3(led.lT(1,w),led.lT(2,w),led.lT(3,w),'kx','Linewidth',2);
      % text(led.lT(1,w),led.lT(2,w)+0.15,led.lT(3,w)+0.2,['P_T = ' num2str(led.PT(w)) ' W'],'FontSize',9);
   end
end

grid on;
box on;
xlabel('x (m)');
ylabel('y (m)');
zlabel('height (m)');

xlim([-2 2]);
ylim([-2 2]);
zlim([0 3.3]);

if pd.draw
   circle(pd.lR(1),pd.lR(2),pd.lR(3),pd.r_layout,pd.R);
   circle(pd.lR(1),pd.lR(2),pd.lR(3)-0.03,pd.r_layout,pd.R);
end

for w = 1:N
   if pd.draw
      quiver3(pd.an(1,w)+pd.lR(1),pd.an(2,w)+pd.lR(2),pd.an(3,w)+pd.lR(3),pd.nR(1,w)*scale,pd.nR(2,w)*scale,pd.nR(3,w)*scale,'k');
      hold on;
      if N > 1
         text(pd.an(1,w)+pd.lR(1),pd.an(2,w)+pd.lR(2),pd.an(3,w)+pd.lR(3)+0.1,['PD ' num2str(w)],'FontSize',10);
      else
         text(pd.an(1,w)+pd.lR(1)+0.05,pd.an(2,w)+pd.lR(2),pd.an(3,w)+pd.lR(3)+0.1,'PD','FontSize',10);
      end
      
   end
end

for w = 1:length(irs)
   for k = 1:irs(w).NR

      nT_0 = irs(w).nT_0;
      ltil_k = irs(w).lT(:,k);
      ntil_k = irs(w).nT(:,k);
      rot_k = irs(w).rot(:,k);

      if irs(w).draw

         % quiver3(ltil_k(1),ltil_k(2),ltil_k(3),ntil_k(1)*scale/4,ntil_k(2)*scale/4,ntil_k(3)*scale/4,'m');
         quiver3(ltil_k(1),ltil_k(2),ltil_k(3),ntil_k(1)*scale/1.5,ntil_k(2)*scale/1.5,ntil_k(3)*scale/1.5,'k');

         R = rot3D(rot_k(1),rot_k(2),rot_k(3));

         switch(w)
            case 1
               % R = rot3D(-90,0,0);
               d = [-irs(w).hl/2 irs(w).hl/2 irs(w).hl/2  -irs(w).hl/2 ;
                    0            0           0            0            ;
                    irs(w).vl/2  irs(w).vl/2 -irs(w).vl/2 -irs(w).vl/2];
            case 2
               % R = rot3D(0,90,0);
               d = [0            0            0            0            ;
                    irs(w).hl/2  -irs(w).hl/2 -irs(w).hl/2  irs(w).hl/2 ;
                    irs(w).vl/2  irs(w).vl/2  -irs(w).vl/2 -irs(w).vl/2];
            case 3
               % R = rot3D(90,0,0);
               d = [irs(w).hl/2 -irs(w).hl/2 -irs(w).hl/2  irs(w).hl/2  ;
                    0            0           0             0            ;
                    irs(w).vl/2  irs(w).vl/2 -irs(w).vl/2  -irs(w).vl/2];
            case 4
               % R = rot3D(0,-90,0);
               d = [0            0           0            0            ;
                    -irs(w).hl/2 irs(w).hl/2 irs(w).hl/2  -irs(w).hl/2 ;
                    irs(w).vl/2  irs(w).vl/2 -irs(w).vl/2 -irs(w).vl/2];
            otherwise
               error('Invalid wall index!');
         end

         r_d = R*d;
         p = repmat(irs(w).lT(:,k),1,4) + r_d;
         
         P = patch(p(1,:),p(2,:),p(3,:),[0.9 0.9 0.9]);
         % P = patch(p(1,:),p(2,:),p(3,:));
         % P.FaceColor = [0.9 0.9 0.9];
         P.EdgeColor = [0.6 0.6 0.6];

         % [a,b] = calc_rot(irs(w).nT(:,k));
         % circle(irs(w).lT(1,k),irs(w).lT(2,k),irs(w).lT(3,k),0.001,rot3D(a,b,0));
      
         hold on;
         % m = mean(irs(i).lT,2);
         % text(m(1),m(2),m(3)+0.2,['IRS ' num2str(i)],'FontSize',8);
      end
   end
end

end

function circle(x,y,z,r,R)

th = 0:pi/50:2*pi;
xr_bar = r * cos(th);
yr_bar = r * sin(th);
zr_bar = zeros(1,length(xr_bar));

p_bar = [xr_bar;yr_bar;zr_bar];

p = (R*p_bar);

xr = p(1,:) + x;
yr = p(2,:) + y;
zr = p(3,:) + z;

plot3(xr, yr, zr,'k');

end