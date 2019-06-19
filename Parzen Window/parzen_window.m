function [answer] = parzen_window(pattern, X_tra, h)

[m, n] = size(X_tra);
aux = ((2*pi)^(n/2)) * h;
x = pattern;
sum = 0;
for i = 1:m
    xi = X_tra(i,:);
    u = (xi - x)*(xi - x)';
    gaussian = (1/aux) * exp(-u/(2*h^2));
    sum = sum + gaussian;
end
answer = sum / m;
