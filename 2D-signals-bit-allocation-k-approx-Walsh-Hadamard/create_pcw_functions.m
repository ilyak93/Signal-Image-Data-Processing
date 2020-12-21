% create_pcw_functions: creates N peicewise functions
% - left @param: left bound of the interval
% - right @param: right bound of the interval
% - N @param: number of functions to create
% - pcw_fs @return: vector of N created functions

function [pcw_fs] = create_pcw_functions(left, right, N)
delta_len = 1/N;
syms t % symbolic param
pcw_fs = sym('delta_',[N 1]);
idx = 1;
interval_len = right - left;
step = interval_len*delta_len;
%iterates over the intervals and creating pcw mlb functions with a symbolic param
for i=left:step:right-delta_len
    pcw_fs(idx) = sqrt(N)*piecewise(i <= t < i+step, 1, 0);
    idx=idx+1;
end
end