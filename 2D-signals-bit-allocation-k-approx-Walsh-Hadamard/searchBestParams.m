function [opt] = searchBestParams(optFunc, B)

best_params = [1,1,1];
bestOptValue = Inf;

for Nx=1:B
   for Ny=1:B
      if(Nx*Ny > B)
          break; 
      end
      b = floor(B/(Nx*Ny));
           
      tmp =[Nx,Ny,b];
      if(optFunc(tmp) < bestOptValue)
         best_params = [Nx,Ny,b];
         bestOptValue = optFunc(tmp);
      end 
   end
end
opt = best_params;
end
