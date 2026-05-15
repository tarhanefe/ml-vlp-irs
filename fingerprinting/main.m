%% Room Power Calculation 
clearvars;
close all;
rng(42,'twister');
led = placeLed(5,[2,2,3],[0,0.8,-0.6]);
irs = placeIRS([4,4,3],[21,21],[0.02,0.04],[0.01,0.02],4,"uniform",[2.5,2.5,0.85]);
noise_var = 10^(-20);
x = [2.5 2.5 0.85];
nb = [0 0 1];
local_power = calcPower(x,nb,irs,led,noise_var,0);


%%
pwr_map = powerMap(irs,led,noise_var);
%%
crlb_map = CRLBMap(irs,led,noise_var);
%%
plotRoomPower(pwr_map);
%% Room Objective Function Test
clearvars;
close all;
rng(42,'twister');

noise_var = 10^(-20);
measurement_count = 9;

for temp = 1:measurement_count
    irs_list(temp) = placeIRS([4,4,3],[21,21],[0.02,0.04],[0.01,0.02],4,"random",[0,1,0]);
end

fnc = objective([2.5,2.5,0.85],[2.5,2.5,0.85],noise_var,measurement_count,irs_list);
%% Fishcer Matrix Test
clearvars;
close all;
noise_var = 10^(-20);
loc = [2.5,2.5,0.85];
nb = [0,0,1];
room = createRoom(4,4,3);
pieces = roomDivider(room,[3,3],0.85);
for temp = 1:9
    irs_list(temp) = placeIRS([4,4,3],[21,21],[0.02,0.04],[0.01,0.02],4,"directed",pieces(temp));
end
led = placeLed(5,[2,2,3],[0,0.8,-0.6]);
fis = fischer_matrix(loc,nb,led,irs_list)/noise_var;
ifis = inv(fis);

%% Testing the MLE 
clearvars;
close all;

loc = [2.5,2.5,0.85];   
noise_var = 10^(-20);
measurement_count = 4;
uniform_rand = 0.85;
x0 = loc + -1*uniform_rand + 2*uniform_rand*rand(1,3);
for temp = 1:measurement_count
    irs_list(temp) = placeIRS([4,4,3],[21,21],[0.02,0.04],[0.01,0.02],4,"random",[0,1,0]);
end
xest = MLE(loc,x0,noise_var,measurement_count,irs_list);

%% 9 Measurement Random Error List 
clearvars;
close all;
loc = [2.5,2.5,0.85];
nb = [0,0,1];
measurement_count = 9;
var_list(1:21) = 0;
room = createRoom(4,4,3);
pieces = roomDivider(room,[3,3],0.85);
for j = 1:0.5:11
    var_list(23-2*j) = 10^(j-21);
end
for temp = 1:measurement_count
    irs_list(temp) = placeIRS([4,4,3],[21,21],[0.02,0.04],[0.01,0.02],4,"uniform",pieces(temp));
end
%%
uniform_nine_errors = MLE_list(loc,var_list,irs_list,100,9,0.3);
save('uniform_nine.mat', 'uniform_nine_errors');
%%
uniform_crlb_3x3 = CRLBList(loc,nb,irs_list,var_list);
save('crlb_uniform_nine.mat', 'uniform_crlb_3x3');
%%

var_list = 100:5:200;

figure();
p1 = semilogy(var_list,directed_nine_errors,'o-');
p1.Color = 'r';
hold on 
p2 = semilogy(var_list,directed_crlb_3x3,'o-');
p2.Color = 'b';
legend('RMSE Curve w/ 9 Measurements' ...
    ,'CRLB Bound for Random CRLB w/9 Measurements');
xlabel('10log(1/\sigma^2)');
ylabel('RMSE');
grid("on");
%% 16 Directed Error List 
clearvars;
close all;
rng(42,'twister');
loc = [2.5,2.5,0.85];
nb = [0,0,1];
measurement_count = 16;
var_list(1:21) = 0;
room = createRoom(4,4,3);
pieces = roomDivider(room,[4,4],0.85);

for j = 1:0.5:11
    var_list(23-2*j) = 10^(j-21);
end
for temp = 1:measurement_count
    irs_list(temp) = placeIRS([4,4,3],[21,21],[0.02,0.04],[0.01,0.02],4,"uniform",pieces(temp,:));
end
%%
directed_sixteen_errors = MLE_list(loc,var_list,irs_list,100,16,0.3);
save('directed_sixteen.mat', 'directed_sixteen_errors');
%%
load('directed_sixteen.mat')
directed_crlb_4x4 = CRLBList(loc,nb,irs_list,var_list);
save('crlb_sixteen.mat', 'directed_crlb_4x4');
%%
var_list = 100:5:200;
figure();
p1 = semilogy(var_list,directed_sixteen_errors,'o-');
p1.Color = 'r';
hold on 
p2 = semilogy(var_list,directed_crlb_4x4,'o-');
p2.Color = 'b';
legend('RMSE Curve w/ 16 Measurements' ...
    ,'CRLB Bound for Random CRLB w/16 Measurements');
xlabel('10log(1/\sigma^2)');
ylabel('RMSE');
grid("on");

%%
clearvars;
close all;
load('directed_nine_v3.mat');
load('directed_sixteen_v3.mat');
load('crlb_nine_v3.mat');
load('crlb_sixteen_v3.mat');
%% Plotting the Values
var_list = 100:5:200;
figure();

