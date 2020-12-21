
function [H]= generate_hadamard(N)

% example
%H = generate_hadamard(256);
% I = phantom(256);
% Hr_1d = H*I;   %% 1D hadamard transform
% Hr_2d = H*I*H'; %% 2D hadamard transform

n=nextpow2(N);

if (n~= log2(N))
    display('Hadamard matix can be generated only for N = 2^n');
    return;
end

H=[1 1; 1 -1];
for k=2:n
    temp=H;
    H =[temp temp; temp -temp];
end
H=(1/sqrt(N))*H;
end
