function model = rejectOption(X_tra, Y_tra, model)

model.optimumParams.t = [];
model.optimumParams.wr = [];

for wr = model.rej_ratio
    tabela = [];
    for t = model.threshold
        
        predictions = test(X_tra, Y_tra, model);
        predictions.classes(predictions.prob < 0.5 + t) = 0;

        if any(predictions.classes == 0)
            idx = (predictions.classes == 0);
            rejection = sum(idx) / size(X_tra,1);
            aux = l_convert(Y_tra)';
            error = sum(aux(~idx) ~= predictions.classes(~idx)) /...
                (size(Y_tra,1) - sum(idx));
        else
            rejection = 0;
            error = sum(l_convert(Y_tra)' ~= predictions.classes) / size(Y_tra,1);
        end

        chow = error + wr * rejection;
        tabela = [tabela; t chow];
    end

    [~, idx] = min(tabela(:, 2));
    model.optimumParams.t = [model.optimumParams.t, tabela(idx, 1)];
    model.optimumParams.wr = [model.optimumParams.wr, wr];
end