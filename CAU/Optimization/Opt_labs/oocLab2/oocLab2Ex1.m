clear all
close all

% Starting value for iterations
xStart   = [-1 -1]';
lamStart = 1;

% Pass problem functions to struct
handles.fFun     = @rosen;
handles.gradfFun = @gradRosen;
handles.hessfFun = @hessRosen;
handles.gFun = @equality;
handles.gradgFun = @gradEquality;
handles.hessgFun = @hessEquality;

% general parameters
param.maxIter  = 1500;   % maximum number of iterations
param.tol      = 1e-6;   % stopping criterion for norm of step
param.xStart   = xStart; % starting point for x
param.lamStart = lamStart; % starting point for lambda

% Execute sqp
res = sqp(handles, param)

% Plotting
% function handle for easy plotting
rosenPlot = @(x1,x2) (100.0 * (x2 - x1.^2).^2 + (x1 - 1).^2);
gPlot     = @(x1)(x1 + 3).^3 +1;


% if you use matlab, copy this to the end of the script
function f_ = rosen(x_)
  f_ =  (100*(x_(2) - x_(1)^2)^2 + (x_(1) - 1)^2);
end

function gradf_ = gradRosen(x_)
  gradf_ =  [-400*(x_(2) - x_(1)^2)*x_(1) + 2*(x_(1) - 1);
              200*(x_(2) - x_(1)^2)];
end 
function hessianf_ = hessRosen(x_)
  x1 = x_(1);
  x2 = x_(2);
  hessianf_ = [1200*x1^2 - 400*x2 + 2,  -400*x1; 
                -400*x1,     200];
end
function g_ = equality(x_)
    g_ = (x_(1) + 3)^3 - x_(2) + 1 ;
end
function gradg_ = gradEquality(x_)
    gradg_ = [3*(x_(1) + 3)^2;
                -1];
end
function hessiang_ = hessEquality(x_)
    hessiang_ = [6*x_(1) + 18, 0;
                 0,  0];
end

