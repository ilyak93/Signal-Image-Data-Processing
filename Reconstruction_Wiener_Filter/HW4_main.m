close all; clear; clc;
%Part a - define the constants



N = 64;
c = 0.6;
M_mu = 0;
L_mu = 0;
M_sigma = sqrt(c);
L_sigma = sqrt((N/2)*(1-c));

% calculate empirically Expectation vector and autocorrelation matrix
[Expectation,AutoCorrelation] = GenerateStaticticalData(N,M_mu,M_sigma,L_mu,L_sigma);
disp("Expectation vector MSE is: ");
disp(immse(Expectation, zeros(size(Expectation))));
figure(1);
plot(Expectation);
title("Expectation vector");
figure(2);
imagesc(AutoCorrelation);
title("AutoCorrelation Matrix");

% Create the autocorrelation matrix we calculated analyticly on Q4
Comparison = zeros(N);
for i=1:N
    for j=1:N
        if(i==j || abs(i-j) == N/2)
            Comparison(i,j) = 1;
        else
            Comparison(i,j)= c;
        end
    end
end

%Calculate and display MSE
MSE = immse(Comparison, AutoCorrelation);
disp("The MSE of the empirical AutoCorreation matrix and the one we found anayticly is:");
disp(MSE);



% part b
Noise_sigma = 1;
Num_Samples = 10000;
H = eye(N);
R_n = (Noise_sigma^2)*eye(N);
WienerFilter = AutoCorrelation*(H')/(H*AutoCorrelation*H' + R_n);
figure(3);
imagesc(WienerFilter);
title("part b - Wiener Filter");

Clean_Samples = zeros(N,Num_Samples);
Noised_Samples = zeros(N,Num_Samples);
DeNoised_Samples = zeros(N,Num_Samples);

for i=1:Num_Samples
    [CS, NN, DS, DNS] = CreateSample(N,M_mu,L_mu,M_sigma,L_sigma, Noise_sigma,WienerFilter);
    for j=1:64    
        Clean_Samples(j,i) = CS(j);
        Noised_Samples(j, i) = DS(j);
        DeNoised_Samples(j,i) = DNS(j);
    end
end
MSES1 = zeros(Num_Samples,1);
MSES2 = zeros(Num_Samples,1);
for i=1:Num_Samples
   MSES1(i) = immse(Clean_Samples(:,i), DeNoised_Samples(:,i));
   MSES2(i) = immse(Noised_Samples(:,i), DeNoised_Samples(:,i));
   if(mod(i-1,2000) == 0 )
       figure(10+i);
       plot(Clean_Samples(:,i),'g');
       hold on;
       plot(DeNoised_Samples(:,i),'r');
       hold on;
       title(['part b - MSE = ',num2str(MSES1(i))]);
       legend('Original Signal', 'Denoised Signal');
       hold off;
       
       figure(10000+i);
       plot(Noised_Samples(:,i),'b');
       hold on;
       plot(DeNoised_Samples(:,i),'r');
       hold on;
       title(['part b - MSE = ',num2str(MSES2(i))]);
       legend('Signal With Noize', 'Denoised Signal');
       hold off;
   end
end


figure(5);
scatter(1:Num_Samples,MSES1,'.');
title(['part b- Total MSE = ',num2str(mean(MSES1))]);
disp("part b - clean vs denoised Wiener Filtering MSE: ");
disp(mean(MSES1));

figure(10000000);
scatter(1:Num_Samples,MSES2,'.');
title(['part b- Total MSE = ',num2str(mean(MSES2))]);
disp("part b - noised vs denoised Wiener Filtering MSE: ");
disp(mean(MSES2));


%part c
Noise_sigma = sqrt(1);
Num_Samples = 10000;
% create H as defined in pdf
H = zeros(N);
H(1,1) = -5/12;
H(1,2) = 4/3;
H(1,3) = -1/12;
H(1,end-1) = -1/12;
H(1,end) = 4/3;
for i=2:N
    v = circshift(H(1,:), i-1);
    H(i,:) = v; 
