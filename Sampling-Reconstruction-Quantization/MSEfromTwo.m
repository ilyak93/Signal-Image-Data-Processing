function [ mse ] = MSEfromTwo( image1, image2 )
%Receives 2 images and calculates MSE, taken from the tutorial
if ( ndims(image1)>2 || ndims(image2)>2 )
    error( 'Can get only vectors or 2D matrices.' )
end

if ( ~isequal(size(image1),size(image2)) )
    error( 'The input matrices have different dimensions.' )
end


diff = double(image1)-double(image2);
sse = sum(sum(diff.^2));
mse = sse / length(diff(:));

end