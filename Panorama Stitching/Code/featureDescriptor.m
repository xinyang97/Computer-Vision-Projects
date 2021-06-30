function fp = featureDescriptor(img, points)
    fp = [];
    N_best = length(points);
    [m, n] = size(img);
    img = im2double(img);
    for i = 1: N_best
        tx = points(i,1);
        ty = points(i,2);
        patch = zeros(64,1) - 1;;
        % mu = 0;
        % mean = 0;
        % create a 41x41 patch centered at (tx,ty)
        if ((tx-20)<=0 || (tx+20)>n || (ty-20)<=0 || (ty+20)>m)
            % skip
        else
             % pair = [tx;ty];
             % location = [location, pair];
            x1 = tx - 20;
            x2 = tx + 20;
            y1 = ty - 20;
            y2 = ty + 20;
            patch = img(y1:y2, x1:x2);

            H = fspecial('gaussian',[41 41],0.8);
            blurred = imfilter(patch,H);
            patch = blurred(18:25,18:25);
            % reshape to a 64x1 vector
            patch = reshape(patch,[64,1])*1.0;
            % compute mean and standard deviation in order to normalize
            mu = mean(patch*1.0);
            sigma = std(double(patch));
            for j = 1:64
                patch(j) = (patch(j)-mu)*1.0/sigma;
            end
        end
        fp = [fp, patch];
    end
    fp;
end
