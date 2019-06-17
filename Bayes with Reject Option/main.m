%% Setting useful MATLAB Configurations

clc;
close all;
clearvars;
format LONG;
warning('off');

%% Adding important paths into the workspace

addpath('../Utils/');
addpath('../Datasets/');

%% Setting variables - Initialization

tic;
n_iter = 50;
accu = zeros(1, n_iter);
sens = zeros(1, n_iter);
spec = zeros(1, n_iter);
prec = zeros(1, n_iter);
model.distribution = 'normal';
model.rej_ratio = [.04 .12 .24 .36 .48];
model.threshold = (.05: .05: .5);

%% Importing the data set into the workspace

name_file = 'iris.dat';
n_attribute = 4;

%name_file = 'column_3C.dat';
%n_attribute = 6;

%name_file = 'column_2C.dat';
%n_attribute = 6;

%name_file = 'dermatology.dat';
%n_attribute = 34;

%name_file = 'breast-cancer-wisconsin.dat';
%n_attribute = 10;

[data, classes] = load_data(name_file, n_attribute);
data = label_classes(data, classes, '2C');
data(:,end) = data(:,end) + 1;
data = normalize(data, n_attribute);

%% Importing the random data set into the workspace

%n = 50;
%[data, classes] = data2D_2c(n);
%data(:,end) = data(:,end) + 1;
%[data, classes] = data2D_and(n);
%[data, classes] = data2D_3c(n);

%% Bayes with reject option

for i = 1:n_iter
    data_aux = shuffle_data(data);
    [X_tra, Y_tra, X_test, Y_test] = split_data(data_aux, classes);
    
    model = train(X_tra, Y_tra, model);
    model = rejectOption(X_tra, Y_tra, model);
    
    [answer] = test(X_test, Y_test, model);
    answer_iter(:,:,i) = answer;
    
end
toc;

answer_iter = mean(answer_iter(:,:,:), 3);
accu = answer_iter(:,3);
rejection = answer_iter(:,4);

%% Displaying summarized results

fprintf('\tMean accuracy: %.2f\n', mean(accu)*100);
fprintf('\tStandard deviation accuracy: %.2f\n', std(accu)*100);
fprintf('\tMean rejection: %.2f\n', mean(rejection)*100);
fprintf('\tStandard deviation rejection: %.2f\n', std(rejection)*100);
fprintf('\tTime: %f seconds\n\n', toc);

%% Ploting results for the report

%figure(1)
%plot(rejection, accu, '-o')
%title('Vertebral Column')
%title('Iris')
%xlabel('Reject rate (x100)')
%ylabel('Accuracy (x100)')
%figure(2)
%boxplot((accu)*100, 'Color', 'k', 'Symbol', 'b+', 'PlotStyle', 'compact');

%% (un)Setting MATLAB Configurations

format;