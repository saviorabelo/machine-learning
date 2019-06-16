function [] = color_map_3c(n, data, model)

i = 1;
j = 1;
k = 1;
for y = 0:0.005:1
    for x = 0:0.005:1
        
        output = predict([x y], model);

        if isequal(output, [0 0 1])
            color1(i,:) = [x y];
            i = i + 1;
        elseif isequal(output, [0 1 0])
            color2(j,:) = [x y];
            j = j + 1;
        elseif isequal(output, [1 0 0])
            color3(k,:) = [x y];
            k = k + 1;
        else
            fprintf('ERRO!\n')
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

plot(data(1:n,1), data(1:n,2), '*', 'Color', [0.00 0.45 0.74], ...
    'DisplayName', 'Classe 1')
plot(data(n+1:2*n,1), data(n+1:2*n,2), '*', 'Color', [0.31 0.31 0.31], ...
    'DisplayName', 'Classe 2')
plot(data(2*n+1:end,1), data(2*n+1:end,2), '*', 'Color', [0.60 0.20 0.00], ...
    'DisplayName', 'Classe 3')

title('Naive Bayes Color Map')
xlabel('Eixo x')
ylabel('Eixo y')
legend show
pause(0.05)
hold off
