function [r1, r2] = featureMatching(p1, fd1, p2, fd2, r)
    n = length(p1);
    m = length(p2);
    result1 = [];
    result2 = [];
    for i = 1 : n
        t = zeros(n,2);
        for j = 1 : m
            t(j,1) = j;
            X = fd1(i,:)*1.0 - fd2(j,:)*1.0;
            t(j,2) = sum(X(:).^2);
        end
        t = sortrows(t, 2);
        if t(1,2)*1.0/t(2,2) < r
            result1 = [result1; p1(i, :)];
            result2 = [result2; p2(t(1,1), :)];
        end
    end
    r1 = result1;
    r2 = result2;
end