clearvars
close all
clc

% comment next line for Matlab use
% pkg load control

A=[-2 1 ;0 -3];
B=[0;1];
C=[1 0];
D=0;

Gss=ss(A,B,C,D); % Create state-space model
vp(1)=-2;vp(2)=-3;

x0=[1;10];

t=[0:0.01:3];
[y,t,x]=initial(Gss,x0,t); % x is simulated component

xv=[exp(vp(1)*t)*(x0(1)+x0(2))-exp(vp(2)*t)*(x0(2)),...
exp(vp(2)*t)*(x0(2))]; %  theoretical expression


f1=figure(1);set(f1,'name','x and xv (Open Loop)');
subplot(211), plot(t,x(:,1),'+',t,xv(:,1),'-r')
title('x(1): comparison between simulation "+" and theoretical expression "-r"')
xlabel('\ittime(s)')
legend('simulation result','theoretical value')
subplot(212), plot(t,x(:,2),'+',t,xv(:,2),'-r')
title('x(2): comparison between simulation "+" and theoretical expression "-r"')
xlabel('\ittime(s)')
legend('simulation result','theoretical value')
% 3.1
pf_1=[-5 -5];
pk=[-10 -10];
F_1=-acker(A,B,pf_1)
K=acker(A.',C.',pk).'
% 3.2.1
pf=[-5.0 -5.1];
F=-acker(A,B,pf);
AF=A+B*F;
Gss_F=ss(AF,B,eye(2),D);
[y_F,t,x_F]=initial(Gss_F,x0,t);
%3.2.2
pk_1=[-5.2 -5.3];
pk_2=[-10.0 -10.1];
K_1=acker(A.',C.',pk_1).';
K_2=acker(A.',C.',pk_2).';
A_FK1=[A B*F; K_1*C A-K_1*C+B*F];
A_FK2=[A B*F; K_2*C A-K_2*C+B*F];
B_FK1=[B;B];
B_FK2=[B;B];

Gss_FK1=ss(A_FK1,B_FK1,eye(4),D);
Gss_FK2=ss(A_FK2,B_FK2,eye(4),D);
%3.3
x0_FK1=[1;10;0;0];
t=[0:0.01:3];
[y_FK1,t,x_FK1]=initial(Gss_FK1,x0_FK1,t);

f2=figure(2);set(f2,'name','Section 3.3');
subplot(221), plot(t,x_FK1(:,1),'-',t,x_FK1(:,3),'--r','LineWidth',1)
title('Estimation of x(1)')
xlabel('\ittime(s)')
legend('true value','estimated value')
subplot(222), plot(t,x_FK1(:,2),'-',t,x_FK1(:,4),'--r','LineWidth',1)
title('Estimation of x(2)')
xlabel('\ittime(s)')
legend('true value','estimated value')
subplot(223), plot(t,x_FK1(:,1)-x_FK1(:,3),'LineWidth',1)
title('Estimation error of x(1)')
xlabel('\ittime(s)')
subplot(224), plot(t,x_FK1(:,2)-x_FK1(:,4),'LineWidth',1)
title('Estimation error of x(2)')
xlabel('\ittime(s)')

value_x1_FK1=[x_FK1(2.8/0.01+1,1) x_FK1(2.95/0.01+1,1)];
estim_x1_FK1=[x_FK1(2.8/0.01+1,3) x_FK1(2.95/0.01+1,3)];
error_x1_FK1=value_x1_FK1-estim_x1_FK1;
value_x2_FK1=[x_FK1(2.8/0.01+1,2) x_FK1(2.95/0.01+1,2)];
estim_x2_FK1=[x_FK1(2.8/0.01+1,4) x_FK1(2.95/0.01+1,4)];
error_x2_FK1=value_x2_FK1-estim_x2_FK1;
%3.4
x0_FK2=[1;10;0;0];
t=[0:0.01:3];
[y_FK2,t,x_FK2]=initial(Gss_FK2,x0_FK2,t);

f3=figure(3);set(f3,'name','Section 3.4');
subplot(221), plot(t,x_FK2(:,1),'-',t,x_FK2(:,3),'--r','LineWidth',1)
title('Estimation of x(1)')
xlabel('\ittime(s)')
legend('true value','estimated value')
subplot(222), plot(t,x_FK2(:,2),'-',t,x_FK2(:,4),'--r','LineWidth',1)
title('Estimation of x(2)')
xlabel('\ittime(s)')
legend('true value','estimated value')
subplot(223), plot(t,x_FK2(:,1)-x_FK2(:,3),'LineWidth',1)
title('Estimation error of x(1)')
xlabel('\ittime(s)')
subplot(224), plot(t,x_FK2(:,2)-x_FK2(:,4),'LineWidth',1)
title('Estimation error of x(2)')
xlabel('\ittime(s)')
value_x1_FK2=[x_FK2(2.8/0.01+1,1) x_FK2(2.95/0.01+1,1)];
estim_x1_FK2=[x_FK2(2.8/0.01+1,3) x_FK2(2.95/0.01+1,3)];
error_x1_FK2=value_x1_FK2-estim_x1_FK2;
value_x2_FK2=[x_FK2(2.8/0.01+1,2) x_FK2(2.95/0.01+1,2)];
estim_x2_FK2=[x_FK2(2.8/0.01+1,4) x_FK2(2.95/0.01+1,4)];
error_x2_FK2=value_x2_FK2-estim_x2_FK2;


