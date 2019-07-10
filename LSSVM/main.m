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
n_iter = 50;
accu = zeros(1, n_iter);
sens = zeros(1, n_iter);
spec = zeros(1, n_iter);
prec = zeros(1, n_iter);

model.kernel = 'linear';
%model.kernel = 'rbf';
%model.kernel = 'polynomial';

%% Importing the data set into the workspace

name_file = 'iris.dat';
n_attribute = 4;

%name_file = 'column_2C.dat';
%n_attribute = 6;

%name_file = 'dermatology.dat';
%n_attribute = 34;

%name_file = 'breast-cancer-wisconsin.dat';
%n_attribute = 10;

[data, classes] = load_data(name_file, n_attribute);
data = label_classes(data, classes, '2C');
data = normalize(data, n_attribute);

%% Remove column

%data(:,3) = [];
%data(:,3) = [];
%data(:,3) = [];
%data(:,3) = [];

%% Importing the random data set into the workspace

%n = 50;
%[data, classes] = data2D_2c(n);
%[data, classes] = data2D_and(n);

%% LSSVM Classifier

for i = 1:n_iter
    data_aux = shuffle_data(data);
    [X_tra, Y_tra, X_test, Y_test] = split_data(data_aux, classes, '2C');
    
    model = grid_search_lssvm(X_tra, Y_tra, model);
    model = train(X_tra, Y_tra, model);
    [accu(i), sens(i), spec(i), prec(i)] = test(X_test, Y_test, model);
end
toc;

%% Plot artificial

%color_map_iris(data, model);
%color_map_column(data, model);
%color_map_2c(n, data, model);
%color_map_and(n, data, model);

%% Displaying summarized results

fprintf('\tMean accuracy: %.2f\n', mean(accu)*100);
fprintf('\tMinimum accuracy: %.2f\n', min(accu)*100);
fprintf('\tMaximum accuracy: %.2f\n', max(accu)*100);
fprintf('\tStandard Deviation: %.2f\n', std(accu)*100);
fprintf('\tSensitivity: %.2f\n', mean(sens)*100);
fprintf('\tSpecificity: %.2f\n', mean(spec)*100);
fprintf('\tPrecision: %.2f\n', mean(prec)*100);
fprintf('\tTime: %f seconds\n\n', toc);

%% (un)Setting MATLAB Configurations

format;