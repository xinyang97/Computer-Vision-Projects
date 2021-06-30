function result = measureDepth(N, trainPc, testPc)
    lm = LinearModel.fit(trainPc, N);
    result = predict(lm, testPc)
    save('distance.mat', 'result');
end