function [b1,b2,b3,b4,b5,b6,b7,b8] = UniformQuantizedImage(image)
% This function receives a grayscale image of 512 by 512 and returns
% An array of 8 uniformly quantized versions of that image where the image
% at index b correspondes to uniform quantization with b as its parameter
% This function also plots various graphs.
MSEs =1:8; % this vector holds the values of the MSE's 
figure(6);
hold on;
subplot(3,3,9);
imshow(image,[0,511]);
title('original image');
hold off;


PDF = getImagePDF(image); % get the image's PDF

% set domain limtis
phi_high = double(256); 
phi_low = double(1);


%define normal factor used for reducing numerical errors
normal_factor = 10000;
    for b=1:8       
        B = 2^b;
        %calculate interval size
        delta=ceil((phi_high - phi_low)/B);
        
        %The following lambda returns the arguments interval index
        d_i = @(a) phi_low + floor(delta *a);
        
        %Calculate decision levels
        decision_levels = d_i(0:B);
        
        %Update the graph
        figure(3)
        hold on;
        temp = ones(size(decision_levels)) * b;
        scatter(decision_levels,temp,2,'r','+');
        hold off;
        
        
        figure(5)
        hold on;
        temp = ones(size(decision_levels)) * b;
        scatter(decision_levels,temp,2,'r','o');
        hold off;
        
        %calculating the uniform representation levels by taking the half
        %of the intervals of the corresponding decision levels
        representation_levels = (1:delta:256)+delta/2;  
        
        % Update the graph
        figure(2)
        hold on;
        temp = ones(size(representation_levels)) * b;
        scatter(representation_levels,temp,1,'r','+');
        hold off;
        
        
        figure(5)
        hold on;
        temp = ones(size(representation_levels)) * b;
        scatter(representation_levels,temp,1,'b','+');
        hold off;
        
        
        %The following lambda functions as the uniform quantizer
        uniform_quantizer = @(x) representation_levels(1+floor( double(x)/ delta));
        
        %Quantize the image
        UniformlyQuantizedImage = arrayfun(uniform_quantizer,image);
        switch(b)
            case 1
                b1 = UniformlyQuantizedImage;
            case 2
                b2 = UniformlyQuantizedImage;
            case 3
                b3 = UniformlyQuantizedImage;
            case 4
                b4 = UniformlyQuantizedImage;
            case 5
                b5 = UniformlyQuantizedImage;
            case 6
                b6 = UniformlyQuantizedImage;
            case 7
                b7 = UniformlyQuantizedImage;
            case 8
                b8 = UniformlyQuantizedImage;
        end
        figure(6);
        hold on;
        subplot(3,3,b);
        jjj = sprintf('b=%d',b);
        imshow(UniformlyQuantizedImage,[0,255]);
        title(jjj);
        hold off;
        
        
        %Calculate MSE
        MSEs(b) = MSEfromTwo(image,UniformlyQuantizedImage);
    end
    
    %Update all graphs with nice titles and axis labels
    figure(2);
    hold on;
    title('representation levels (b)');
    xlabel('representation levels');
    ylabel('b');
    hold off;
    
    figure(3);
    hold on;
    title('decision levels (b)');
    xlabel('decision levels');
    ylabel('b');
    hold off;
    
    
    figure(4);
    hold on;
    title('MSE(b)');
    xlabel('b');
    ylabel('MSE');
    plot(MSEs);
    hold off;
    
    
    
   figure(5);
   hold on;
   title(' rep. levels and dec. levels on the same graph');
   ylabel('b');
   xlabel('dec. levels in red, rep. levels in blue');
   hold off;
end