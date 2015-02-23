clc
clear all

Data = load('hw4_kmeans_train.dat');


Ndim = size(Data,2);

Ndata = size(Data,1);

k = 10;

Ein = zeros(500,1);

for sand=1:500,

    Mus = rand(k,Ndim);

    y = zeros(Ndata,1);
    while(1)
        yold = y;
        for i=1:Ndata,
            x = Data(i,:);
            X = repmat(x,k,1);
            dist = sqrt(sum((Mus - X).^2,2));
            [val ind] = min(dist);
            y(i) = ind;
        end

        for i=1:k,
            ind = find(y==i);
            mu = mean(Data(ind,:),1);
            Mus(i,:) = mu;
        end

        if sum(yold~=y)==0,
            D = zeros(k,1);
            for i=1:k,
                ind = find(y==i);
                mu = Mus(i,:);
                x = Data(ind,:);
                Nx = size(x,1);
                Mu = repmat(mu,Nx,1);
                D(i) = sum(sum((Mu - x).^2,2));
            end
            Ein(sand) = sum(D)/Ndata;
            break; 
        end   
    end
end

Ein_avg = mean(Ein);