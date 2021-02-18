function [clean_signal, noise, dirty_signal] = CreateNoisySignal(N,M_mu,L_mu,M_sigma,L_sigma, Noise_sigma)
    clean_signal =Generate(N,M_mu,M_sigma, L_mu, L_sigma);
    noise = CreateWhiteNoiseVector(N,Noise_sigma);
    dirty_signal = clean_signal + noise;
end