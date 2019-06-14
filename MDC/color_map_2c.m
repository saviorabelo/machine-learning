function [] = color_map_2c(n, data, centroids)

color1 = [];
color2 = [];
i = 1;
j = 1;
for y = 0:0.005:1
    for x = 0:0.005:1
        
        dist1 = sum(([x y] - centroids(1,:)) .^ 2);
        dist2 = sum(([x y] - centroids(2,:)) .^ 2);

        if dist1 < dist2
            color1(i,:) = [y x];
            i = i + 1;
        else
            color2(j,:) = [y x];
            j = j + 1;
        end
    end
end

%% Plot

figure(1)
hold on

plot(color1(:,1), color1(:,2), '.', 'Color', [0.80 0.80 0.80], ...
    'LineStyle', '-', 'LineWidth', 3.0, 'HandleVisibility', 'off')
plot(color2(:,1), color2(:,2), '.', 'Color', [0.80 0.88 0.97], ...
    'LineStyle', '-', 'LineWidth', 3.0, 'HandleVisibility', 'off')

plot(data(1:n,1), data(1:n,2), '*', 'Color', [0.00 0.45 0.74], ...
    'DisplayName', 'Classe 1')
plot(data(n+1:end,1), data(n+1:end,2), '*', 'Color', [0.31 0.31 0.31], ...
    'DisplayName', 'Classe 2')

title('DMC Color Map')
xlabel('Eixo x')
ylabel('Eixo y')
legend show
pause(0.05)
hold off
