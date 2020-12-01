% Signal, Image and data processing hw1
clear all;
close all;
clc;
image = imread('lena.jpg');


% part 1 - PDF
figure(1);
hold on;
title('PDF');
xlabel('x');
ylabel('PDF(x)');
plot(getImagePDF(image));
hold off;
 
 
 
% %part 2 - Uniform Quantizer
 [qu_picForb1,qu_picForb2,qu_picForb3,qu_picForb4,...
     qu_picForb5,qu_picForb6,qu_picForb7,qu_picForb8] =...
     UniformQuantizedImage(image);
 
 

 
% %part 3 - Max- Lloyd
 [lm_picForb1,lm_picForb2,lm_picForb3,lm_picForb4,...
     lm_picForb5,lm_picForb6,lm_picForb7,lm_picForb8] =...
     MaxLloyd(image);
 
 
% %following code does MSE comparison
 
 qu_to_orig_MSE = ones([1 8])*0;
 ml_to_orig_MSE = ones([1 8])*0;
 
 
 qu_to_orig_MSE(1)= MSEfromTwo(image,qu_picForb1);
 qu_to_orig_MSE(2)= MSEfromTwo(image,qu_picForb2);
 qu_to_orig_MSE(3)= MSEfromTwo(image,qu_picForb3);
 qu_to_orig_MSE(4)= MSEfromTwo(image,qu_picForb4);
 qu_to_orig_MSE(5)= MSEfromTwo(image,qu_picForb5);
 qu_to_orig_MSE(6)= MSEfromTwo(image,qu_picForb6);
 qu_to_orig_MSE(7)= MSEfromTwo(image,qu_picForb7);
 qu_to_orig_MSE(8)= MSEfromTwo(image,qu_picForb8);
 
 
 
 ml_to_orig_MSE(1)= MSEfromTwo(image,lm_picForb1);
 ml_to_orig_MSE(2)= MSEfromTwo(image,lm_picForb2);
 ml_to_orig_MSE(3)= MSEfromTwo(image,lm_picForb3);
 ml_to_orig_MSE(4)= MSEfromTwo(image,lm_picForb4);
 ml_to_orig_MSE(5)= MSEfromTwo(image,lm_picForb5);
 ml_to_orig_MSE(6)= MSEfromTwo(image,lm_picForb6);
 ml_to_orig_MSE(7)= MSEfromTwo(image,lm_picForb7);
 ml_to_orig_MSE(8)= MSEfromTwo(image,lm_picForb8);
 
 
 figure(12);
 hold on;
 plot(qu_to_orig_MSE,'r');
 plot(ml_to_orig_MSE,'g');
 title('Uniform Quantization MSE(b) [in red] vs. Max-Lloyd Quantization MSE(b) [in green]');
 xlabel('b');
 ylabel('MSE');
 hold off;
