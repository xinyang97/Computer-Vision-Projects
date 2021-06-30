function C = computeBlending(I1, I1_ref, I2)
    I1 = im2double(I1);
    I2 = im2double(I2);
    [y2,x2,aaa] = size(I2);
    
    XWl = round(I1_ref.XWorldLimits(1));
    XWm = round(I1_ref.XWorldLimits(2));
    YWl = round(I1_ref.YWorldLimits(1));
    YWm = round(I1_ref.YWorldLimits(2));
    y1 = I1_ref.ImageSize(1);
    x1 = I1_ref.ImageSize(2);
    
    if XWl < 0
        dx1 = 0;
        dx2 = -XWl;
    else
        dx1 = XWl;
        dx2 = 0;
    end
    if YWl < 0
        dy1 = 0;
        dy2 = -YWl;
    else
        dy1 = YWl;
        dy2 = 0;
    end
    xmax = round(max (dx1+x1, dx2 + x2));
    ymax = round(max (dy1+y1, dy2 + y2));
    C = zeros(ymax, xmax, 3);
    for i = 1 : ymax
        for j = 1 : xmax
            cx1 = - dx1 + j;
            cx2 = - dx2 + j;
            cy1 = - dy1 + i;
            cy2 = - dy2 + i;
            if (cx1 <= 0 || cx1 > x1 || cy1 <= 0 || cy1 > y1 || (I1(cy1, cx1, 1) == 0 && I1(cy1, cx1, 2) == 0 && I1(cy1, cx1, 3) == 0))
                v1 = [0, 0, 0];
            else
                v1 = [I1(cy1, cx1, 1), I1(cy1, cx1, 2), I1(cy1, cx1, 3)];
            end
            % cases that imag1 has values
            if (cx2 <= 0 || cx2 > x2 || cy2 <= 0 || cy2 > y2 || (I2(cy2, cx2, 1) == 0 && I2(cy2, cx2, 2) == 0 && I2(cy2, cx2, 3) == 0))
                v2 = [0, 0, 0];
            else
                v2 = [I2(cy2, cx2, 1), I2(cy2, cx2, 2), I2(cy2, cx2, 3)];
            end
            % compute pixel value
            if v1 == [0, 0, 0]
                v = v2;
            elseif v2 == [0, 0, 0]
                v = v1;
            else
                v = (v1 + v2) / 2;
            end
            C(i,j,1) = v(1);
            C(i,j,2) = v(2);
            C(i,j,3) = v(3);     
        end
    end

end