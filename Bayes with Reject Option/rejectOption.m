function model = rejectOption(X_tra, Y_tra, model)

optimumParams = [];
for wr = model.rej_ratio
    table = [];
    for t = model.threshold
        
        predictions = predict_train(X_tra, Y_tra, model);
        predictions.classes(predictions.prob < 0.5 + t) = 0;

        if any(predictions.classes == 0)
            idx = (predictions.classes == 0);
            rejection = sum(idx) / size(X_tra,1);
            aux = l_convert(Y_tra)';
            error = sum(aux(~idx) ~= predictions.classes(~idx)) / ...
                (size(Y_tra,1) - sum(idx));
        else
            rejection = 0;
            error = sum(l_convert(Y_tra)' ~= predictions.classes) / size(Y_tra,1);
        end

        risk = error + wr * rejection; %Chow
        table = [table; t risk];
    end

    [value, ~] = min(table(:, 2));
    optimumParams = [optimumParams, value];
end
model.optimumParamsT = optimumParams;
