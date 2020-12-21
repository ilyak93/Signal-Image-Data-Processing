function res = TwoDIntegral_t( func , deltaX , deltaY )  
    res = sum(sum(func*(deltaX * deltaY)));
end