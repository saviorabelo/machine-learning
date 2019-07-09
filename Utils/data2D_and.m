function [data, classes] = data2D_and(n)
%Artificial data set with two classes

aux = 0.1;

%Pattern 1
x1 = ((aux).*rand(n, 1) + 0.2);
y1 = ((aux).*rand(n, 1) + 0.2);

%Pattern 2
x2 = ((aux).*rand(n, 1) + 0.2);
y2 = ((aux).*rand(n, 1) + 0.6);

%Pattern 3
x3 = ((aux).*rand(n, 1) + 0.6);
y3 = ((aux).*rand(n, 1) + 0.2);

%Pattern 4
x4 = ((aux).*rand(n, 1) + 0.6);
y4 = ((aux).*rand(n, 1) + 0.6);

data = [x1 y1 ones(n,1);
    x2 y2 ones(n,1);
    x3 y3 ones(n,1);
    x4 y4 -ones(n,1)];

classes = [ones(3*n,1); -ones(n,1)];



