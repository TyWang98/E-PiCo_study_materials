%--------------------------------------------------------------
% M.Sc. Laboratory Advanced Control - Experiment 2 
%--------------------------------------------------------------

%--------------------------------------------------------------
% Simulation of the PT2-element
%--------------------------------------------------------------

clear all
close all 
clc

% 1st possibility: Block diagram
% Parameter
T = 0.5;
xi = 0.2;
V = 2;
Ta = 0.1;

% 2nd possibility: State representation
A = [0 1; -1/T^2 -2*xi/T];
B = [0;V/T^2];
C = [1;0];
D = 0;

% 3rd possibility: Transfer function
G_tf = tf([V],[T^2 2*xi*T 1])

% 4th possibility: Control System Toolbox
sys = ss(A,B,C',D)