end
%
R_n = (Noise_sigma^2)*eye(N);
WienerFilter = AutoCorrelation*(H')/(H*AutoCorrelation*H' + R_n);
figure(7);
imagesc(WienerFilter);
title("Wiener Filter - part c");

Clean_Samples = zeros(N,Num_Samples);
Noised_Samples = zeros(N,Num_Samples);
DeNoised_Samples = zeros(N,Num_Samples);

    for i=1:Num_Samples
        [CS, NN, DS, DNS] = CreateSample(N,M_mu,L_mu,M_sigma,L_sigma, Noise_sigma,WienerFilter);
        for j=1:64
            Clean_Samples(j,i) = CS(j);
            Noised_Samples(j, i) = DS(j);
            DeNoised_Samples(j,i) = DNS(j);
        end
    end
MSES1 = zeros(Num_Samples,1);
MSES2 = zeros(Num_Samples,1);
for i=1:Num_Samples
   MSES1(i) = immse(Clean_Samples(:,i),DeNoised_Samples(:,i)) ;
   MSES2(i) = immse(Noised_Samples(:,i),DeNoised_Samples(:,i)) ;
   if(mod(i-1,2000) == 0 )
       figure(20+i);
       plot(Clean_Samples(:,i),'g');
       hold on;
       plot(DeNoised_Samples(:,i),'r');
       hold on;
       title(['part b - MSE = ',num2str(MSES1(i))]);
       legend('Original Signal', 'Denoised Signal');
       hold off;
       
       figure(20000+i);
       plot(Noised_Samples(:,i),'b');
       hold on;
       plot(DeNoised_Samples(:,i),'r');
       hold on;
       title(['part b - MSE = ',num2str(MSES2(i))]);
       legend('Signal With Noize', 'Denoised Signal');
       hold off;
   end
end


figure(6);
scatter(1:Num_Samples,MSES1,'.');
title(['part c - Total MSE = ',num2str(mean(MSES1))]);
disp("part c - Wiener Filtering MSE: ");
disp(mean(MSES1));

figure(33333333);
scatter(1:Num_Samples,MSES2,'.');
title(['part c - Total MSE = ',num2str(mean(MSES2))]);
disp("part c - Wiener Filtering MSE: ");
disp(mean(MSES2));


%section d

% part d.b
Noise_sigma = sqrt(5);
Num_Samples = 10000;
H = eye(N);
R_n = (Noise_sigma^2)*eye(N);
WienerFilter = AutoCorrelation*(H')/(H*AutoCorrelation*H' + R_n);
figure(100);
imagesc(WienerFilter);
title("part d.b - Wiener Filter");

Clean_Samples = zeros(N,Num_Samples);
Noised_Samples = zeros(N,Num_Samples);
DeNoised_Samples = zeros(N,Num_Samples);

for i=1:Num_Samples
    [CS, NN, DS, DNS] = CreateSample(N,M_mu,L_mu,M_sigma,L_sigma, Noise_sigma,WienerFilter);
    for j=1:64
        Clean_Samples(j,i) = CS(j);
        Noised_Samples(j, i) = DS(j);
        DeNoised_Samples(j,i) = DNS(j);
    end
end

MSES1 = zeros(Num_Samples,1);
MSES2 = zeros(Num_Samples,1);
for i=1:Num_Samples
   MSES1(i) = immse(Clean_Samples(:,i), DeNoised_Samples(:,i));
   MSES2(i) = immse(Noised_Samples(:,i), DeNoised_Samples(:,i));
   if(mod(i-1,2000) == 0)
       figure(100+i);
       plot(Clean_Samples(:,i),'g');
       hold on;
       plot(DeNoised_Samples(:,i),'r');
       hold on;
       title(['part d.b - MSE = ',num2str(MSES1(i))]);
       legend('Original Signal', 'Denoised Signal');
       hold off;
       
       figure(100000+i);
       plot(Noised_Samples(:,i),'b');
       hold on;
       plot(DeNoised_Samples(:,i),'r');
       hold on;
       title(['part d.b - MSE = ',num2str(MSES2(i))]);
       legend('Signal With Noize', 'Denoised Signal');
       hold off;
   end