p1 = semilogy(var_list,directed_nine_errors,'o-');
p1.Color = 'b';
hold on 
p2 =semilogy(var_list,directed_crlb_3x3,'s--');
p2.Color = 'b';
hold on 
p3 = semilogy(var_list,directed_sixteen_errors,'o-');
p3.Color = 'r';
hold on
p4 = semilogy(var_list,directed_crlb_4x4,'s--');
p4.Color = 'r';
legend('RMSE for 9 Measurements' ...
    ,'CRLB for Random CRLB w/9 Measurements'...
    ,'RMSE for 16 Measurements' ...
    ,'CRLB for Random CRLB w/16 Measurements'...
    );
xlabel('10log(1/\sigma^2)');
ylabel('RMSE');
grid("on");

%%
create_data(9,100,0.85,0.05,"random",1e-20,"train");
create_data(16,100,0.85,0.05,"random",1e-20,"train");
create_data(9,100,0.85,0.05,"directed",1e-20,"train");
create_data(16,100,0.85,0.05,"directed",1e-20,"train");
create_data(9,100,0.85,0.05,"uniform",1e-20,"train");
create_data(16,100,0.85,0.05,"uniform",1e-20,"train");


%% test sets
var_list = [1e-10,1e-11,1e-12,1e-13,1e-14,1e-15,1e-16,1e-17,1e-18,1e-19,1e-20];
for i = var_list
    create_data(9,1000,0.85,0.1,"random",i,"test");
    create_data(16,1000,0.85,0.1,"random",i,"test");
    create_data(9,1000,0.85,0.1,"directed",i,"test");
    create_data(16,1000,0.85,0.1,"directed",i,"test");
    create_data(9,1000,0.85,0.1,"uniform",i,"test");
    create_data(16,1000,0.85,0.1,"uniform",i,"test");
end
%%
rmse_list_knn1 = KNNRegression(1,"directed",0.85,9,0.1,10^-14,500);
rmse_list_knn2 = KNNRegression(3,"directed",0.85,9,0.1,10^-14,500);
rmse_list_knn3 = KNNRegression(5,"directed",0.85,9,0.1,10^-14,500);
rmse_list_knn4 = KNNRegression(10,"directed",0.85,9,0.1,10^-14,500);

%%
rmse_list_nn1 = nnRegression([40,20,10,5],"directed",0.85,9,0.1,10^-14,500);
rmse_list_nn2 = nnRegression([40,20,10],"directed",0.85,9,0.1,10^-14,500);
rmse_list_nn3 = nnRegression([40,20],"directed",0.85,9,0.1,10^-14,500);
rmse_list_nn4 = nnRegression([40],"directed",0.85,9,0.1,10^-14,500);

%%
var_list = 100:10:200;
figure();
semilogy(var_list,rmse_list_knn1,'ro-');
hold on 
semilogy(var_list,rmse_list_knn2,'go-');
hold on 
semilogy(var_list,rmse_list_knn3,'bo-');
hold on 
semilogy(var_list,rmse_list_knn4,'ko-');
hold on 
semilogy(var_list,rmse_list_nn1,'rs-');
hold on 
semilogy(var_list,rmse_list_nn2,'gs-');
hold on 
semilogy(var_list,rmse_list_nn3,'bs-');
hold on 
semilogy(var_list,rmse_list_nn4,'ks-');
legend('KNN w/ k = 1', ...
       'KNN w/ k = 3', ...
       'KNN w/ K = 5', ...
       'KNN w/ k = 10', ...
       'NN with architecture [40,20,10,5]', ...
       'NN with architecture [40,20,10]', ...
       'NN with architecture [40,20]', ...
       'NN with architecture [40]');
grid on;
title('Comparison of KNN and NN models trained @$10log(\frac{1}{\sigma^2}) = 140dB$','Interpreter','latex')
xlabel('$10log(1/\sigma^2)$','Interpreter','latex');
ylabel('RMSE');
%%
[x10,y10] = knnrun("directed",0.85,9,0.1,10^-10,10^-10,500);
[x12,y12] = knnrun("directed",0.85,9,0.1,10^-12,10^-10,500);
[x14,y14] = knnrun("directed",0.85,9,0.1,10^-14,10^-10,500);
[x16,y16] = knnrun("directed",0.85,9,0.1,10^-16,10^-10,500);
[x18,y18] = knnrun("directed",0.85,9,0.1,10^-18,10^-10,500);

%%
figure();
semilogy(x10,y10,'-bo')
hold on
semilogy(x12,y12,'-rs')
hold on
semilogy(x14,y14,'-g^')
hold on
semilogy(x16,y16,'-c.')
hold on
semilogy(x18,y18,'-ko')
grid on;

xlabel('Number of Nearest Neighbours (k)')
ylabel('RMSE')
title('RMSE of KNN Regression with Changing K Tested @$10log(\frac{1}{\sigma^2}) = 100dB$','Interpreter','latex')
legend('Trained @$10log(\frac{1}{\sigma^2}) = 100dB$' ...
      ,'Trained @$10log(\frac{1}{\sigma^2}) = 120dB$' ...
      ,'Trained @$10log(\frac{1}{\sigma^2}) = 140dB$' ...
      ,'Trained @$10log(\frac{1}{\sigma^2}) = 160dB$' ...
      ,'Trained @$10log(\frac{1}{\sigma^2}) = 180dB$','Interpreter','latex');
