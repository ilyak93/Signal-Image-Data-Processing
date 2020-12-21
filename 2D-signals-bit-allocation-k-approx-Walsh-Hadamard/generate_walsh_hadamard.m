% generate_walsh_hadamard: creates N's hadamard-walsh matrix
% - N @param: recursive index of the matrix to create
% - pcw_fs @return: the N-th hadamard-walsh matrix by rearranging the
% hadamard N-th matrix
function [WH]= generate_walsh_hadamard(N)
H = generate_hadamard(N); %create N-th hadamard matrix
tmp = generate_hadamard(N)>0;
%extract the correct indices by counting the sign change by using xor of
%each element and its following element in the matrix, thus the count is
%the index
idx = sum(xor(tmp(:,1:N-1), tmp(:,2:N)), 2)+1; 
WH(idx,:) = H; % rearranging accordingly to the counts-indices
end
