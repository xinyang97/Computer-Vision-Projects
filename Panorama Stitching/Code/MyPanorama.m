function [C] = MyPanorama(data,data2)
% load images
% data = imread('Images/test2/1.jpg');
% data2 = imread('Images/test2/3.jpg');
% data3 = imread('Images/test2/3.jpg');
% convert 3d images to 2d
data2d = rgb2gray(data);
data2d2 = rgb2gray(data2);
C_img = cornermetric(data2d);
C_img2 = cornermetric(data2d2);

% user-defined N_best
N_best = 500;
% ANMS
location1 = ANMS(C_img,N_best);
location2 = ANMS(C_img2, N_best);

% Feature Descriptor

fp1 = featureDetection(data2d,location1).';
fp2 = featureDetection(data2d2,location2).';

% FeatureMatching
[r1, r2] = featureMatching(location1, fp1, location2, fp2, 0.7);
% showMatchedFeatures(data,data2, r1, r2,'montage');

% RANSAC
[H,set1,set2] = RANSAC(r1,r2,100);
% showMatchedFeatures(data,data2, set1, set2,'montage');

% Image Warping/Blending
tform = projective2d(H.');
[out, out_ref] = imwarp(data,tform);
id = projective2d();
[I2id, id_ref] = imwarp(data2, id);
[C, RC] = imfuse(out, out_ref, I2id, id_ref, 'blend');

imshow(C);
sprintf('FFFFFFinally:)')

end
