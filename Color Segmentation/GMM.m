%% Xinyang Li CMSC426 P1
%%
% Single Gaussian goes below
img1=imread('train_images/76.jpg');
BW1 = roipoly(img1);
lenx = length(img1(:,1,1));
leny = length(img1(1,:,1));
% create target matrix that that is in space 3*(select pixel number).
% target matrix stores [R,G,B] value of each selected pixel
target = [];
% pai = double(0);
for i = 1:lenx
    for j = 1:leny
        if isequal(BW1(i,j),1)
             v = [img1(i,j,1);img1(i,j,2);img1(i,j,3)];
             target = [target v];
        end
    end
end
% count column (N) and row numbers (M = 3) of target matrix
[M,N] = size(target);

muR = sum(target(1,:))/N;
muG = sum(target(2,:))/N;
muB = sum(target(3,:))/N;
% mean value of RGB, which is a 3*1 vector
mu = [muR; muG; muB]
sigma = cov(double(transpose(target)))
% compute the likelihood on each pixel of the picture
% i.e, the conditional probability of given pixel is orange
cond = zeros(lenx,leny);
cond_i = [];
target_cond = [];
for i = 1:lenx
    for j = 1:leny
        x_ij = double([img1(i,j,1);img1(i,j,2);img1(i,j,3)]);
        prob_ij = double(1/(sqrt((2*pi)^3*det(sigma)))*exp(-1/2*transpose(x_ij-mu)*inv(sigma)*(x_ij-mu)));
        cond_i = double([cond_i prob_ij]);
        if isequal(BW1(i,j),1)
            target_cond = double([target_cond prob_ij]);
        end
    end
    cond(i,:) = cond_i;
    cond_i = [];
end
% single GMM ends here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% apply trainGMM
[Pai, Mu, Sigma] = trainGMM(7,N,double(target)) %K = 7 is user chosen number of cluster, which can be manually changed. 
% apply testGMM
testGMM([1,2,3,4,5,6,7,8], Pai,Mu,Sigma, 15e-8)
% apply plotGMM
plotGMM(Pai, Mu, Sigma)

