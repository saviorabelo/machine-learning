function [ X_training, Y_training, X_test, Y_test ] = split_data( data, classes )
%SPLIT_DATA splits the presented data set in order to get the input data and
% its respectives outputs, so the network can fully work without the need of
% filtering the data set every time that it needs only either the input data
% or the output. This is a general function, which works for any data set.
% It works as follows:
%       1. Defines the percent of both training and testing phases.
%       2. Uses these percents to get the number of patterns for each phase.
%       3. Filters the data set and split it into four sets:
%               - Training: input (X) and output (Y).
%               - Testing: input (X) and output (Y).
%       4. Inserts the bias (column vector) onto the two input sets above.
%
% Example:
%     [ X_training, Y_training, X_test, Y_test ] = split_data( data );
%
% Example:
%     [ X_training, Y_training, X_test, Y_test ] = split_data( data, 3 );
%

    if iscell(classes)
        n_classes = length(unique(classes));
    else
        n_classes = length(unique(classes, 'rows'));
    end
    
    if n_classes < 3
        n_classes = 1;
    end
    
%     if nargin < 2
%         n_classes = 1;
%     end
    
    n_patterns = size(data, 1);
    n_features = size(data, 2);
    patt_bound = n_features - n_classes;

    % Setting the size of the training set. The trial (test) set is defined
    % by 100 - train_percent.
    train_percent = 80;

    % Getting the number of training patterns.
    bound = floor(n_patterns * train_percent/100);

    % Creating vectors to filter the data set.
    train_set = 1 : bound;
    trial_set = bound + 1 : n_patterns;

    % Filtering the data set for training purposes
    X_training = data(train_set, 1 : patt_bound);
    Y_training = data(train_set, patt_bound + 1 : n_features);

    % Filtering the data set for test purposes
    X_test = data(trial_set, 1 : patt_bound);
    Y_test = data(trial_set, patt_bound + 1 : n_features);
    

%     % Inserting the bias for each training sample
%     bias = -1 * ones(bound, 1);
%     X_training = [bias X_training];
% 
%     % Inserting the bias for each test sample
%     bias = -1 * ones(n_patterns - bound, 1);
%     X_test = [bias X_test];

end
