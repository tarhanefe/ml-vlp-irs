function [RMSE,CRLB,sig_dB] = calc_RMSE(N,orientation,nOfSamples)
%% Define the system 
pd = placePDs(1,[0.5;0.5;0.85],[0;0;0]);
led = placeLEDs(1);
led.m = 20;
irs_p1d = 21;
r = 0.5;
mu = 5;
irs = placeIRS(irs_p1d,1,r,mu);

dim = 3;
sig_dB = 100:5:170;
sig = 10.^(-sig_dB/20);

%% Set IRS profiles depending on the system
if strcmp(orientation,"random")
    irs_profiles = genIrsProfiles(led,pd,irs,irs_p1d,N,'rand');
elseif strcmp(orientation,"aligned")
    irs_profiles = genIrsProfiles(led,pd,irs,irs_p1d,N,'aligned');
elseif strcmp(orientation,"focused")
    irs_profiles = cell(length(N),1);
    points_n = load("data/bounded_single_optim/N_" + string(N) +"_pso.mat").points_n;
    for n = 1:N
        irs_profiles{n} = directIRS2POS(points_n(n,:)',led,irs,1);
    end
end


%% Calculate CRLB

CRLB = calcCRLB(led,pd,irs_profiles,sig,dim,'LOS_IRS');

%% Calculate RMSE
PR_IRS = zeros(N,1);

for i = 1:N
   PR_IRS(i) = calcIRSPower(led,pd,irs_profiles{i},pd.lR) + calcReceivedPower(led,pd,pd.lR);
end

lR_hat_irs = zeros(3,length(sig),nOfSamples);

for i = 1:length(sig)
   disp([num2str(i) '/' num2str(length(sig)) '...']);
   disp("%");
   fprintf("\b")
   number = 0;
   tic;
   for j = 1:nOfSamples
      PR = PR_IRS + sig(i)*randn(N,1);
      lR_hat_irs(:,i,j) = lR_lsq(led,pd,irs_profiles,PR,dim,'LOS_IRS');
      numLength = length(num2str(number));
      fprintf(repmat('\b', 1, numLength));
      number = j/nOfSamples*100;
      fprintf(num2str(number));
   end
   toc;
end

lR_rep = repmat(pd.lR,1,length(sig),nOfSamples);
lR_irs_err = reshape(vecnorm(lR_rep-lR_hat_irs),length(sig),nOfSamples);
RMSE = sqrt(sum(lR_irs_err.^2,2)/nOfSamples);

%%
figure();
semilogy(sig_dB,CRLB,'x--');
hold on;
semilogy(sig_dB,RMSE,'o-');
grid on;

ylabel('RMSE (m)');
xlabel('$$\rm{10log_{10}(1/{\sigma}^2) (dB)}$$','Interpreter','LaTeX');
legend({'CRLB','MLE'});


%%
filename = ['data/data_rmse_crlb_all/N_' num2str(N) '_orientation_' char(orientation)];
save(string(filename), "RMSE","CRLB","sig_dB");
end

