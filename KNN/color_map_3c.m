function [] = color_map_2c(k, X_tra, Y_tra)


[index, ~] = ismember(Y_tra, [0 0 1], 'rows');
classes1 = X_tra(index,:);

[index, ~] = ismember(Y_tra, [0 1 0], 'rows');
classes2 = X_tra(index,:);

[index, ~] = ismember(Y_tra, [1 0 0], 'rows');
classes3 = X_tra(index,:);

%% Calc

color1 = [];
color2 = [];
color3 = [];
i = 1;
j = 1;
l = 1;
for y = 0:0.005:1
    for x = 0:0.005:1
        
        output = predict(k, X_tra, Y_tra, [y x]);

        if isequal(output, [0 0 1])
            color1(i,:) = [y x];
            i = i + 1;
        elseif isequal(output, [0 1 0])
            color2(j,:) = [y x];
            j = j + 1;
        elseif isequal(output, [1 0 0])
            color3(l,:) = [y x];
            l = l + 1;
        else
            fprintf('Erro!\n')
        end
    end
end

%% Plot

figure(1)
hold on

plot(color1(:,1), color1(:,2), '.', 'Color', [0.80 0.88 0.97], ...
    'LineStyle', '-', 'LineWidth', 3.0, 'HandleVisibility', 'off')
plot(color2(:,1), color2(:,2), '.', 'Color', [0.80 0.80 0.80], ...
    'LineStyle', '-', 'LineWidth', 3.0, 'HandleVisibility', 'off')
plot(color3(:,1), color3(:,2), '.', 'Color', [0.95 0.87 0.73], ...
    'LineStyle', '-', 'LineWidth', 3.0, 'HandleVisibility', 'off')

plot(classes1(:,1), classes1(:,2), '*', 'Color', [0.00 0.45 0.74], ...
    'DisplayName', 'Disk Hernia')
plot(classes2(:,1), classes2(:,2), '*', 'Color', [0.31 0.31 0.31], ...
    'DisplayName', 'Spondylolisthesis')
plot(classes3(:,1), classes3(:,2), '*', 'Color', [0.60 0.20 0.00], ...
    'DisplayName', 'Normal')

title('KNN Color Map')
xlabel('Lumbar lordosis angle')
ylabel('Sacral slope')
legend show
pause(0.05)
hold off
