%% trainGMM procedure
%%
% K - cluster size
% N - number of training samples
% P - conditional probability for a pixel to have orange color
% T - sample target matrix (size 3*N)
function [pai, mu, sigma] = train(K,N,T)
% initializition
pai = double(rand()); % scaling factor
mu = double(randi(3,1)); % gaussian mean
sigma = 1000*randi(3,1); % covariance
epsilon = 10e-5; % set covergence criteria
iter_max = 50;

i = 0;
prevMu = 0;
prevPai = pai;
sum_K = 0;
tmpPai = double(0);
tmpSigma = 0; 
tmpMuTop = double(zeros(3,1));
tmpMuBottom = 0;
tmpSigmaTop = double(zeros(3,3));
tmpSigmaBottom = 0;
while (i <= iter_max & abs(mu-prevMu) > epsilon)
    for j = 1:N
        % E-Step
        for index = 1:K
            P = double(1/(sqrt((2*pi)^3*det(sigma)))*exp(-1/2*transpose(T(:,index)-mu)*inv(sigma)*(T(:,index)-mu)));
            sum_K = double(sum_K + pai*P);
        end
        alpha = (pai*P*j)/sum_K;
        % M-Step
        tmpMuTop = tmpMuTop + alpha*double(T(:,j));
        tmpMuBottom = tmpMuBottom + alpha;
        tmpPai = tmpPai + alpha;
    end
    % store previous mean value
    prevMu = mu;
    prevPai = pai;
    % updated value of pai and mu
    pai = tmpPai/double(N);
    mu = tmpMuTop/double(tmpMuBottom);
    
    for j = 1:N
        tmpSigmaTop = tmpSigmaTop + alpha*(double(T(:,j))-double(mu))*transpose(double(T(:,j))-double(mu));
        tmpSigmaBottom = tmpSigmaBottom + alpha;
    end
    % updated value of sigma
    sigma = tmpSigmaTop/double(tmpSigmaBottom);
    i = i+1;
    sum_K = 0;
end
pai
mu
sigma

end





