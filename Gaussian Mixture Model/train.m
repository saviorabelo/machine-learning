function [model] = train(X_tra, Y_tra, model)

    classes = unique(Y_tra, 'rows');
    model.classes = classes;
    
    for i = 1:size(classes, 1)
        [index, ~] = ismember(Y_tra, classes(i,:), 'rows');
        current_tra = X_tra(index,:);
        model.params{i} = gaussian_EM(current_tra, model);
    end

end