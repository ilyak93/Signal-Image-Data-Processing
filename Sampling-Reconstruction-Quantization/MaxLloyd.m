function [b1,b2,b3,b4,b5,b6,b7,b8] = MaxLloyd(image)
% This function receives a grayscale image of 512 by 512 and returns
% An array of 8 Max-Lloyd spirit quantized versions of that image where
% the image at index b correspondes to Max-Lloyd quantization with b 
% as its parameter. This function also plots various graphs.
MSEs =1:8; % this vector holds the values of the MSE's 
figure(11);
hold on;
subplot(3,3,9);
imshow(image,[0,511]);
title('original image');
hold off;

PDF = getImagePDF(image); % get the image's PDF
% set domain limtis
phi_high = double(256); 
phi_low = double(1);
epsilon= 1e-3; % used for convergence testing
%define normal factor used for reducing numerical errors
normal_factor = 10000;
    for b=1:8
        B = 2^b;
        prev_mse = inf;
        mse=-inf;
        
        
        delta=(phi_high - phi_low)/B;
        d_i = @(a) phi_low + floor(delta *a);
        representation_levels= d_i(1:B);
        
        while abs(normal_factor*(mse - prev_mse)) > (normal_factor*epsilon)
            %calcuate decision_levels
            decision_levels= [phi_low,floor(conv(representation_levels,[0.5,0.5],'valid')),phi_high];

            %calculate deltas
            delta_i = @(i)max(1,abs(double(decision_levels(i))-double(decision_levels(i+1))));

            %calculate representation levels
            expected_i = @(i) ((decision_levels(i):decision_levels(i+1)) * normal_factor*PDF(decision_levels(i):decision_levels(i+1)))*delta_i(i);
            rep_i = @(i) normal_factor*(expected_i(i) /normal_factor) / (sum(normal_factor*PDF(decision_levels(i):decision_levels(i+1)))*delta_i(i));
            temp = arrayfun(rep_i, (1:B));

            %update only if non zero probability interval
            for i=1:B
                if ~isnan(temp(i))
                    representation_levels(i)=temp(i);
                end
            end

            %quantizer for given amount of B
            find_quan_value = @(x) (find(decision_levels > x,1,'first')-1); % was-1
            quantizer = @(x) representation_levels(find_quan_value(x));
            quantized_image = arrayfun(quantizer,image);

            %calculate MSE for convergence
            diff = double(quantized_image)-double(image);
            sse = sum(sum(diff.^2));
            prev_mse=mse;
            mse = normal_factor*sse / (length(diff(:)) * normal_factor);

        end
        switch(b)
            case 1
                b1 = quantized_image;
            case 2
                b2 = quantized_image;
            case 3
                b3 = quantized_image;
            case 4
                b4 = quantized_image;
            case 5
                b5 = quantized_image;
            case 6
                b6 = quantized_image;
            case 7
                b7 = quantized_image;
            case 8
                b8 = quantized_image;
        end
        
        %Calculate MSE
        MSEs(b) = MSEfromTwo(image,quantized_image);
        
        figure(8)
        hold on;
        temp = ones(size(representation_levels)) * b;
        scatter(representation_levels,temp,1,'r','+');
        hold off;
        
        
        figure(9)
        hold on;
        temp = ones(size(representation_levels)) * b;
        scatter(representation_levels,temp,1,'b','+');
        hold off;
        
        
        figure(10)
        hold on;
        temp = ones(size(decision_levels)) * b;
        scatter(decision_levels,temp,2,'r','+');
        hold off;
        
        
        figure(9)
        hold on;
        temp = ones(size(decision_levels)) * b;
        scatter(decision_levels,temp,2,'r','o');
        hold off;
        
        figure(11);
        hold on;
        subplot(3,3,b);
        jjj = sprintf('b=%d',b);
        imshow(quantized_image,[0,255]);
        title(jjj);
        hold off;
    end
    
    figure(7);
    hold on;
    plot(MSEs);
    title('MSE as a function of the bit budget');
    xlabel('b');
    ylabel('MSE(b)');
    hold off;
    
    figure(8);
    hold on;
    title('Representation levels as a function of b');
    xlabel('Representation levels');
    ylabel('b');
    hold off;
    
    figure(9);
    hold on;
    title(' rep. levels and dec. levels on the same graph');
    ylabel('b');
    xlabel('dec. levels in red, rep. levels in blue');
    hold off;
    
    figure(10);
    hold on;
    title('Decision levels as a function of b');
    xlabel('Decision levels');
    ylabel('b');
    hold off;    

end