end


figure(200);
scatter(1:Num_Samples,MSES1,'.');
title(['part d.b- Total MSE = ',num2str(mean(MSES1))]);
disp("part d.b - Wiener Filtering MSE: ");
disp(mean(MSES1));

figure(20222200);
scatter(1:Num_Samples,MSES2,'.');
title(['part d.b- Total MSE = ',num2str(mean(MSES2))]);
disp("part d.b - Wiener Filtering MSE: ");
disp(mean(MSES2));


%part d.c
Noise_sigma = sqrt(5);
Num_Samples = 10000;
% create H as defined in pdf
H = zeros(N);
H(1,1) = -5/12;
H(1,2) = 4/3;
H(1,3) = -1/12;
H(1,end-1) = -1/12;
H(1,end) = 4/3;
for i=2:N
    v = circshift(H(1,:), i-1);
    H(i,:) = v; 
end
%
R_n = (Noise_sigma^2)*eye(N);
WienerFilter = AutoCorrelation*(H')/(H*AutoCorrelation*H' + R_n);
figure(300);
imagesc(WienerFilter);
title("Wiener Filter - part d.c");

Clean_Samples = zeros(N,Num_Samples);
Noised_Samples = zeros(N,Num_Samples);
DeNoised_Samples = zeros(N,Num_Samples);
    
for i=1:Num_Samples
    [CS, NN, DS, DNS] = CreateSample(N,M_mu,L_mu,M_sigma,L_sigma, Noise_sigma,WienerFilter);    
    for j=1:64
        Clean_Samples(j,i) = CS(j);
        Noised_Samples(j, i) = DS(j);
        DeNoised_Samples(j,i) = DNS(j);
    end    
end

MSES1 = zeros(Num_Samples,1);
MSES2 = zeros(Num_Samples,1);
for i=1:Num_Samples
   MSES1(i) = immse(Clean_Samples(:,i), DeNoised_Samples(:,i));
   MSES2(i) = immse(Noised_Samples(:,i), DeNoised_Samples(:,i));
   if(mod(i-1,2000) == 0 )
       figure(300+i);
       plot(Clean_Samples(:,i),'g');
       hold on;
       plot(DeNoised_Samples(:,i),'r');
       hold on;
       title(['part d.c - MSE = ',num2str(MSES1(i))]);
       legend('Original Signal', 'Denoised Signal');
       hold off;
       
       figure(300000+i);
       plot(Noised_Samples(:,i),'b');
       hold on;
       plot(DeNoised_Samples(:,i),'r');
       hold on;
       title(['part d.c - MSE = ',num2str(MSES2(i))]);
       legend('Signal With Noize', 'Denoised Signal');
       hold off;
   end
end


figure(400);
scatter(1:Num_Samples,MSES1,'.');
title(['part d.c - Total MSE = ',num2str(mean(MSES1))]);
disp("part d.c - Wiener Filtering MSE: ");
disp(mean(MSES1));

figure(44444400);
scatter(1:Num_Samples,MSES2,'.');
title(['part d.c - Total MSE = ',num2str(mean(MSES2))]);
disp("part d.c - Wiener Filtering MSE: ");
disp(mean(MSES2));

DFT = dftmtx(64)./sqrt(64);
lambda = DFT'*H(1,:).';
lambda_inv = 1./lambda;
I = diag(lambda)*diag(lambda_inv);
H_pseudo_inverse_filter = DFT'*diag(lambda_inv)*DFT;
H_H_pif = real(H*H_pseudo_inverse_filter);
figure(50000)
imagesc(H_H_pif);
H_pif_H = real(H*H_pseudo_inverse_filter);
figure(60000)
imagesc(H_pif_H);


