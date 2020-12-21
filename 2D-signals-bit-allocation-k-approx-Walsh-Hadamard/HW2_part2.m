% HW2 main file
close all; clear all; clc;
% Section a
disp('Part 2');
n=2;
N=2^n;

H = generate_hadamard(N);

pwf_v = create_pcw_functions(-16,16,N);

%calculating Hadamard functions by multiplicating with pieacewise constant functions
H_functions = H*pwf_v; 
%plotting the functions
for i=1:8:N
    figure(1000+i);
    title('Hadamard functions');
    hold on
    for j=i-1:i+7
        if j+1 > size(H_functions)
            break
        end
        sb = subplot(3,3, mod(j,8)+1);
        fplot(H_functions(j+1), [-20 20]);
        xticks([-20:20]);
        ylim([-1.5 1.5]);
        set(sb,'FontSize',5);
        grid(sb,'on');
        str = sprintf('%d-th function of n=%d',j+1,n);
        title(str)
    end
end

W = generate_walsh_hadamard(N);

pwf_v = create_pcw_functions(-16,16,N);
%calculating Walsh-Hadamard functions by multiplicating with pieacewise constant functions
W_functions = W*pwf_v;
%plotting the functions
%plotting the functions
for i=1:8:N
    figure(2000+i);
    title('Walsh-Hadamard functions');
    hold on
    for j=i-1:i+7
        if j+1 > size(W_functions)
            break
        end
        sb = subplot(3,3, mod(j,8)+1);
        fplot(W_functions(j+1), [-20 20]);
        xticks([-20:20]);
        ylim([-1.5 1.5]);
        set(sb,'FontSize',5);
        grid(sb,'on');
        str = sprintf('%d-th function of n=%d',j+1,n);
        title(str)
    end
end



left = -4;
right = 5;

%using symbolic param t
syms t
phi_t = t*exp(t);
phi_t_vec = sym('delta_',[N 1]);
for i=1:N
    phi_t_vec(i) = phi_t;
end
%a vector of phi functions for vectorizing the calculations
phi_t_vec = phi_t_vec.';
%pieacewise constant function within the interval [left,right]
pwf_v = create_pcw_functions(left,right,N);
%Hadamard-Walsh functions by multiplicating pieacewise and HW 
HW_functions = W*pwf_v;
%calculating the integrated vector of elements for vectorising the integral
hw_pwc_mul = phi_t_vec.*HW_functions.';
%vectorized normilized integral within the the interval [left,right] 
coefs = int(hw_pwc_mul, left, right)*(1/(right-left)); % normilized coeficients
%sorting by absolute value
a = eval(abs(coefs));
[~,idx] = sort(a, 'descend');
coefs = coefs(idx); %sorted coeficients
HW_functions = HW_functions(idx); %sorted accordingly Walsh-Hadamard functions

best_MSE = inf;
best_k = inf;
MSE = zeros(1,4);
for k=1:N
   k %printing k
   %choosing the k coeficients and functions
   cur_coef = coefs(1:k);
   cur_W_functions = HW_functions(1:k);
   % calculating phi approximated by sum over the multiplications of
   % sorted coefficients and sorted functions 
   phi_approx = cur_coef*cur_W_functions;
   % calculating the MSE by using the normilized integral of the difference
   % of phi=t*exp(t) and phi_approximated.
   MSE(k) = int((phi_t-phi_approx)^2,left,right)*(1/(right-left)); % normilized MSE
   MSE(k)
   %plotting k-approx graph
   figure(200+k); 
   fplot(phi_approx)
   str = sprintf('%d-term approximation with MSE=%f', k, MSE(k));
   title(str);
   xticks([-10:10]);
   ylim([-100 300]);
   %saving the best approximation
   if MSE(k) < best_MSE
       best_MSE = MSE(k);
       best_k = k;
   end
end

%plot MSE(k)
%plotting the (k,MSE(k)) function
figure(400);
hold on;
title('MSE(k)');
xlabel('k');
ylabel('MSE');
plot([1:4], MSE);
hold off;

%plot best approximation
best_coef = coefs(1:best_k);
best_W_functions = HW_functions(1:best_k);
best_phi_approx = best_coef*best_W_functions;
figure(300+10); 
title(k+'-term approximation (best)');
fplot(best_phi_approx)