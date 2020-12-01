function PDF = getImagePDF(image)
% Receives an image and returns its PDF
    [pixelCounts, ~ ] = imhist(image); 
    PDF = double(pixelCounts) / numel(image);   
end



