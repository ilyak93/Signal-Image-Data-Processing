clear all;
close all;
clc;
%the images rascaled between 0 and 1 on the greyscale
orig = rescale(imread('mandril_original.png'));
distorted = rescale(imread('mandril_distorted.png'));
[M,N] = size(orig);

% show original
figure(1);
imshow(orig);

%show distorted
figure(2);
imshow(distorted);

%compute Fourier coefficients of original image
alpha = myDFT(orig);

%compute Fourier coefficients of original image using fft 
dft = fft(orig,[], 2) / N; % (normilized)

%The norm of the error between our DFT computations and FFT less then
%0.1^{10}
assert ((norm(dft-alpha)) < 0.1^(10));

%show the rank of the coefficients matrix 
ra = rank(alpha)

%compute the pseudo-inverse of alpha
if ra == M
    pseudo_inv = pinv(alpha);
end
    
%compute Fourier coefficients of distorted image
beta = myDFT(distorted);

%compute Fourier coefficients of original image using fft
dft = fft(distorted,[], 2) / N; % (normilized)

%The norm of the error between our DFT computations and FFT less then
%0.1^{10}
assert ((norm(dft-beta)) < 0.1^(10));

%compute functional map C (distortion functional map) by: C = A^{-1}B where A^{-1} is a pseudoinverse
C = pseudo_inv*beta;
%compute the error between beta and A*C = A*A^{-1}B to measure how good the
%approximation of the functional map
opt_error = beta - alpha*C;
% the norme of the difference between B and A*C is less then 0.1^(10)
assert (norm(opt_error) < 0.1^(10));

%use the functional map C to distort Fourier coefficients of the original
%image in DFT domain
my_distorted_DFT = alpha*C;
% restore into non-DFT domain 
my_distorted = myiDFT(my_distorted_DFT)*N;
% the error between the functional map distortion and 
% the given distorted image is less then 0.1^(10)
assert (norm(distorted - my_distorted) < 0.1^(10));

%show our distorted images
figure(3);
imshow(my_distorted);


%the butterfly image rascaled between 0 and 1 on the greyscale
butterfly_orig_rescaled = rescale(imread('Butterfly_.png'));

%show original butterfly images
figure(4);
imshow(butterfly_orig_rescaled);

% computer Fourier coefficients of butterfly image
alpha_btrfly = myDFT(butterfly_orig_rescaled);

% computer butterfly image in DFT domain
my_distorted_butterfly_DFT = alpha_btrfly*C;
% computer butterfly image in non-DFT domain by our inverse DFT
my_distorted_butterfly = myiDFT(my_distorted_butterfly_DFT)*N;

%show original our distorted butterfly image
figure(5);
imshow(my_distorted_butterfly);




% self learning - transofrm distorted to non-distorted using our functional
% map C
%alpha_btrfly = myDFT(butterfly_orig_rescaled);
beta = myDFT(my_distorted_butterfly);
%rank of B
rb = rank(beta)
%computing the pseudo-inverse of B
if rb == N
    pseudo_inv = pinv(beta);
else
%removing linear-independent columns from B
    %beta = licols(beta);
    pseudo_inv = pinv(beta);
end

%compute functional map C (recovering functional map) by: C = B^{-1}A where 
% B^{-1} is a pseudoinverse
C2 = pseudo_inv*alpha_btrfly;

opt_error = alpha_btrfly - beta*C2;

norm(opt_error)

beta = myDFT(distorted);

pseudo_inv = pinv(beta);

C = pseudo_inv*alpha;

norm(C - C2)

%using the recovering functional map C to get the recovered image in DFT
%domain
beta = myDFT(distorted);

my_orig_DFT = beta*C2;
%transofrming to non-DFT domain using the inverse DFT
my_orig = myiDFT(my_orig_DFT)*N;
%The norm of the error between the given image and its recovering using the
%recovering functional map (whise is the inverse of the distortion
%functional map) is less then 0.1^{10
norm(orig - my_orig)

% show the recovered original image
figure(6);
imshow(my_orig);


beta = myDFT(my_distorted_butterfly);

my_orig_DFT = beta*C;
%transofrming to non-DFT domain using the inverse DFT
my_orig = myiDFT(my_orig_DFT)*N;
%The norm of the error between the given image and its recovering using the
%recovering functional map (whise is the inverse of the distortion
%functional map) is less then 0.1^{10
norm(orig - my_orig)

% show the recovered original image
figure(7);
imshow(my_orig);










