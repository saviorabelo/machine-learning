function [best_k] = grid_search_gmm(X_tra, Y_tra, model)

[m, ~] = size(X_tra);
k = (2:10);

k_grid = 5;
slice = m/k_grid;
grid_acuracy = zeros(1, length(k));

for i = 1:length(k)
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
    
        %Parzen Window
        model.k = k(i);
        model = train(X_tra_aux, Y_tra_aux, model);
        [scores(j),~,~,~] = test(X_test_aux, Y_test_aux, model);
        
    end
    grid_acuracy(i) = mean(scores);
end

%Index of the best element
[~, index] = max(grid_acuracy);
best_k = k(index);

end