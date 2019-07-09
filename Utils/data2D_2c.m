function [data, classes] = data2D_2c(n)
%Artificial data set with two classes

aux = 0.2;

%Pattern 1
x1 = ((aux).*rand(n, 1) + 0.2);
y1 = ((aux).*rand(n, 1) + 0.2);

%Pattern 2
x2 = ((aux).*rand(n, 1) + 0.6);
y2 = ((aux).*rand(n, 1) + 0.6);

data = [x1 y1 ones(n,1);
    x2 y2 -ones(n,1)];

classes = [ones(n,1); -ones(n,1)];
