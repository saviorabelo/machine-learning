%% Setting useful MATLAB Configurations

clc;
close all;
clearvars;
format LONG;
warning('off');

%% Adding important paths into the workspace

addpath('../Datasets/');
addpath('../Utils/');

%% Setting variables - Initialization

tic;
n_iter = 10;
accu = zeros(1, n_iter);
sens = zeros(1, n_iter);
spec = zeros(1, n_iter);
prec = zeros(1, n_iter);
model.distribution = 'normal';
model.rej_ratio = [.04 .12 .24 .36 .48];
model.threshold = (.05: .05: .5);

%% Importing the data set into the workspace

%name_file = 'iris.dat';
%n_attribute = 4;

name_file = 'column_3C.dat';
n_attribute = 6;

%name_file = 'column_2C.dat';
%n_attribute = 6;

%name_file = 'dermatology.dat';
%n_attribute = 34;

%name_file = 'breast-cancer-wisconsin.dat';
%n_attribute = 10;

[data, classes] = load_data(name_file, n_attribute);
data = label_classes(data, classes);
data = normalize(data, n_attribute);

%% Remove column

%data(:,3) = [];
%data(:,3) = [];
%n = 50;

%% Importing the random data set into the workspace

%n = 50;
%[data, classes] = data2D_2c(n);
%[data, classes] = data2D_and(n);
%[data, classes] = data2D_3c(n);

%% Bayes with reject option

for i = 1:n_iter
    data_aux = shuffle_data(data);
    [X_tra, Y_tra, X_test, Y_test] = split_data(data_aux, classes);
    
    model = train(X_tra, Y_tra, model);
    model = rejectOption(X_tra, Y_tra, model);
    
    [valores, accu(i), sens(i), spec(i), prec(i)] = test(X_test, Y_test, model);
    valores_iter(:,:,i) = valores;
    
end
toc;

%% Plot artificial

%color_map_2c(n, data, model);
%color_map_and(n, data, model);
%color_map_3c(n, data, model);

%% Displaying summarized results

fprintf('\tMean accuracy: %.2f\n', mean(accu)*100);
fprintf('\tMinimum accuracy: %.2f\n', min(accu)*100);
fprintf('\tMaximum accuracy: %.2f\n', max(accu)*100);
fprintf('\tStandard Deviation: %.2f\n', std(accu)*100);
fprintf('\tSensitivity: %.2f\n', mean(sens)*100);
fprintf('\tSpecificity: %.2f\n', mean(spec)*100);
fprintf('\tPrecision: %.2f\n', mean(prec)*100);
fprintf('\tTime: %f seconds\n\n', toc);

%% Ploting results for the report

valores_iter = mean(valores_iter(:,:,:), 3);
figure(1)
plot(valores_iter(:,4), valores_iter(:,3), '-o')
%figure(2)
%boxplot((accu)*100, 'Color', 'k', 'Symbol', 'b+', 'PlotStyle', 'compact');

%% (un)Setting MATLAB Configurations

format;