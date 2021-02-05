clear all;
close all;
clc;

% loading the audios
[orig_sc, osc_Fs] = audioread('skycastle.wav');
[distorted_sc, dsc_Fs] = audioread('skycastle-distortion.wav');

orig_sc = reshape(orig_sc, [], 512);
distorted_sc = reshape(distorted_sc, [], 512);

[orig_ttr, ottr_Fs] = audioread('totoro.wav');
[distorted_ttr, dttr_Fs] = audioread('totoro-distortion.wav');

orig_ttr = reshape(orig_ttr, [], 512);
distorted_ttr = reshape(distorted_ttr, [], 512);

[M,N] = size(orig_sc);

% pre-work part : distorting the sound as with the image

% computing alpha and beta as in the previous ex.
alpha = myDFT(orig_sc);

% the error is approximately zero as previous
dft = fft(orig_sc,[], 2) / N;
norm(dft-alpha)


beta = myDFT(distorted_sc);

dft = fft(distorted_sc,[], 2) / N;
norm(dft-beta)

% computing the pseuado-inverse as previous
pseudo_inv = zeros(M,N);
ra = rank(alpha)
if ra == M
    pseudo_inv = pinv(alpha);
else
    %alpha = licols(alpha);
    pseudo_inv = pinv(alpha);
end

%computing C and using it as previous
C = pseudo_inv*beta;

min = beta - alpha*C;
norm(min)

my_distorted_DFT_sc = alpha*C;
my_distorted_sc = myiDFT(my_distorted_DFT_sc)*N;

norm(distorted_sc - my_distorted_sc)

sound1 = reshape(distorted_sc, 1, M*N);
sound2 = reshape(my_distorted_sc, 1, M*N);
sound2 = round(sound2, 10);

% show the result in audio mode
%sound(sound1, dsc_Fs);
%sound(sound2, dsc_Fs);

% distort to clean part (doing all the repeated actions with computing
% alpha, beta the recovering functional map and using it to get the clean
% sounds. 
% Skycastle part
alpha = myDFT(orig_sc);

pseudo_inv = zeros(M,N);
rb = rank(beta)
if rb == N
    pseudo_inv = pinv(beta);
else
    %beta = licols(beta);
    pseudo_inv = pinv(beta);
end

C = pseudo_inv*alpha;

min = alpha - beta*C;
norm(min)

my_orig_DFT_sc = beta*C;

my_orig_sc = myiDFT(my_orig_DFT_sc)*N;

norm(orig_sc - my_orig_sc)

sound3 = reshape(orig_sc, 1, M*N);
sound4 = reshape(my_orig_sc, 1, M*N);
sound4 = round(sound4, 10);

norm(sound3 - sound4)

%sound(sound3, dsc_Fs);
%sound(sound4, dsc_Fs);

%Totoro part - same as previous with tororo signal
alpha = myDFT(orig_ttr);

beta = myDFT(distorted_ttr);

pseudo_inv = pinv(beta);

C = pseudo_inv*alpha;

rb = rank(beta)
if rb == N
    pseudo_inv = pinv(beta);
else
    %beta = licols(beta);
    pseudo_inv = pinv(beta);
end


my_orig_DFT_ttr = beta*C;

my_orig_ttr = myiDFT(my_orig_DFT_ttr)*N;

norm(orig_ttr - my_orig_ttr)

sound5 = reshape(orig_ttr, 1, M*N);
sound6 = reshape(my_orig_ttr, 1, M*N);
sound6 = round(sound6, 10);

norm(sound5 - sound6)
% final result comparing the orignal sound denoted as sound 5 and our
% recovered denoted by sound 6
%sound(sound5, dsc_Fs);
%sound(sound6, dsc_Fs);

figure(7);
hold on
plot(1:M*N, sound5);
hold off

figure(8);
hold on
plot(1:M*N, sound6);
hold off

figure(9);
hold on
plot(1:M*N, (sound5-sound6).^2);
hold off










