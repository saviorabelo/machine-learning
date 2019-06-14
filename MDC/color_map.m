function [] = color_map_3c(n, data, classes, centroids)


[index, ~] = ismember(classes, [0 0 1], 'rows');
classes1 = data(index,:);

[index, ~] = ismember(classes, [0 1 0], 'rows');
classes2 = data(index,:);

[index, ~] = ismember(classes, [1 0 0], 'rows');
classes3 = data(index,:);

%% Calc

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

plot(classes1(:,1), classes1(:,2), '*', 'Color', [0.00 0.45 0.74], ...
    'DisplayName', 'A')
plot(classes2(:,1), classes2(:,2), '*', 'Color', [0.31 0.31 0.31], ...
    'DisplayName', 'B')
plot(classes3(:,1), classes3(:,2), '*', 'Color', [0.60 0.20 0.00], ...
    'DisplayName', 'C')

title('MDC Color Map')
xlabel('Eixo x')
ylabel('Eixo y')
legend show
pause(0.05)
hold off
