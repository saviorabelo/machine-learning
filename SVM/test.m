function [accu, sens, spec, prec] = test(X_test, Y_test, model)

m_output = zeros(size(Y_test));
for i=1:size(X_test,1)
    m_output(i,:) = predict(model, X_test(i,:));
end
    
%% Confusion matrix

%figure(1)
%plotconfusion(Y_test',m_output','SVM');
[~,r]= confusion_aux.getMatrix(l_convert(Y_test),l_convert(m_output));
accu = r.Accuracy;
sens = r.Sensitivity;
spec = r.Specificity;
prec = r.Precision;

end