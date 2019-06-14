function [data, classes] = data2D_3c(n)
%Artificial data set with three classes

aux = 0.2;

%Pattern 1
x1 = ((aux).*rand(n, 1) + 0.2);
y1 = ((aux).*rand(n, 1) + 0.2);

%Pattern 2
x2 = ((aux).*rand(n, 1) + 0.4);
y2 = ((aux).*rand(n, 1) + 0.6);

%Pattern 3
x3 = ((aux).*rand(n, 1) + 0.6);
y3 = ((aux).*rand(n, 1) + 0.2);

data = [x1 y1 ones(n,1).*[0 0 1];
        x2 y2 ones(n,1).*[0 1 0];
        x3 y3 ones(n,1).*[1 0 0]];

classes = [ones(n,1).*[0 0 1];
        ones(n,1).*[0 1 0];
        ones(n,1).*[1 0 0]];
