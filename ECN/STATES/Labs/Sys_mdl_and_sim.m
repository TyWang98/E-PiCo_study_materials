close all
clear; clc; 

%% 2.1 Input voltage
D = 0.5;        % duration         
A = 0.1;        % peak-to-peak amplitude 
Delta = 100e-3; % period
Ts = 1e-3;      % sample time   

u = inputvoltage(D, A, Delta, Ts);

% Plot
t = 0:Ts:D;
figure(1)
plot(t,u,'LineWidth',1); 
title('Input voltage');
xlabel('\ittime \rm(s)'); 
ylabel('\itVoltage \rm(V)');
ylim([-0.06 0.06]);

%% 2.2 System modeling and simulation
G = 50;        
T = 20e-3;
L = 512;    % L angles per lap
x1 = [0;0];   
[y,x] = simulate(u,G,T,Ts,L,x1);

%% Plot
figure(2)
subplot('211'); 
plot(t, x(:,1), t, y,'LineWidth',0.8);  
title('Angular position (rad)');
legend('actual \theta','measured \ity');
subplot('212')
plot(t, x(:,2),'LineWidth',1); 
title('Angular velocity');
xlabel('\ittime \rm(s)'); 
ylabel('\Omega (rad/s)');