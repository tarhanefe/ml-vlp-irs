%%
close all;
clearvars;
%%
var_list = 100:5:200;
a1 = load('mle_directed_100_4x4_xrand.mat').directed_sixteen_errors;
a2 = load('mle_directed_100_4x4_xo.mat').directed_sixteen_errors;

a3 = load('mle_directed_500_4x4_xrand.mat').directed_sixteen_errors;
a4 = load('mle_directed_500_4x4_xo.mat').directed_sixteen_errors;

b = load('crlb_directed_100_4x4_xrand.mat').directed_crlb_4x4;

figure();
p1 = semilogy(var_list,a1,'d-');
p1.Color = 'r';
hold on 

p2 = semilogy(var_list,a2,'s-');
p2.Color = 'g';
hold on 

p3 = semilogy(var_list,a3,'o-');
p3.Color = 'b';
hold on 

p4 = semilogy(var_list,a4,'.-');
p4.Color = 'm';

p5 = semilogy(var_list,b,'-');
p5.Color = 'k';

legend('RMSE MLE Directed 4x4 w/ n = 100 trials and random x_{0}', ...
       'RMSE MLE Directed 4x4 w/ n = 100 trials and x_{0} = x_{real}', ...
       'RMSE MLE Directed 4x4 w/ n = 500 trials and random x_{0}', ...
       'RMSE MLE Directed 4x4 w/ n = 500 trials and x_{0} = x_{real}', ...
       'CRLB Directed 4x4');
title('RMSE Plot of the Simulation Data')
xlabel('$$\rm{10log_{10}(1/{\sigma}^2) (dB)}$$','Interpreter','LaTeX');
ylabel('RMSE');
grid("on");
%% Directed Comparison 
var_list = 100:5:200;

a = load('directed_sixteen.mat').directed_sixteen_errors;
b = load('directed_nine.mat').directed_nine_errors;
c = load('mle_random_100_4x4.mat').directed_sixteen_errors;
d = load('mle_random_100_3x3.mat').directed_nine_errors;
e = load('uniform_sixteen.mat').uniform_sixteen_errors;
f = load('uniform_nine.mat').uniform_nine_errors;

g = load('crlb_sixteen.mat').directed_crlb_4x4;
h = load('crlb_directed_nine.mat').directed_crlb_3x3;
i = load('crlb_random_100_4x4.mat').directed_crlb_4x4;
j = load('crlb_random_100_3x3.mat').directed_crlb_3x3;
k = load('crlb_uniform_sixteen.mat').uniform_crlb_4x4;
l = load('crlb_uniform_nine.mat').uniform_crlb_3x3;
%%
wd = 0.3;
figure();
p1 = semilogy(var_list,a,'o-', 'LineWidth', wd);
p1.Color = 'r';
hold on 

p2 = semilogy(var_list,b,'o-', 'LineWidth', wd);
p2.Color = 'b';
hold on 

p3 = semilogy(var_list,c,'o-', 'LineWidth', wd);
p3.Color = 'g';
hold on 

p4 = semilogy(var_list,d,'o-', 'LineWidth', wd);
p4.Color = 'm';
hold on 

p5 = semilogy(var_list,e,'o-', 'LineWidth', wd);
p5.Color = 'k';
hold on 

p6 = semilogy(var_list,f,'o-', 'LineWidth',wd);
p6.Color = 'c';
hold on 

p1_1 = semilogy(var_list,g,'d-', 'LineWidth', wd);
p1_1.Color = 'r';
hold on 

p2_1 = semilogy(var_list,h,'d-', 'LineWidth', wd);
p2_1.Color = 'b';
hold on 

p3_1 = semilogy(var_list,i,'d-', 'LineWidth', wd);
p3_1.Color = 'g';
hold on 

p4_1 = semilogy(var_list,j,'d-', 'LineWidth', wd);
p4_1.Color = 'm';
hold on 

p5_1 = semilogy(var_list,k,'d-', 'LineWidth', wd);
p5_1.Color = 'k';
hold on 

