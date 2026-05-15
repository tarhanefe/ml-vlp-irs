function irs_profiles = genIrsProfiles(led,pd,irs,irs_p1d,N,alg)

%GENIRSPROFİLES This function creates N different IRS profiles
%   alg: 'rand'    : random orientation of irs units
%        'aligned' : all irs units have the same orientation in a single profile
%        'focused' : irs units are oriented such that the received power is
%                    maximized for a chosen location
%rng(seed);
irs_profiles = cell(1,N);

for n = 1:N
   irs_profiles{n} = irs;
end

alp = zeros(irs_p1d,irs_p1d,N);
gam = zeros(irs_p1d,irs_p1d,N);

if strcmpi(alg,'rand')
   %rng(42,"twister");
   alp = -60*rand(irs_p1d,irs_p1d,N)+20;
   gam = 60*rand(irs_p1d,irs_p1d,N)-30;

elseif strcmpi(alg,'aligned')

   % aligned, normallar esit Np: profil sayısı kadar

   N_ = floor(sqrt(N));
   azimuth = linspace(-30,30,N_);
   elevation = linspace(-20,40,N_);
   [n,m] = ndgrid(azimuth,elevation);
   gridz = [m(:),n(:)];
   for n = 1:N
      for i = 1:irs_p1d
         for j = 1:irs_p1d
            alp(i,j,n) = gridz(n,2);
            gam(i,j,n) = gridz(n,1);
         end
      end
   end
elseif strcmpi(alg,'focused')

   % Np tane focus noktası

   g1d = ceil(sqrt(N));
   [X,Y] = meshgrid(linspace(-1.5,1.5,g1d),linspace(-1.5,1.5,g1d));

   lR_grid = transpose([X(:),Y(:),pd.lR(3)*ones(g1d^2,1)]);

   figure;
   for i = 1:N
      plot(lR_grid(1,i),lR_grid(2,i),'rx');
      hold on; grid on; box on;
   end
   xlim([-2 2]);
   ylim([-2 2]);
   title(['IRS-FOCUSED POINTS (N_P = ' num2str(N) ')']);
   xlabel('x');
   ylabel('y');

   for n = 1:N
      pd.lR = lR_grid(:,n);
      irs_profiles{n} = directIRS2LED(led,pd,irs,1,'fmincon','analytical');
   end
elseif strcmpi(alg,'focused_3')

   g1d = ceil(sqrt(N));
   [X,Y] = meshgrid(linspace(-2.5,2.5,g1d),linspace(-4.5,1.5,g1d));

   lR_grid = transpose([X(:),Y(:),pd.lR(3)*ones(g1d^2,1)]);

   figure;
   for i = 1:N
      plot(lR_grid(1,i),lR_grid(2,i),'rx');
      hold on; grid on; box on;
   end
   xlim([-3 3]);
   ylim([-3 3]);
   title(['IRS-FOCUSED_3 POINTS (N_P = ' num2str(N) ')']);
   xlabel('x');
   ylabel('y');

   for n = 1:N
      pd.lR = lR_grid(:,n);
      irs_profiles{n} = directIRS2LED(led,pd,irs,1,'fmincon','analytical');
   end
     
end

if ~strcmpi(alg,'focused')
   for n = 1:N
      for i = 1:irs_p1d
         for j = 1:irs_p1d
            irs_profiles{n}.rot(1,irs_p1d*(i-1)+j) = alp(i,j,n);
            irs_profiles{n}.rot(3,irs_p1d*(i-1)+j) = gam(i,j,n);
            irs_profiles{n}.nT(:,irs_p1d*(i-1)+j) = rot3D(alp(i,j,n),0,gam(i,j,n)) * irs_profiles{n}.nT(:,irs_p1d*(i-1)+j);
         end
      end
   end
end
