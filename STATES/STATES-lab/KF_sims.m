close all
clear; clc; 

%% 2.1 Input voltage
D = 0.5;        % duration         
A = 0.1;        % peak-to-peak amplitude 
Delta = 100e-3; % period
Ts = 1e-3;      % sample time   

u = inputvoltage(D, A, Delta, Ts);

%% 2.2 System modeling and simulation
G = 50;        
T = 20e-3;
L = 512;    % L angles per lap
x1 = [0;0];   
[y,x] = simulate(u,G,T,Ts,L,x1);

%% 2.3 Kalman filter
r = (2*pi/L)^2/12;
x1_0 = zeros(2,1);
x1_0(1) = -0.05;  % estimation of theta_0       
x1_0(2) = 0;         
var_theta = (2*pi)^2/12;
var_Omega= 0;
P1_0 = [var_theta, 0; 0, var_Omega];  

%% 2.4 Simulations
T = 20e-3;
xe_1 = kal(y, u, G, T, Ts, L, x1_0, P1_0, 1e-10);
xe_2 = kal(y, u, G, T, Ts, L, x1_0, P1_0, 1e-5);
xe_3 = kal(y, u, G, T, Ts, L, x1_0, P1_0, 1e-1);
t = 0:Ts:D;
figure(1);
subplot(211);
plot(t, x(:,1),'y','LineWidth',1.5); hold on
plot(t, xe_1(:,1),'LineWidth',0.8)
plot(t, xe_2(:,1),'LineWidth',0.8)
plot(t, xe_3(:,1),'LineWidth',0.8) 
hold off
legend('actual \theta','q=10^{-10}','q=10^{-5}','q=10^{-1}')
title('Simulation result of Kalman filter with perfect model')
xlabel('\ittime \rm(s)');
ylabel('\theta (rad)')
subplot(212);
plot(t, x(:,2),'y','LineWidth',1.5); hold on
plot(t, xe_1(:,2),'LineWidth',0.8)
plot(t, xe_2(:,2),'LineWidth',0.8)
plot(t, xe_3(:,2),'LineWidth',0.8)
hold off
legend('actual \Omega','q=10^{-10}','q=10^{-5}','q=10^{-1}')
xlabel('\ittime \rm(s)'); 
ylabel('\Omega (rad/s)');
