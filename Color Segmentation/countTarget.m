%% This file is used to count numbers selected pixels for each image.

trainN = [68,76,91,99,106,114,121,137,144,152,160,168,176,192,200,208,216,223,231,248,256,264,280];
testN = [1,2,3,4,5,6,7,8];

lenx = length(img1(:,1,1));
leny = length(img1(1,:,1));

for i = 1:length(trainN)
    counter = 0;
    data = imread(strcat(strcat('train_images/',num2str(trainN(i)),'.jpg')));
    % indicator = imread(strcat(strcat('train_images/', num2str(trainN(i)),'indicator.jpg')));
    
    BW = roipoly(data);
    lenx = length(data(:,1,1));
    leny = length(data(1,:,1));
    for ix = 1:lenx
        for iy = 1:leny
            if isequal(BW(ix,iy),1)
                counter = counter + 1;
            end
        end
    end
    trainN(i) = counter;
end

for i = 1:length(testN)
    counter1 = 0;
    data1 = imread(strcat(strcat('test_images/',num2str(testN(i)),'.jpg')));
    BW1 = roipoly(data1);
    lenxt = length(data1(:,1,1));
    lenyt = length(data1(1,:,1));
    for ix = 1:lenxt
        for iy = 1:lenyt
            if isequal(BW1(ix,iy),1)
                counter1 = counter1 +1;
            end
        end
    end
    testN(i) = counter1;
end

trainN
testN
    