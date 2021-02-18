function vec = CreateWhiteNoiseVector(N,sigma)
    res = zeros(N,1);
    for i=1:N
        res(i) = normrnd(0,sigma);
    end
    vec = res;
end