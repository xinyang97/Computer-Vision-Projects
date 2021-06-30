% T: test file index set
% rPi, rMu, rSigma: model parameter
% gamma: confidence threshold
function test = testGMM(T, rPi, rMu, rSigma, gamma)
    for itr = 1 : length(T)
        % read test image
        data = imread(strcat(strcat('test_images/', num2str(T(itr))), '.jpg'));
        l1 = length(data(:,1,1));
        l2 = length(data(1,:,1));
        % initialize result for the test data
        result = zeros(l1, l2);
        for i = 1 : l1
           for j = 1 : l2
              
              if mixP(data(i,j,:), rPi, rMu, rSigma) > gamma
                  result(i, j) = 1;
              end
           end
        end
        imwrite(result,strcat(strcat('test_images/', num2str(T(itr))), 'result.jpg'))
    end
    test = 1;
end

% x: input point
% rPi, rMiu, rSigma: array of pi, miu, sigma representing the model
function mixProb = mixP(x, rPi, rMiu, rSigma)
    k = length(rPi);
    p = 0;
    % reshape x from 1x1x3 to 3x1
    x = reshape(x, [3,1]);
    for i = 1 : k
        p = p + rPi(i) * poss(x, rMiu(:, i), rSigma(:,:,i));
    end
    mixProb = p;
end

function possibility = poss(x, miu, sigma)
    x = double(x);
    % possibility of x under the distribution of miu, sigma
    possibility = double(exp((-1/2) * transpose(x - miu) * sigma^(-1) * (x - miu)) / (sqrt(det(sigma) * (2*pi)^3)));
end