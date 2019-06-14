function [accu, sens, spec, prec] = train(k, X_tra, Y_tra, X_test, Y_test)

%initialization
output_matrix = zeros(size(Y_test));

for i=1:size(X_test,1)
    output_matrix(i,:) = predict(k, X_tra, Y_tra, X_test(i,:));
end

% Confusion matrix
%figure(1)
%plotconfusion(m_target',m_output','KNN');
[~,r]= confusion_aux.getMatrix(l_convert(Y_test),l_convert(output_matrix));
%C = confusion(l_convert(m_target),l_convert(m_output));
 accu = r.Accuracy;
 sens = r.Sensitivity;
 spec = r.Specificity;
 prec = r.Precision;
%scores = scores * 100 / size(X_test,1);

