%% Clean up
clear;
clc;
close all;
%%
[CRLBList,points_n] = createOptimCRLB2(4,'random','pso');
save("data/bounded_single_optim/N_4_pso.mat","CRLBList","points_n");
%%
[CRLBList,points_n] = createOptimCRLB2(9,'random','pso');
save("data/bounded_single_optim/N_9_pso.mat","CRLBList","points_n");

[CRLBList,points_n] = createOptimCRLB2(16,'random','pso');
save("data/bounded_single_optim/N_16_pso.mat","CRLBList","points_n");

[CRLBList,points_n] = createOptimCRLB2(25,'random','pso');
save("data/bounded_single_optim/N_25_pso.mat","CRLBList","points_n");


