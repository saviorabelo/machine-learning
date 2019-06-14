function [ classes_aux ] = l_convert( classes )
    
    tmp_classes = unique(classes, 'rows');
    k = size(tmp_classes, 1);
    m = size(classes, 1);
    classes_aux = zeros(m,1);

    for j = 1 : m
        for i=1:k
            if isequal(classes(j,:),tmp_classes(i,:))
                classes_aux(j) = i;
                break;
            end
        end
    end

end

