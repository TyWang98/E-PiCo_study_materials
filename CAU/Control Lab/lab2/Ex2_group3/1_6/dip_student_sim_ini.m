%--------------------------------------------------------------
% Master laboratory - Exercise 2 
%--------------------------------------------------------------
clear all

% Parameters
l1 = 0.323;         % [m]      
l2 = 0.48;          % [m]      
l_S1 = 0.1870;      % [m] 
l_S2 = 0.1940;      % [m] 
m_G1 = 0.8810;      % [kg]     
m_G2 = 0.5510;      % [kg]     
J_G1xx = 0.0134;    % [Nms^2]  
J_G2xx = 0.0208;    % [Nms^2]  
k_G1 = 0.0032;      % [Nms] 
k_G2 = 0.0012;      % [Nms] 
g = 9.81;           % [m/s^2]

par = [l1,l2,l_S1,l_S2,m_G1,m_G2,J_G1xx,J_G2xx,k_G1,k_G2,g];

%  Initial states - stable idle state down-down
xR = 0; 
dxR = 0;
phi1R = pi/2; 
dphi1R = 0; 
phi2R = pi/2;
dphi2R = 0;

x0 = [xR; 0; phi1R; 0; phi2R; 0];
