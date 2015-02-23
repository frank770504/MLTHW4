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
M=[1 6 11 16 21];
for cc=1:size(M,2),
    tic
    Net = [Ndim M(cc) Nout];

    r = 0.1; eta = 0.1;

    T = 50000;
    iter = 10;
    E_col = zeros(iter,1);
    fprintf('Calculating M = %d\n', M(cc));
    parfor i=1:iter,
        NNet = NNetTrain(x_tr, y_tr, Net, r, eta, T);
        [H E] = NNetTest(x_te, y_te, Net, NNet);
        E_col(i) = E;
    end
    %fprintf('\n');
    Eout_col{cc}.M = M(cc);
    Eout_col{cc}.Eout = mean(E_col);
    toc
end