%3.5
f4=figure(4);set(f4,'name','Section 3.5');
t_plot=[2.8 2.95];
subplot(221), plot(t,x_FK1(:,1),t,x_FK1(:,3),'--',...
                   t,x_FK2(:,1),t,x_FK2(:,3),'--',...
                   t_plot,value_x1_FK1,'o',t_plot,estim_x1_FK1,'+',...
                   t_plot,value_x1_FK2,'o',t_plot,estim_x1_FK2,'+','LineWidth',1);
              title('Estimation of x(1)')
              xlabel('\ittime(s)')
              legend('x1 of \SigmaFK_{1}','x1_{est} of \SigmaFK_{1}','x1 of \SigmaFK_{2}','x1_{est} of \SigmaFK_{2}') 
              axis([2.75 3.0 0 6*10^-4 ])
subplot(222), plot(t,x_FK1(:,2),t,x_FK1(:,4),'--',...
                   t,x_FK2(:,2),t,x_FK2(:,4),'--',...
                   t_plot,value_x2_FK1,'o',t_plot,estim_x2_FK1,'+',...
                   t_plot,value_x2_FK2,'o',t_plot,estim_x2_FK2,'+','LineWidth',1);
              title('Estimation of x(2)')
              xlabel('\ittime(s)')
              legend('x2 of \SigmaFK_{1}','x2_{est} of \SigmaFK_{1}','x2 of \SigmaFK_{2}','x2_{est} of \SigmaFK_{2}')
              axis([2.75 3.0 -1.2*10^-3 0])
subplot(223), plot(t,x_FK1(:,1)-x_FK1(:,3),...
                   t,x_FK2(:,1)-x_FK2(:,3),...
                   t_plot,error_x1_FK1,'*',...
                   t_plot,error_x1_FK2,'*','LineWidth',1)
              title('Estimation error of x(1)')
              xlabel('\ittime(s)')
              legend('in \SigmaFK_{1}','in \SigmaFK_{2}')
              axis([2.75 3.0 -0.2*10^-5 1.2*10^-5])
subplot(224), plot(t,x_FK1(:,2)-x_FK1(:,4),...
                   t,x_FK2(:,2)-x_FK2(:,4),...
                   t_plot,error_x2_FK1,'*',...
                   t_plot,error_x2_FK2,'*','LineWidth',1)
              title('Estimation error of x(2)')
              xlabel('\ittime(s)')
              legend('in \SigmaFK_{1}','in \SigmaFK_{2}')
              axis([2.75 3.0 -0.5*10^-5 2.7*10^-5])
%3.6.1
f5=figure(5);set(f5,'name','Section 3.6.1');
subplot(211), plot(t,x(:,1),t,x_F(:,1),t,x_FK1(:,1),t,x_FK2(:,1),'LineWidth',1)
title('Free responce of x(1)')
xlabel('\ittime(s)')
legend('\itx_{1}','\itx_{1F}','\itx_{1FK1}','\itx_{1FK2}')
subplot(212), plot(t,x(:,2),t,x_F(:,2),t,x_FK1(:,2),t,x_FK2(:,2),'LineWidth',1)
title('Free responce of x(2)')
xlabel('\ittime(s)')
legend('\itx_{2}','\itx_{2F}','\itx_{2FK1}','\itx_{2FK2}')

%3.6.2
x0_new=[2;4];
x0_F_new=[2;4];
x0_FK1_new=[2;4;0;0];
x0_FK2_new=[2;4;0;0];
[y_new,t,x_new]=initial(Gss,x0_new,t);
[y_F_new,t,x_F_new]=initial(Gss_F,x0_F_new,t);
[y_FK1_new,t,x_FK1_new]=initial(Gss_FK1,x0_FK1_new,t);
[y_FK2_new,t,x_FK2_new]=initial(Gss_FK2,x0_FK2_new,t);
f6=figure(6);set(f6,'name','Section 3.6.2');
subplot(211), plot(t,x_new(:,1),t,x_F_new(:,1),t,x_FK1_new(:,1),t,x_FK2_new(:,1),'LineWidth',1)
title('Free responce of x(1)')
xlabel('\ittime(s)')
legend('\itx_{1}','\itx_{1F}','\itx_{1FK1}','\itx_{1FK2}')
grid on
subplot(212), plot(t,x_new(:,2),t,x_F_new(:,2),t,x_FK1_new(:,2),t,x_FK2_new(:,2),'LineWidth',1)
title('Free responce of x(2)')
xlabel('\ittime(s)')
legend('\itx_{2}','\itx_{2F}','\itx_{2FK1}','\itx_{2FK2}')
grid on
