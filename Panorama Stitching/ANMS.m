function ANMS = ANMS(Ic, N)
    regmax = imregionalmax(Ic);
    l1 = length(regmax(1,:));
    l2 = length(regmax(:,1));
    points = zeros(0,3);
    for i = 1 : l2
        for j = 1 : l1
            if(regmax(i,j) == 1)
                points = padarray(points,1,0,'pre');
                points(1,1) = j;
                points(1,2) = i;
                points(1,3) = Inf;
            end
        end
    end
    Nstrong = length(points);
    for i = 1 : Nstrong
        ED = inf;
        for j = 1 : Nstrong
            if(Ic(points(j,2),points(j,1)) > Ic(points(i,2),points(i,1)))
                ED = (points(j,2)-points(i,2))^2 + (points(j,1)-points(i,1))^2;
            end
            if(ED < points(i,3))
                points(i,3) = ED;
            end
        end
    end
    points = sortrows(points, 3);
    ANMS = points(Nstrong - N  + 1: Nstrong, 1:2);
end