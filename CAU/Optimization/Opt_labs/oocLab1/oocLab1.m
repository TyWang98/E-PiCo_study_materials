clear all
close all

global funCounter;
global gradfunCounter;

funCounter = 0;
gradfunCounter =0;

% Starting value for iterations
xStart = [-1 -1]';

% Pass problem function handles to struct
handles.fFun     = @rosen;
handles.gradfFun = @gradRosen;
handles.hessianFun = @hessianRosen;

% Line search parameters
% general parameters
param.maxIter = 1500;   % maximum number of iterations
param.tol     = 1e-5;   % stopping criterion for norm of step
param.xStart  = xStart; % starting point for x
% search direction parameter
param.sk.method = 'quasiNewton'; 
% step length method
param.alphak.method = 'wolfe';
param.alphak.wolfe.epsilon0 = .7;
param.alphak.wolfe.alpha0   = 5;
param.alphak.wolfe.rho      = .8;
% beta formula in conjugated gradient (CG) method
param.betak.method = 'PR';

% Execute line search
res = lineSearch(handles, param)

%% 
% Plotting
% function handle for easy plotting
rosenPlot=@(x1,x2) (100.0 * (x2 - x1.^2).^2 + (x1 - 1).^2);
z = rosenPlot(res.iter.x(1,:),res.iter.x(2,:));
% !!!!!!!!!!The rest is your task in exercise 1 (i)!!!!!!!!!!
fsurf(rosenPlot, [-2, 2])
hold on
plot3(res.iter.x(1,:),res.iter.x(2,:),z,'Color','red')
hold off
%% 


function f_ = rosen(x_)
  global funCounter;
  funCounter = 1 + funCounter;
  f_ =  (100*(x_(2) - x_(1)^2)^2 + (x_(1) - 1)^2);
end

function gradf_ = gradRosen(x_)
  global gradfunCounter;
  gradfunCounter = 1 + gradfunCounter;
  gradf_ =  [-400*(x_(2) - x_(1)^2)*x_(1) + 2*(x_(1) - 1);
              200*(x_(2) - x_(1)^2)];
end 

function hessianf_ = hessianRosen(x_)
  hessianf_ = [1200*x_(1)^2-400*x_(2), -400*x_(1); -400*x_(1), 200;];
end
