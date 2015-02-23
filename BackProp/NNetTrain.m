function [ NNet ] = NNetTrain(  x_tr, y_tr, Net, r, eta, T )
%NNETTRAIN Summary of this function goes here
%   Detailed explanation goes here

Nhl = size(Net,2)-2;
Ntr = size(x_tr,1);

%init weights
for i=1:Nhl+1,
    w = (rand(Net(i+1),Net(i)+1) - 0.5).*(r/0.5);
    NNet{i}.w = w;
end

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
            tanhs_der = (1 - tanhs.^2);
            delta = sum((w_next.*delta_next_rep),1)'.*tanhs_der;
            NNet{i}.delta = delta;
        end
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


end

