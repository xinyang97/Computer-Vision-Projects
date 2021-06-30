function plotGMM = plotGMM(Pai, Mu, Sigma)
    
    for i = 1 : length(Pai)
        sigma = Sigma(:,:,i)
        miu = Mu(:,i)
        p = Pai(i)
        set(gca, 'nextplot', 'add');
        [x,y,z] = sphere(20);
        ap = [x(:) y(:) z(:)]';
        [v,d]=eig(sigma); 
        d = p * sqrt(d); 
        bp = (v*d*ap) + repmat(miu, 1, size(ap,2)); 
        xp = reshape(bp(1,:), size(x));
        yp = reshape(bp(2,:), size(y));
        zp = reshape(bp(3,:), size(z));
        f = surf(gca, xp,yp,zp);
        % surf(f)

end