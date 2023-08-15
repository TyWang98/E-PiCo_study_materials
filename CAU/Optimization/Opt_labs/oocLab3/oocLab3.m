close all;
clear all;
% clc;

x0 = [0 0 0 0]'; % initial state 
xf = [0 0 pi 0]'; % final state
N  = 50; % number of discretization steps
tf = 1; % final time
nx = 4; % number of states
nu = 1; % number of inputs
% !!!!!!!!!!!!!!!!!!! This is your task in ex 1 (i) !!!!!!!!!!!!!!!!!!! 
nwx = nx*(N+1); % number of state decision variables
nwu = nu*(N+1); % number of input decision variables

% pendulum parameters
g=9.81;l=0.3;m=0.2;M=0.5;J=0.006;b=0.1;

% pass paramters to struct
param.N   = N;
param.tf  = tf;
param.g   = g;
param.l   = l;
param.m   = m;
param.M   = M;
param.J   = J;
param.b   = b;
param.nx  = nx;
param.nu  = nu;
param.nwx = nwx;
param.nwu = nwu;
param.x0  = x0;
param.xf  = xf;

% (anonymous) function handles
handles.fFun = @(x,u)rhsPendulum([],x,[],u,param);

% initial guess
tu = linspace(0,tf,3);
u  = -.53*ones(1,3);

% !!!!!!!!!!!!!!!!!!! This is your task in ex 1 (iii) !!!!!!!!!!!!!!!!!!! 
[t_sol, x_sol] = ode45(@(t,x)rhsPendulum(t,x,tu,u,param),0:tf/N:tf,x0);

wu = interp1(tu,u,linspace(0,tf,nwu)); % this "maps" the three given inputs 
                                       % to the expected length of nwu
wx = x_sol';
w0 = [wx(:);
      wu(:)];

options = optimoptions('fmincon','Display','iter','Algorithm','sqp','MaxFunctionEvaluations',25e5,'MaxIterations',1e3);

% fmincon call, part of (vi)
% Note that in Octave, this can take ~5 minutes to solve...
[wOpt,fOpt,exitFlag,out] = fmincon(@(w_)cost(w_,param,handles),w0,[],[],[],[],[],[],@(w_)nonlcon(w_,param,handles),options);

% This is your task in ex1 (vi)



%%
function dxdt_ = rhsPendulum(t_,x_,tu_,u_,param_)
    g = param_.g;
    l = param_.l;
    m = param_.m;
    M = param_.M;
    J = param_.J;
    b = param_.b;
    if ~isempty(t_)
       u = interp1(tu_,u_,t_,'previous');  % zero order hold
    else
       u = u_;
    end
    % nonlinear 1 (matlab)
    dxdt_ = [x_(2);
		     ((-l^3*m^2-J*l*m)*sin(x_(3))*x_(4)^2-g*l^2*m^2*cos(x_(3))*sin(x_(3))+(b*l^2*m+J*b)*x_(2)+(-l^2*m-J)*u)/(l^2*m^2*cos(x_(3))^2-l^2*m^2+(-M*l^2-J)*m-J*M);
             x_(4);
		     -(-l^2*m^2*cos(x_(3))*sin(x_(3))*x_(4)^2+(-g*l*m^2-M*g*l*m)*sin(x_(3))+b*l*m*x_(2)*cos(x_(3))-l*m*u*cos(x_(3)))/(l^2*m^2*cos(x_(3))^2-l^2*m^2+(-M*l^2-J)*m-J*M)];
end


function c_ = cost(w_,param_,handles_)
    % parameter
    nx    = param_.nx;
    nu    = param_.nu;
    nwx   = param_.nwx;
    nwu   = param_.nwu;
    N     = param_.N;
  
    % !!!!!!!!!!!!!!!!!!! This is your task in ex 1 (iv) !!!!!!!!!!!!!!!!!!! 
    wu = w_(end-N: end);
    c_ = -0.5*(wu(1)^2+wu(end)^2) + sum(wu.^2);
end

function [h_, g_] = nonlcon(w_,param_, handles_)
    % parameter
    nx    = param_.nx;
    nu    = param_.nu;
    nwx   = param_.nwx;
    nwu   = param_.nwu;
    tf    = param_.tf;
    N     = param_.N;
    x0hat = param_.x0;
    xf    = param_.xf;
    % handles
    fFun  = handles_.fFun;
    
    h_ = []; % no inequality constraints
    % !!!!!!!!!!!!!!!!!!! This is your task in ex 1 (v) !!!!!!!!!!!!!!!!!!! 
    wx = reshape(w_(1:end-N-1),4,[]); % 4 by N+1
    wu = w_(end-N: end); % N+1 by 1
    g_bc = [wx(:,1) - x0hat; wx(:,end) - xf]; % 4 * 2
    g_ode = zeros(4,N); % 4 by N
    for k = 1:N
        g_ode(:,k) = -wx(:,k+1) + wx(:,k) + tf/N/2*( fFun( wx(:,k), wu(k) ) + fFun( wx(:,k+1), wu(k+1) ));
    end
    g_ = [g_bc; g_ode(:)];
end
