function [opt] = bitBudgetOptim(func, B, Dirichlet_Energy_x, Dirichlet_Energy_y, delta_phi)
    lb = [eps , eps, eps, B];
    ub = [Inf, Inf, Inf, B];
    options = optimoptions('fmincon','Display','off');
    opt = (fmincon(func,[1,1,1,B],[],[],[],[],lb,ub,@bitBudgetLimitCond,options));
    
    opts = zeros(8,3);
    MSEs = zeros(8);
    % create all the possibilities for floor and ceil for the parameters
    opts(1,:) = ceil(opt(1:3));
    opts(2,:) = [ceil(opt(1:2)), floor(opt(3))];
    opts(3,:) = [ceil(opt(1)), floor(opt(2:3))];
    opts(4,:) = [floor(opt(1:3))];
    opts(5,:) = [floor(opt(1:2)), ceil(opt(3))];
    opts(6,:) = [floor(opt(1)), ceil(opt(2:3))];
    opts(7,:) = [ceil(opt(1)), floor(opt(2)), ceil(opt(3))];
    opts(8,:) = [floor(opt(1)), ceil(opt(2)), floor(opt(3))];
    %filter only those which doesn't exceed the budget
    opts = opts(opts(:,1).*opts(:,2).*opts(:,3) <= B, :);
    
    inputs = num2cell(opts, 2); % Collect the rows into cells
    MSEs = cellfun(func, inputs); % calculate the MSE for each and return the minimal trio params
    [~, idx] = min(MSEs);
    opt = opts(idx,:);
end
