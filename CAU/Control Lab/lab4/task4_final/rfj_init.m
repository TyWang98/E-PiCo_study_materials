clear

load('param.mat')
param.x0 = [0,0,0,0].';
param.delta_x_est0 = [0.2; 0.1; 0; 0];

param.kr = 0.3895;

param.J_Bzz = 0.00341;
param.l_G = 0.172;

param.beta = 4;
param.lambda_R0 = 0;
param.lambda_R1 = pi;
param.t_0 = 1;
param.t_1 = 2;
param.T = 8;

% syms t lambda_R0 lambda_R1 t_0 t_1;
% 
% lambda_ref = lambda_R0;
% 
% for i = beta+1 : 2*beta+1
%     p_i = ( (-1)^(i- beta -1)*factorial(2*beta+ 1) )/( i*factorial(beta)*factorial(i-beta-1)*factorial(2*beta+1-i) );
%     lambda_ref = lambda_ref+ (lambda_R1- lambda_R0)* p_i* ( (t-t_0)/(t_1-t_0) )^i;
% end
% 
% xi = lambda_ref;
% for j = 2:beta+1
%     xi(j) = diff(xi(j-1),t);
% end

syms r
% Assign an arbitrary Hurwitz polynomial for the feedback controller
expand((r+1+i)*(r+1-i)*(r+10)*(r+11)*(r+12)) % poles design
param.p01 = 2640;
param.p11 = 3364;
param.p21 = 2110;
param.p31 = 430;
param.p41 = 35;
% Assign an arbitrary Hurwitz polynomial for the observer
expand((r+12+i)*(r+12-i)*(r+13)*(r+14)) % poles design
param.p02 = 26390;
param.p12 = 8283;
param.p22 = 975;
param.p32 = 51;
