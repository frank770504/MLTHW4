function [ H E ] = NNetTest(x_te, y_te, Net, NNet)
%NNETTEST Summary of this function goes here
%   Detailed explanation goes here

Nhl = size(Net,2)-2;

Nte = size(x_te,1);

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

E = sum(y_te~=y_pre)/Nte;

end
