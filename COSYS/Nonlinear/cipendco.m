% Initialization file
% 
% State variables
% x1 trolley position 
% x2 trolley velocity 
% x3 pendulum angle
% x4 pendulum angular velocity

format long e;

global M
% Trolley mass
M=2.4 ;
% Pendulum mass
m=0.23 ;
% Distance from the CoG of the pendulum
l=0.36 ;
% gravity
g=9.81 ;
% viscous friction 
fc = 7.96 ;
% Inertia
J = 0.099 ;
% Coefficien a
a = m/(M+m) ;
%
%
%
%return
%
%
% Calcul des gains du retour d'?tat
%
bet = -(J+m*l^2)/m/l;
p1 = -3 ;
p2 = -1 ;
%
f4 = 2*p1*p2*(p1+p2)/g 
f3 = -(p1*p2)^2/g 
f2 = 2*(p1+p2)-bet*f4 
f1 = -(p1^2+p2^2+4*p1*p2)-bet*f3 

F = [f3 ; f4 ; f1 ; f2]';

r=(J+m*l^2)/(m*l);
%
%
% Calcul des gains du retour d'?tat
%
A=[0 1 0 0
    0 0 g 0
     0 0 0 1
     0 0 0 0]
 
 B=[0;-r;0;1]
 
 poles = [ -1 ; -.5 ; -3 ; -1.5];

 
% poles=[-.5 -0.5 -3 -3]
 
 K=-acker(A,B,poles)
 
 k0_x1 = K(1);
 k1_x1 = K(2);
 k0_x3 = K(3);
 k1_x3 = K(4);
 
 F = K;
 

 
 





