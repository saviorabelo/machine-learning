function [] = color_map_3c(n, data, centroids)

i = 1;
j = 1;
k = 1;
for y = 0:0.005:1
    for x = 0:0.005:1
        
        dist1 = sum(([x y] - centroids(1,:)) .^ 2);
        dist2 = sum(([x y] - centroids(2,:)) .^ 2);
        dist3 = sum(([x y] - centroids(3,:)) .^ 2);
        
        [smaller, index] = min([dist1, dist2, dist3]);

        if index == 1
            color1(i,:) = [x y];
            i = i + 1;
        elseif index == 2
            color2(j,:) = [x y];
            j = j + 1;
        elseif index == 3
            color3(k,:) = [x y];
            k = k + 1;
        end
    end
end

%% Plot

figure(2)
hold on

plot(color1(:,1), color1(:,2), '.', 'Color', [0.80 0.88 0.97], ...
    'LineStyle', '-', 'LineWidth', 3.0, 'HandleVisibility', 'off')
plot(color2(:,1), color2(:,2), '.', 'Color', [0.80 0.80 0.80], ...
    'LineStyle', '-', 'LineWidth', 3.0, 'HandleVisibility', 'off')
plot(color3(:,1), color3(:,2), '.', 'Color', [0.95 0.87 0.73], ...
    'LineStyle', '-', 'LineWidth', 3.0, 'HandleVisibility', 'off')

plot(data(1:n,1), data(1:n,2), '*', 'Color', [0.00 0.45 0.74], ...
    'DisplayName', 'Classe 1')
plot(data(n+1:end,1), data(n+1:end,2), '*', 'Color', [0.31 0.31 0.31], ...
    'DisplayName', 'Classe 2')
plot(data(2*n+1:end,1), data(2*n+1:end,2), '*', 'Color', [0.60 0.20 0.00], ...
    'DisplayName', 'Classe 3')

title('Color Map MDC')
xlabel('Eixo x')
ylabel('Eixo y')
legend show
pause(0.05)
hold off
