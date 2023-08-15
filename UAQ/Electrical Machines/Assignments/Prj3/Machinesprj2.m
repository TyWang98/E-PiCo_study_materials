clc;
clear;
close all

P = 64;
J = 35.1e6; % unit: J.s^2
Vs_abc = 20e3*sqrt(2)/sqrt(3); % unit: V
f_abc = 60; % unit: Hz
% theta_r0 = 30*pi/180;
theta_r0 = 0;
theta_e0 = theta_r0*P/2;

% Nfd = 10; % not given
% Ns = 100; % not given
wb = 112.5*2*pi/60; % rated/base frequency unit: rad/s
web = P/2*wb;

Rs = 0.00234;
Rkq1 = 0.01675; % open circuit
Rkq2 = 0.01675;
Rf = 0.00050;
Rkd = 0.01736;

Lq = 0.5911/web;
Ld = 1.0467/web;
Lls = 0.1478/web;
Lmd = Ld - Lls;
Lmq = Lq - Lls;

%Vfd = 19.5e3*Rf/(Lmd*wb)*sqrt(2)/sqrt(3); 
Vfd = 6; % assumed according to the output graph

% Here the superscript ' is omitted  
Llkq1 = 0.1267/web; % open circuit
Llkq2 = 0.1267/web;
Llf = 0.2523/web;
Llkd = 0.1970/web;

R = eye(7);
[R(1,1),R(2,2),R(3,3),R(4,4),R(5,5),R(6,6),R(7,7)] = deal(Rs,Rs,Rs,Rkq1,Rkq2,Rf,Rkd);

%L = eye(7).*[Lq Ld Lls Llkq1+Lmq Llkq2+Lmq Llf+Lmd Llkd+Lmd];
L = eye(7);
[L(1,1),L(2,2),L(3,3),L(4,4),L(5,5),L(6,6),L(7,7)] = deal(Lq,Ld,Lls,Llkq1+Lmq,Llkq2+Lmq,Llf+Lmd,Llkd+Lmd);
[L(1,4),L(1,5),L(4,1),L(5,1),L(4,5),L(5,4)] = deal(Lmq);
[L(2,6),L(2,7),L(6,2),L(7,2),L(6,7),L(7,6)] = deal(Lmd);

Jmatrix = zeros(7);
Jmatrix(1,2) = 1;
Jmatrix(2,1) = -1;

invL = inv(L);
JL = Jmatrix*L;

Ti = 27.6e6; % Input torque unit: N.m

%% initial current calculation %%
% here assume initial current is equal to steady state current
Vqs = Vs_abc*cos(theta_e0 - P/2*theta_r0);
Vds = -Vs_abc*sin(theta_e0 - P/2*theta_r0);
syms ids iqs;
fcn1 = Rs*iqs + web*Ld*ids -Vqs;
fcn2 = Rs*ids - web*Lq*iqs -Vds;
[ids,iqs] = solve(fcn1,fcn2);
ids = double(ids);
iqs = double(iqs);
ids = 0;
iqs = sqrt(7.9674e+03);
i_f = Vfd/Rf;
