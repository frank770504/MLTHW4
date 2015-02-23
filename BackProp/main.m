clc
clear all

trData = load('hw4_nnet_train.dat');
x_tr = trData(:,1:2);
y_tr = trData(:,end);

M = 40;

Nout = 1;

Ndim = size(x_tr,2);

Ntr = size(x_tr,1);

Ind = [Ndim M Nout];

Nhl = size(Ind,2)-2;

r = 0.1; eta = 0.1;

T = 50000;

%init weights
for i=1:Nhl+1,
    w = (rand(Ind(i+1),Ind(i)+1) - 0.5).*(r/0.5);
    NNet{i}.w = w;
end

% %create not duplicate random training set
% x_tr = [x_tr ones(Ntr,1) [1:Ntr]'];
% 
% for i=1:Ntr,
%    j = ceil(rand()*Ntr);
%    temp = x_tr(j,:);
%    x_tr(j,:) = x_tr(i,:);
%    x_tr(i,:) = temp;
% end

for t=1:T,
    n = ceil(rand()*Ntr);
    x = x_tr(n,:);
    for i=1:Nhl+1,
        w = NNet{i}.w;
        if (i-1)==0,
            in = [1 x]';
        else
            in = [1;NNet{i-1}.x];
        end
        s = w*in;
        x_next = tanh(s);
        NNet{i}.s = s;
        NNet{i}.x = x_next;
        NNet{i}.i = size(in,1);
        NNet{i}.j = size(x_next,1);
    end
    for i=Nhl+1:-1:1,
        y = y_tr(n);
        if i==Nhl+1,
            delta = -2 * (y - NNet{i}.x)*(1-NNet{i}.x^2)';
            NNet{i}.delta = delta;
        else
            delta_next = NNet{i+1}.delta;
            w_next = NNet{i+1}.w(:,2:end);
            delta_next_rep = repmat(delta_next,1,size(w_next,2));
            tanhs = NNet{i}.x;
            delta = sum((w_next.*delta_next_rep),1)'.*tanhs;
            NNet{i}.delta = delta;
        end
%         if i>1,
%             x_pre = [1;NNet{i-1}.x];
%         else
%             x_pre = [1;x_tr(n,:)'];
%         end
%         NNet{i}.w = NNet{i}.w - delta*x_pre'.*eta;
    end
    for i=1:Nhl+1,
        if i>1,
            x_pre = [1;NNet{i-1}.x];
        else
            x_pre = [1;x_tr(n,:)'];
        end
        delta = NNet{i}.delta;
        NNet{i}.w = NNet{i}.w - delta*x_pre'.*eta;        
    end
end

save NNet NNet