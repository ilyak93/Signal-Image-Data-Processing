function rand_vec = Generate(N,mu_M,sigma_M, mu_L, sigma_L)
    M = normrnd(mu_M,sigma_M);
    L = normrnd(mu_L,sigma_L);
    K = unidrnd(N/2);
    phi = zeros(64,1);
    for i=1:64
        phi(i) = M;
        if ~((i ~= K) && (i ~= (K + N/2)))
            phi(i) = phi(i) + L; 
        end
    end
    rand_vec = phi;
end