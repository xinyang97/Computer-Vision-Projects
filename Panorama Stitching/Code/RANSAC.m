% thresh = 100;
function [Hr, inlier1,inlier2] = RANSAC(matchedPoints1,matchedPoints2,thresh)
    range = size(matchedPoints1,1);
    largeSize = 0;
    inlier1 = [];
    inlier2 = [];
    Hr = 0;
    for iter = 1:1000
        % randomly pick 4 pairs
        x1 = [];
        x2 = [];
        y1 = [];
        y2 = [];
        rand_num = randi([1,range],4,1);
        for i = 1:4
            x1 = [x1;matchedPoints1(rand_num(i),1)];
            x2 = [x2;matchedPoints2(rand_num(i),1)];
            y1 = [y1;matchedPoints1(rand_num(i),2)];
            y2 = [y2;matchedPoints2(rand_num(i),2)];
        end
        H = est_homography(x2,y2,x1,y1);
        % apply the homography with all the feature points
        [X, Y] = apply_homography(H, matchedPoints1(:,1), matchedPoints1(:,2));
        targetX = matchedPoints2(:,1);
        targetY = matchedPoints2(:,2);
        output = (X -targetX).^2 + (Y - targetY).^2;
        temp1 = [];
        temp2 = [];
        % if matched, put the point as inlier
        for position = 1:range
            if(output(position) < thresh)
                temp1 = [temp1;matchedPoints1(position,1),matchedPoints1(position,2)];
                temp2 = [temp2;matchedPoints2(position,1),matchedPoints2(position,2)];          
            end
        end
        if size(temp1,1) > largeSize
            Hr = H;
            largeSize = size(temp1);
            inlier1 = temp1;
            inlier2 = temp2;
        end
    end
end