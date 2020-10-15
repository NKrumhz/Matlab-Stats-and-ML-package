function [cluster, centr] = kmeans(X, k)


[numx, dimx] = size(X);

sampleIds = randsample(1:N, k, false);
U = data(sampleIds, :);
labels_u = zeros(numx,1);

while true
    for i = 1:numx
        x = data(i, :);
        % check label
        label = 0;
        dist = 0;
        for j = 1:k
            tmp_dist = sum((x-U(j, :)).^2);
            if label ==0 || tmp_dist < dist
                label = j;
                dist = tmp_dist;
            end
        end
        if labels_u(i) ~= label
            stop = false;
        end
        labels_u(i) = label;
    end
    if stop ==true
        break;
    end
    %update U
    new_U = zeros(K,dimx);
    labels_count = zeros(K,1);
    for i = 1:N
        label = labels_u(i);
        new_U(label, :) = new_U(label, :) +X(i, :);
        labels_count(label) = labels_count(label) + 1;
    end
    for i = 1:k
        new_U(i, :) = new_U(i, :)/labels_count(i);
    end
    U = new_U;
end
centr = 0;
for i = 1:numx
    label = labels_u(i);
    u = U(label, :);
    centr = centr + norm(x-u);
end
centr = centr/numx;
end