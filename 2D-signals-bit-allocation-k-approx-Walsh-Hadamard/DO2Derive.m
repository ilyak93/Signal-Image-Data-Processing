function [ Dy , Dx ] =  DO2Derive(func, deltaX , deltaY)
    [Size_x , Size_y ] = size(func);
    Dx = zeros((Size_x-1),Size_y);
    Dy = zeros(Size_x, (Size_y-1));
    for x=1:1:Size_x-1
       for y=1:1:Size_y
           Dx(x,y) = (func(x+1,y) - func(x,y))/deltaX;
       end
    end
    
    
    
    for x=1:1:Size_x
       for y=1:1:Size_y-1
           Dy(x,y) = (func(x,y+1) - func(x,y))/deltaY;
       end
    end
end