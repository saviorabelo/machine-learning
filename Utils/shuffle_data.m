function [data] = shuffle_data(data)

    n_patterns = size(data, 1);
    index = randperm(n_patterns);
    data = data(index, :);
end
