function Q_opt_image = ApplyBitBudget(image, Nx, Ny, b)
    %[sX, sY] = size(image);
    Sampled_image = zeros(floor(Nx),floor(Ny));
    for x=1:1:floor(Nx)
        for y=1:1:floor(Ny)
            i = ((x -1 )/floor(Nx));
            j = ((y -1 )/floor(Ny));
            n_i = (x )/floor(Nx);
            n_j = ((y  )/floor(Ny));
            
            Sampled_image(x,y) = mean(image(floor(1000*i)+1:floor(1000*n_i)+1,floor(1000*j)+1:floor(1000*n_j)+1),'all');
        end
    end
    
    B = 2^b;
    D = (max(max(image))-min(min(image)))/B;
    Q = @(val) min(min(image))+(floor((D*val)/B))*D;
    Q_opt_image = arrayfun(Q,Sampled_image);      

end