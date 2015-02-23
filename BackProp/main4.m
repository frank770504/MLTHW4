clc
clear all
close all

trData = load('hw4_nnet_train.dat');
x_tr = trData(:,1:2);
y_tr = trData(:,end);

teData = load('hw4_nnet_test.dat');
x_te = teData(:,1:2);
y_te = teData(:,end);

Nout = 1;

Ndim = size(x_tr,2);

Ntr = size(x_tr,1);

Nte = size(x_te,1);

Eout_col = {};
eta =[0.001 0.01 0.1 1 10];
for cc=2:3,
    tic
    M = 3;
    Net = [Ndim M Nout];

    r = 0.1;

    T = 30000;
    iter = 500;
    E_col = zeros(iter,1);
    fprintf('Calculating eta = %f\n', eta(cc));
    parfor i=1:iter,
        NNet = NNetTrain(x_tr, y_tr, Net, r, eta(cc), T);
        [H E] = NNetTest(x_te, y_te, Net, NNet);
        E_col(i) = E;
    end
    %fprintf('\n');
    Eout_col{cc}.eta = eta(cc);
    Eout_col{cc}.Eout = mean(E_col);
    toc
end
