%--------------------------------------------------------------
%  M.Sc. Laboratory Advanced Control - Experiment 2 
%--------------------------------------------------------------

%--------------------------------------------------------------
% Simulation of the tower crane
%--------------------------------------------------------------

clear all

%--------------------------------------------------------------
% State vector 
%--------------------------------------------------------------
% x_tdk = [l_W
%          l_s
%          phi_zi
%          phi_xt
%          phi_yt 
%          dot(l_W)
%          dot(l_s)
%          dot(phi_zi)
%          dot(phi_xt)
%          dot(phi_yt)
%          ];

% l_W          Position of the car [m]
% l_s          Rope length [m]
% phi_zi       Angle of the tower [rad]
% phi_xt       Angle of the mass (x-axis) [rad]
% phi_yt       Angle of the mass (y-axis) [rad]
% dot(l_W)     Velicuty if the car [m/s]
% dot(l_s)     Rope veclocity [m/s]
% dot(phi_zi)  Angular velocity of the tower [rad/s]
% dot(phi_xt)  Angular velocity of the mass (x-axis) [rad/s]
% dot(phi_yt)  Angular velocity of the mass (y-axis) [rad/s]

%--------------------------------------------------------------
% Initial states
%--------------------------------------------------------------
x0_tdk = [0.5 0.5 0 0.1 0 0 0 0 0 0];

%--------------------------------------------------------------
% Model parameters 
%--------------------------------------------------------------
m_M = 1;
m_W = 0.5; 
m_TA = 2; 
k_M = 0.1;
k_TA = 0.1;
k_W = 0.1;
hTA = 2;
lTA = 0.2;
J_TAzz = 0.01;
J_Wzz = 0.001;
g = 9.81; 

par_tdk = [m_M m_W m_TA k_M k_TA k_W hTA lTA J_TAzz J_Wzz g];  

% m_M     Mass m
% m_W     Mass of the car
% m_TA    Mass of the tower-jib unit (TJ-unit)
% k_M     Friction term of the mass
% k_TA    Friction term of the tower-jib unit
% k_W     Friction term of the car
% hTA     Height of the center of gravity of the TJ-unit
% lTA     Distance of the center of gravity of the TJ-unit in y-direction
% J_Wzz   Inertia tensor of the carriage
% J_TAzz  Inertia tensor of the TJ-unit
% g       Acceleration of gravity