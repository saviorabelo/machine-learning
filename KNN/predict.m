function output_classes = predict(k, X_tra, Y_tra, pattern)

%initialization
n = size(X_tra,1);
ed = zeros(1, n);
output = zeros(k, size(Y_tra,2));

for j=1:n
    %Calc euclidean distances
    %ed(i,j) = norm(pattern - X_tra(j,:)); %MATLAB
    ed(j) = sqrt(sum((pattern - X_tra(j,:)).^2));
end
[~, index] = sort(ed);
knn = index(:,1:k); 
for j=1:k %length k
    output(j,:) = Y_tra(knn(j),:);
end

%Mode
if k > 1
    output_aux = mode(output); %get the majority vote
    if sum(output_aux) == 0
        output_classes = output(1,:);
    else
        output_classes = output_aux;
    end
else
    output_classes = output;
end