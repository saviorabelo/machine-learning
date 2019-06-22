function l = get_likelihood(model)

    %get likelihood
    l = 0;
    for j = 1:model.k
        l = l + sum(model.totals{j});
    end