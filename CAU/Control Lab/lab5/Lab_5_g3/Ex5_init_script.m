load('par.mat')
rng(1)  % seed for rand so we get the same results from rand each time


% Initial conditions for exercise 5.2 
par.p = [1; 8.5; 4; 5; ]; % Hurwitz polynomial coefficients

par.timeStep = 0.001;

% Initial conditions for exercise 5.3 
par.ex5_3_iii_x0 = [ 0.5; 0.1;];
par.ex5_3_iii_x0_hat = [rand*par.ex5_3_iii_x0; [1;0;0;0]]; % choose a different initial condition
par.ex5_3_iv_x_ref = [ 1; 0 ]; % an arbitrary, fixed point
par.ex5_3_iv_k = [-2.1407, -1.1417]; % feedback control gain
 
par.R = eye(1)*10;         % Measuremeant covariance matrix
par.Q = eye(2)*10e-2;      % Process covariance matrix

% Initial conditions for exercise 5.4 
par.p0 = 20;
par.p1 = 8;

par.ex5_4_x0_hat = par.ex5_3_iii_x0_hat;
par.ex5_4_x0 = [0; 0];
