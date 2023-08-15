%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Introduction in Matlab/Simulink
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This sample file mainly explains the functionality of the Control System 
% Toolbox (CST). This toolbox is mainly used in control engineering tasks. 
% Starting point for the use of the CST is a mathematical model of the 
% considered system. In general, only linear time-continuous and time-discrete 
% problems are considered. 

clear all
close all
clc
%%
help control  % Important: The help for the Control Systems Toolbox

%%

% Creating data objects in the CST
% A simple PT2 element is considered

T = 0.5;
xi = 0.2;
V = 2;

% 1st possibility: transfer function

G_tf = tf([V],[T^2 2*xi*T 1])

% Access to the data object

G_tf.num{1}   % Zähler
G_tf.den{1}   % Denominator
G_tf.Variable % Variable

% Alternative (to be used preferably)

s = tf('s')   % Creating the complex variables s
G_tf1 = V/(1+2*xi*T*s+s^2*T^2)


% 2nd possibility: via pole zero representation

p1 = (-xi+sqrt(xi^2-1))/T;
p2 = (-xi-sqrt(xi^2-1))/T;
G_zp = zpk([],[p1 p2],V/T^2)

% Access to the data object

G_zp.z{1}   % Zeros
G_zp.p{1}   % Poles
G_zp.k      % Poles
G_zp.Variable % Variable


% 3rd possibility: state space representation

A = [0 1; -1/T^2 -2*xi/T];
B = [0;V/T^2];
C = [1;0];
D = 0;

sys = ss(A,B,C',D)


% Access to the data object

sys.a   % Dynamics matrix
sys.b   % Input matrix
sys.c   % Output matrix
sys.d   % Feed-through matrix
sys.StateName % Name of the states


% 4th possibility: Numerical input of measured transfer functions, 
% not discussed here

% Convert objects to other display formats

G_ss2tf = tf(sys)
G_spk2tf = tf(G_zp)

sys_zpk2ss = ss(G_zp)
sys_tf2ss = ss(G_tf)

G_ss2zpk = zpk(sys)
G_tf2zpk = zpk(G_tf)

% Additional possibilities
help ss2tf
help ss2zp
help zp2tf
help zp2ss
help tf2zp
help tf2ss

%%
% Discrete models
% These can basically be generated as before, but a sampling time must be 
% specified

Ta = 0.2; % Specification of a sampling time

% Direct creation

z = tf('z',Ta)
Gzt = 1/(z-0.5);    % As transfer function
sysd = ss(1,1,1,0,Ta) % As State-Space (here: discrete integrator)         

% From existing continuous model

Gz = c2d(G_tf,Ta,'zoh')    % A zero-order hold element is used here
sys_z = c2d(sys,Ta,'zoh')

% Models in the Tustin domain (q domain, bilinear transform)

Gq = d2c(Gz,'tustin')
sys_q = d2c(sys_z,'tustin')
%%

% Models with delay times

G_tzi = tf(1,[1 1],'inputdelay',0.5)   % Input delay
G_tzo = tf(1,[1 1],'outputdelay',0.5)  % Output delay
G_tzio = tf(1,[1 1],'iodelay',0.5)     % Input output delay


%%

% Linking of models
G2 = 1/s;

Gsum = G_tf+G2    % Sum of the models
Gdiff = G_tf-G2   % Difference of the models
Gprod = G_tf*G2   % Series connection of the models
Gfb = feedback(G_tf,G2) % Feedback

%%

% Analysis of LTI models

dcgain(G_tf)    % Determine amplification factor
damp(G_tf)      % Natural frequencies and damping
bandwidth(G_tf) % bandwidth

pole(G_tf)      % Poles of the transfer function
zero(G_tf)      % Zeros of the transfer function

pzmap(G_tf*(s-.1))     % Pole zero diagram
grid on

figure
impulse(G_tf,10)    % Impulse response for 10 seconds
hold on
step(G_tf,10)       % Step response for 10 seconds

% System response to arbitrary input signal

[u,t] = gensig('square',1,10);   % Generation of a test signal 
[y,t] = lsim(G_tf,u,t);          % Simulation of the system with the input signal

figure
plot(t,u,t,y)
grid on

% Solution in steady state

H = freqresp(G_tf,2)     % Evaluation at position omega = 2

% Bode plot

figure
bode(G_tf)
[abs,pha,omega] = bode(G_tf); % Reading the data from the Bode plot
[abs,pha,omega] = bode(G_tf,2); % Bode plot at position omega = 2

% Nyquist diagram

figure
nyquist(G_tf)
grid on

% Order reduction of systems

minreal((s+1)/(s+1)/s)  % Execute pole zero cancellation

%%

% Controller and observer design: In this introduction only the basic principles
% of controller and observer design will be mentioned, the application will be
% described in later chapters

% Open loop analysis

allmargin(G_tf/s)       % Characteristic values for the open loop in the frequency characteristic method



A = [-1 2; 0 -2];
B = [0;1];
C = [1;0];
D = 0;

sysr = ss(A,B,C',D)

ctrb(A,B)  % Reachability matrix
obsv(A,C') % Observability Matrix

gram(sysr,'c') % Gram's reachability matrix
gram(sysr,'o') % Gram's observability matrix

acker(A,B,[-10 -11]) % Pole specification 
place(A,B,[-10 -11]) % Pole specification

