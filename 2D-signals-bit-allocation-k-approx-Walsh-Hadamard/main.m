function main(omega_x, omega_y)
% HW2 main file

% First we define some constants
continuous_approx_delta = 0.001;
A = 2500;

% Create the digital version of phi_1 - Item b.
grid = 0:continuous_approx_delta:1;
[x_grid,y_grid] = meshgrid(grid,grid);
phi_1_xy = A*sin(2*pi*omega_x*x_grid).*cos(2*pi*omega_y*y_grid);

% Display phi_1 as an image
figure(1);
imshow(phi_1_xy,[-2500,2500]);
title('\phi_1 (x,y)=2500\cdot sin(2\cdot\pi\omega_x\cdot x)\cdot cos(2\cdot\pi\omega_y\cdot y) ');

% Calculate bit-allocation problem parameters numerically - Item c.
phi_H = max(max(phi_1_xy));
phi_L = min(min(phi_1_xy));
delta_phi = phi_H - phi_L;
[Nxcont, Nycont] = size(phi_1_xy);
[Dirichlet_Energy_x,Dirichlet_Energy_y] = CalcFunctionDirichletEneries(phi_1_xy,1/Nxcont, 1/Nycont);

(fprintf('phi_H - phi_L = %d\n',delta_phi));
(fprintf('Energy( phi _x `) = %f\n', Dirichlet_Energy_x));
(fprintf('Energy( phi _y `) = %f\n', Dirichlet_Energy_y));

% Calculate numerical approximation of bit_budget solution - Item d+e.
B=5000;
MSE = @(x) ((1/(12*(x(1)^2)))*Dirichlet_Energy_x + ... 
                (1/(12*(x(2)^2)))*Dirichlet_Energy_y + ...
                (1/12)*((delta_phi)^2/(2^(2*x(3)))));
opt_5000 = bitBudgetOptim(MSE, B, Dirichlet_Energy_x, Dirichlet_Energy_y, delta_phi);
fprintf('Numeric method approx. - Bit budget = %d, Nx = %f, Ny = %f, b =%f\n',B,opt_5000(1),opt_5000(2),opt_5000(3));
fprintf('The MSE = %f\n',MSE(opt_5000));
figure(2);
X1 = ApplyBitBudget(phi_1_xy,opt_5000(1),opt_5000(2),opt_5000(3));
imshow(X1,[min(min(X1)),max(max(X1))]);
title('Numeric approximation of bit-budget problem solution with bit-budget = 5000');

B = 50000;
opt_50000 =  bitBudgetOptim(MSE, B, Dirichlet_Energy_x, Dirichlet_Energy_y, delta_phi);
fprintf('Numeric method approx. - Bit budget = %d, Nx = %f, Ny = %f, b =%f\n',B,opt_50000(1),opt_50000(2),opt_50000(3));
fprintf('The MSE = %f\n',MSE(opt_50000));
figure(3);
X2 = ApplyBitBudget(phi_1_xy,opt_50000(1),opt_50000(2),opt_50000(3));
imshow(X2,[min(min(X2)),max(max(X2))]);
title('Numeric approximation of bit-budget problem solution with bit-budget = 50000');



% find practical solution for the bit-budget problem - Item f+g.
% Bitbudget = 5000
B = 5000;
best_params = searchBestParams(MSE,B); 
fprintf('Partical sol. - Bit budget = %d, Nx = %f, Ny = %f, b =%f\n',B,best_params(1),best_params(2),best_params(3));
fprintf('The MSE = %f\n',MSE(best_params));
figure(4);
X3 = ApplyBitBudget(phi_1_xy,best_params(1),best_params(2),best_params(3));
imshow(X3,[min(min(X3)),max(max(X3))]);
title('Practically found solution for bit-budget problem with B=5000');


% Again for 50000
B = 50000;
best_params = searchBestParams(MSE,B);
fprintf('Partical sol. - Bit budget = %d, Nx = %f, Ny = %f, b =%f\n',B,best_params(1),best_params(2),best_params(3));
fprintf('The MSE = %f\n',MSE(best_params));
figure(5);
X4 = ApplyBitBudget(phi_1_xy,best_params(1),best_params(2),best_params(3));
imshow(X4,[min(min(X4)),max(max(X4))]);
title('Practically found solution for bit-budget problem with B=50000');
end