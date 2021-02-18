function [expectation, autocorrelation]  =  GenerateStaticticalData(N,M_mu,M_sigma, L_mu, L_sigma)
NUM_SAMPLES = 10000;
    Samples = zeros(64,NUM_SAMPLES);
    for i=1:NUM_SAMPLES
        temp = Generate(N,M_mu,M_sigma,L_mu,L_sigma); 
        for j=1:64
            Samples(j,i) =  temp(j);
        end
    end

expectation = mean(Samples,2);

AC = zeros(64);
for i=1:NUM_SAMPLES
   temp = Samples(:,i);
   temp_M = temp * temp';
   AC = AC + temp_M;
end
autocorrelation = AC * (1/NUM_SAMPLES);
end