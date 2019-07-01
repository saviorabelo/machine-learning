function [model] = grid_search_lssvm(X_tra, Y_tra, model)

[m, ~] = size(X_tra);
gammas = 2 .^ (1 : 15);

k_grid = 5;
slice = m/k_grid;
grid_acuracy = zeros(1, length(gammas));

for i = 1:length(gammas)
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
    
        %LS-SVM
        model.gamma = gammas(i);
        model = train(X_tra_aux, Y_tra_aux, model);
        [scores(j),~,~,~] = test(X_test_aux, Y_test_aux, model);
        
    end
    grid_acuracy(i) = mean(scores);
end

%Index of the best element
[~, index] = max(grid_acuracy);
model.gamma = gammas(index);

end