

img = double(imread('lena.jpg'));
reconstructed_mse = zeros(size(img)); 

%part 1: a + reconstruction
MSE(1:8) = 0;
for p=8:-1:1
    %i=3;
    D = 2^p;
    %defined to be the sampled image
    sampled_mse = zeros(size(img)/D);
    MSE_i = 0;
    %defined to be the optimum(average) by the choosen measure(mse)
    phi_hat_mat = zeros(D);
    for i=1:D:size(img)
        for j=1:D:size(img)
            %choosing sub image using D of size D*D
            sub_img = img(i:i+D-1,j:j+D-1);
            %average
            phi_hat = mean(sub_img,'all');
            %filling the average into sampled one time
            sampled_mse((i+D-1)/D,(j+D-1)/D) = phi_hat;
            %filling the average into reconstructed D*D times by standard
            %reconstruction
            reconstructed_mse(i:i+D-1,j:j+D-1) = phi_hat;
            %creating D*D phi sub_mat and calculating the error using immse
            phi_hat_mat(:) = phi_hat;
            cur_error = immse(sub_img,phi_hat_mat);
            %summarizing the partial mse to the whole mse
            MSE_i = MSE_i + cur_error;
        end
    end
    %saving mse_i for each i for plotting (D, MSE(D)) function 
    MSE(p)=MSE_i;
    %plotting the sampled images in the same illustration size 9 in format
    % 3*3
    figure(30);
    hold on;
    subplot(3,3,9-p);
    jjj = sprintf('sample MSE D=%d',D);
    jjjj = sprintf('size=%d', size(sampled_mse,1));
    imshow(sampled_mse,[0,255]);
    title( {jjj;jjjj} );
    %plot the original
    subplot(3,3,9);
    imshow(img,[0,255]);
    title('original image');
    hold off
    
    %plotting the reconstructed images in the same illustration size 9 in format
    % 3*3
    figure(40);
    hold on;
    subplot(3,3,9-p);
    jjj = sprintf('reconstructed MSE D=%d',D);
    jjjj = sprintf('size=%d', size(reconstructed_mse,1));
    imshow(reconstructed_mse,[0,255]);
    title( {jjj;jjjj} );
    
    %plot the original
    subplot(3,3,9);
    imshow(img,[0,255]);
    title('original image');
    
    hold off;
end
%plotting the (D,MSE(D)) function
figure(31);
hold on;
title('MSE(D)');
xlabel('D');
ylabel('MSE');
plot([2,4,8,16,32,64,128,256], MSE);
hold off;


% part 2 b + reconstruction
%part 1: a
reconstructed_mad = zeros(size(img));
MAD(1:8) = 0; 
for p=8:-1:1
    D = 2^p;
    %defined to be the sampled image
    sampled_mad = zeros(size(img)/D);
    %defined to be the optimum(median) by the choosen measure(mad)
    MAD_i = 0;
    phi_hat_mat = zeros(D);
    for i=1:D:size(img)
        for j=1:D:size(img)
            %choosing sub image using D of size D*D
            sub_img = img(i:i+D-1,j:j+D-1);
            %median
            phi_hat = median(sub_img, 'all');
            %filling the median into sampled one time
            sampled_mad((i+D-1)/D,(j+D-1)/D) = phi_hat;
            %filling the average into reconstructed D*D times by standard
            %reconstruction
            reconstructed_mad(i:i+D-1,j:j+D-1) = phi_hat;
            %calculating the error using mad (with flag=1: implicit median
            %calculation
            cur_error = mad(sub_img, 1, 'all');
            %summarizing the partial mad to the whole mad
            MAD_i = MAD_i + cur_error;
        end
    end
    %saving mad_i for each i for plotting (D, MAD(D)) function 
    MAD(p)=MAD_i;
    %plotting the sampled images in the same illustration size 9 in format
    % 3*3
    figure(33);
    hold on;
    subplot(3,3,9-p);
    jjj = sprintf('sampled MAD D=%d',D);
    jjjj = sprintf('size=%d', size(sampled_mad,1));
    imshow(sampled_mad,[0,255]);
    title( {jjj;jjjj} );
    %plot the original
    subplot(3,3,9);
    imshow(img,[0,255]);
    title('original image');
    hold off
    
    %plotting the reconstructed images in the same illustration size 9 in format
    % 3*3
    figure(43);
    hold on;
    subplot(3,3,9-p);
    jjj = sprintf('reconstructed MAD D=%d',D);
    jjjj = sprintf('size=%d', size(reconstructed_mad,1));
    imshow(reconstructed_mad,[0,255]);
    title( {jjj;jjjj} );
    %plot the original
    subplot(3,3,9);
    imshow(img,[0,255]);
    title('original image');
    
    hold off;
end
%plotting the (D,MAD(D)) function
figure(32);
hold on;
title('MAD(D)');
xlabel('D');
ylabel('MAD');
plot([2,4,8,16,32,64,128,256], MAD);
hold off;