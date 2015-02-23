clc
clear all
close all

trData = load('hw4_knn_train.dat');
x_tr = trData(:,1:2);
y_tr = trData(:,end);
Ntr = size(x_tr,1);

teData = load('hw4_knn_test.dat');

x_te = teData(:,1:2);
y_te = teData(:,end);

% x_te = x_tr;
% y_te = y_tr;

Nte = size(x_te,1);

k = 7;

h = zeros(Nte,1);
for i=1:Nte,
    y = y_tr;
    x = x_te(i,:);
    X = repmat(x,Ntr,1);
    dist = sqrt(sum((x_tr - X).^2,2));
    dist = [dist [1:Ntr]'];
    sort_dist = sortrows(dist,1);
    ind = sort_dist(1:5,2);
    citizen = y(ind);
    h(i) = sign(sum(citizen));
end

Eout = sum(h~=y_te)/Nte;


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
    if h(i)>0,
        plot(points(i,1), points(i,2),'+');
    else
        plot(points(i,1), points(i,2), 'rx');
    end
end

figure(3)
hold on
points = x_tr;
for i=1:Ntr,
    if y_tr(i)>0,
        plot(points(i,1), points(i,2),'+');
    else
        plot(points(i,1), points(i,2), 'rx');
    end
end