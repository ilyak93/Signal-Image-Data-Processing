function [Dirichlet_Energy_x ,Dirichlet_Energy_y ] = CalcFunctionDirichletEneries(func, deltaX, deltaY)
[Derivative_by_x ,Derivative_by_y ] = DO2Derive(func, deltaX , deltaY);
Dirichlet_Energy_x = TwoDIntegral_t(Derivative_by_x.^2,deltaX , deltaY);
Dirichlet_Energy_y = TwoDIntegral_t(Derivative_by_y.^2,deltaX , deltaY);
end