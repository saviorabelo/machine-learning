%% Setting useful MATLAB Configurations

clc;
close all;
clearvars;
format LONG;
warning('off');

%% Adding important paths into the workspace

addpath('/Images/');

%% Setting variables - Initialization

model.k = 2;
model.maxiters = 100;
model.threshold = 1e-10;

%% Importing the data set into the workspace

img = imread('japao.png');
img_gmm = zeros(size(img));
img_d = im2double(img);
[m, n, o] = size(img_d);
data = reshape(img_d, m*n, o);

%% Gaussian Mixture Model (GMM)

model.params = gaussian_EM(data, model);
[m_output] = test_segmentation(data, model);


%% (un)Setting MATLAB Configurations

format;