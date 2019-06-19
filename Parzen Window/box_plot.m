clc;clear;
load('results_database.mat')

labels = {'Iris', 'Column 3C', 'Column 2C', 'Dermatologia', 'Câncer', 'Artificial'};
scores = [iris'; column_3C'; column_2C'; derma'; cancer'; artificial'];
aux = [ones(50); 2*ones(50); 3*ones(50);...
    4*ones(50);4*ones(50);6*ones(50)];

figure
boxplot(scores, aux,'LabelOrientation','horizontal',...
    'Symbol','o','BoxStyle','outline', 'Widths',0.5,...
    'PlotStyle','traditional')
xlabel('Databases')
ylabel('Accuracy')
title('Box Plot')
set(gca,'XTickLabel',labels)