function [params] = grid_search_svm(X_tra, Y_tra, params)

    switch params.kernel
        case 'linear'
            params = gs_linear(X_tra, Y_tra, params);
        case 'rbf'
            params = gs_rbf(X_tra, Y_tra, params);
        case 'polynomial'
            params = gs_linear(X_tra, Y_tra, params);
        otherwise
                error([type ' is not a valid kernel!'])
    end
    
end

function [params] = gs_linear(X_tra, Y_tra, params)

[m, ~] = size(X_tra);
constraint = 2 .^ (1 : 10);

k_grid = 5;
slice = m/k_grid;
grid_acuracy = zeros(1, length(constraint));

for i = 1:length(constraint)
    scores = zeros(1, k_grid);
    %Cross validation
    for j = 1:k_grid
        %Set range
        a = (j-1)*slice+1;
        b = j*slice;
        
        %Divide between training and test
        X_tra_aux = [X_tra(1:a-1,:) ; X_tra(b+1:m,:)];
        Y_tra_aux = [Y_tra(1:a-1,:) ; Y_tra(b+1:m,:)];
        X_test_aux = X_tra(a:b,:);
        Y_test_aux = Y_tra(a:b,:);
    
        %SVM
        params.constraint = constraint(i);
        model = train(X_tra_aux, Y_tra_aux, params);
        [scores(j),~,~,~] = test(X_test_aux, Y_test_aux, model);
        
    end
    grid_acuracy(i) = mean(scores);
end

%Index of the best element
[~, index] = max(grid_acuracy);
params.constraint = constraint(index);

end

function [params] = gs_rbf(X_tra, Y_tra, params)

[m, ~] = size(X_tra);
constraints = 2 .^ (1 : 10);
sigmas = 2 .^ (-3 : 3);

k_grid = 5;
slice = m/k_grid;
grid_acuracy = zeros(length(constraints), length(sigmas));

for i = 1:length(constraints)
    for l = 1:length(sigmas)
        scores = zeros(1, k_grid);
        %Cross validation
        for j = 1:k_grid
            %Set range
            a = (j-1)*slice+1;
            b = j*slice;

            %Divide between training and test
            X_tra_aux = [X_tra(1:a-1,:) ; X_tra(b+1:m,:)];
            Y_tra_aux = [Y_tra(1:a-1,:) ; Y_tra(b+1:m,:)];
            X_test_aux = X_tra(a:b,:);
            Y_test_aux = Y_tra(a:b,:);

            %SVM
            params.constraint = constraints(i);
            params.sigma = sigmas(l);
            model = train(X_tra_aux, Y_tra_aux, params);
            [scores(j),~,~,~] = test(X_test_aux, Y_test_aux, model);

        end
        grid_acuracy(i,l) = mean(scores);
    end
end

%Index of the best element
[~, index] = max(grid_acuracy(:));
[I_row, I_col] = ind2sub(length(grid_acuracy), index);

params.constraint = constraints(I_row);
params.sigma = sigmas(I_col);

end