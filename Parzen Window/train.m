function [ model ] = train(X_tra, Y_tra, model)
    
    classes = unique(Y_tra, 'rows');
    model.classes = classes;
    k = length(classes);
    priori = cell(k, 1);
    
    for i = 1:k
        aux = classes(i,:);
        [index, ~] = ismember(Y_tra, aux, 'rows');
        current_train = X_tra(index,:);
        model.train{i} = current_train;
        priori{i} = size(current_train,1) / size(X_tra,1);
    end
    
    model.priori = priori;
end