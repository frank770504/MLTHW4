clc
clear all
load NNet.mat

teData = load('hw4_nnet_test.dat');
x_te = teData(:,1:2);
y_te = teData(:,end);

M = 6;

Nout = 1;

Ndim = size(x_te,2);

Nte = size(x_te,1);

Ind = [Ndim M Nout];

Nhl = size(Ind,2)-2;

r = 0.1; eta = 0.1;

T = 50000;

H = [];
NNetTeCol = {};
for n=1:Nte,
    x = x_te(n,:);
    NNetTe = {};
    for i=1:Nhl+1,
        w = NNet{i}.w;
        if (i-1)==0,
            in = [1 x]';
        else
            in = [1;NNetTe{i-1}.x];
        end
        s = w*in;
        x_next = tanh(s);
        NNetTe{i}.s = s;
        NNetTe{i}.x = x_next;
    end
    NNetTeCol{n} = NNetTe;
    H = [H;NNetTe{Nhl+1}.x sign(NNetTe{Nhl+1}.x)];
end

y_pre = H(:,2);

Eout = sum(y_te~=y_pre)/Nte;