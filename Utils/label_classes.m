function [ data ] = label_classes( data, classes, problem_type )
%LABEL_CLASSES This function gives the data an appropriate class label
%
%   This version supports: 
%       - Binary labels. Ex: 1 or 0.
%       - (One-v-All) approach. Ex: for 3 classes, we have a label like [1 0 0].

    tmp_classes = unique(classes);

    if nargin < 3
        k = size(tmp_classes, 1);
    elseif strcmp(problem_type, '2C')
        k = 1;
    end

    i = size(data,2);
    label_vector = (i+1):(i+k);

    for j = 1 : k
        class_i = strcmp(classes, tmp_classes(j));
        data(class_i, label_vector(j)) = 1;
    end

end