p6_1 = semilogy(var_list,l,'d-', 'LineWidth', wd);
p6_1.Color = 'c';
hold on 
legend('RMSE: Directed & 16 Measurements', ...
       'RMSE: Directed & 9 Measurements', ...
       'RMSE: Random & 16 Measurements', ...
       'RMSE: Random & 9 Measurements', ...
       'RMSE: Uniform & 16 Measurements', ...
       'RMSE: Uniform & 9 Measurements', ...
       'CRLB: Directed & 16 Measurements', ...
       'CRLB: Directed & 9 Measurements', ...
       'CRLB: Random & 16 Measurements', ...
       'CRLB: Random & 9 Measurements', ...
       'CRLB: Uniform & 16 Measurements', ...
       'CRLB: Uniform & 9 Measurements');

title('RMSE Plot of Different Orientations of Mirror Array with 9 and 16 Measurements','Interpreter','latex')
xlabel('$$\rm{10log_{10}(1/{\sigma}^2) (dB)}$$','Interpreter','LaTeX');
ylabel('RMSE');
grid("on");
%%
figure();
p1 = semilogy(var_list,a,'o-');
p1.Color = 'r';
hold on 
p2 = semilogy(var_list,b,'o-');
p2.Color = 'b';
hold on 
p1_1 = semilogy(var_list,g,'d-');
p1_1.Color = 'r';
hold on 
p2_1 = semilogy(var_list,h,'d-');
p2_1.Color = 'b';
hold on 
title('RMSE Plot of "Directed" Orientation of Mirror Array with 9 and 16 Measurements','Interpreter','latex')
xlabel('$$\rm{10log_{10}(1/{\sigma}^2) (dB)}$$','Interpreter','LaTeX');
ylabel('RMSE');
legend('RMSE of the ML Estimator: Directed & 16 Measurements', ...
       'RMSE of the ML Estimator: Directed & 9 Measurements', ...
       'CRLB of the ML Estimator: Directed & 16 Measurements', ...
       'CRLB of the ML Estimator: Directed & 9 Measurements');
grid("on");

%%
figure();
p3 = semilogy(var_list,c,'o-');
p3.Color = 'r';
hold on 
p4 = semilogy(var_list,d,'o-');
p4.Color = 'b';
hold on 
p3_1 = semilogy(var_list,i,'d-');
p3_1.Color = 'r';
hold on 
p4_1 = semilogy(var_list,j,'d-');
p4_1.Color = 'b';
hold on 
title('RMSE Plot of "Random" Orientation of Mirror Array with 9 and 16 Measurements','Interpreter','latex')
xlabel('$$\rm{10log_{10}(1/{\sigma}^2) (dB)}$$','Interpreter','LaTeX');
ylabel('RMSE');
legend('RMSE of the ML Estimator: Random & 16 Measurements', ...
       'RMSE of the ML Estimator: Random & 9 Measurements', ...
       'CRLB of the ML Estimator: Random & 16 Measurements', ...
       'CRLB of the ML Estimator: Random & 9 Measurements');
grid("on");


%%
figure();
p3 = semilogy(var_list,e,'o-');
p3.Color = 'r';
hold on 
p4 = semilogy(var_list,f,'o-');
p4.Color = 'b';
hold on 
p3_1 = semilogy(var_list,k,'d-');
p3_1.Color = 'r';
hold on 
p4_1 = semilogy(var_list,l,'d-');
p4_1.Color = 'b';
hold on 
title('RMSE Plot of "Uniform" Orientation of Mirror Array with 9 and 16 Measurements','Interpreter','latex')
xlabel('$$\rm{10log_{10}(1/{\sigma}^2) (dB)}$$','Interpreter','LaTeX');
ylabel('RMSE');
legend('RMSE of the ML Estimator: Uniform & 16 Measurements', ...
       'RMSE of the ML Estimator: Uniform & 9 Measurements', ...
       'CRLB of the ML Estimator: Uniform & 16 Measurements', ...
       'CRLB of the ML Estimator: Uniform & 9 Measurements');
grid("on");




