function [scores] = mdc(X_tra, Y_tra, X_test, Y_test)

%% Compute centroids
centroid_class=unique(Y_tra, 'rows');
k=length(centroid_class);

for i=1:k
    aux = centroid_class(i,:);
    [index, ~] = ismember(Y_tra, aux, 'rows');
    centroids(i,:)=mean(X_tra(index,:));
end

%% Test
k = size(centroids,1);
scores=0;
%Calculates the distance of the classes to the centroid
for i=1:size(X_test,1)
    target = centroid_class(1,:);
    min_dist = sum((X_test(i,:) - centroids(1,:)) .^ 2);
    for j=2:k
        dist = sum((X_test(i,:) - centroids(j,:)) .^ 2);
        if(dist < min_dist)
          min_dist = dist;
          target = centroid_class(j,:);
        end
    end
    %Checks whether the class is equal to the output
    output = Y_test(i,:);
    if isequal(target, output)
        scores = scores + 1;
    end
end

scores=scores*100/size(X_test,1);
