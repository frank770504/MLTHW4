clc
clear all
close all

trData = load('hw4_nnet_train.dat');
x_tr = trData(:,1:2);
y_tr = trData(:,end);

teData = load('hw4_nnet_test.dat');
x_te = teData(:,1:2);
y_te = teData(:,end);

M = 6;

Nout = 1;

Ndim = size(x_tr,2);

Ntr = size(x_tr,1);

Nte = size(x_te,1);

Net = [Ndim M Nout];

r = 0.1; eta = 0.1;

T = 50000;

NNet = NNetTrain(x_tr, y_tr, Net, r, eta, T);

[H E] = NNetTest(x_te, y_te, Net, NNet);

%yy = [y_te H];

figure(1)
hold on
points = x_te;
for i=1:Nte,
    if y_te(i)>0,
        plot(points(i,1), points(i,2),'+');
    else
        plot(points(i,1), points(i,2), 'rx');
    end
end

figure(2)
hold on
points = x_te;
for i=1:Nte,
    if H(i,2)>0,
        plot(points(i,1), points(i,2),'+');
    else
        plot(points(i,1), points(i,2), 'rx');
    end
end