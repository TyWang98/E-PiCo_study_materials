%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Introduction in Matlab/Simulink
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This sample file is used for learning the graphical output options in Matlab

clear all
close all
clc

%%

% Simple two dimensional plots

% Creating the data

x = 0:.1:2*pi;
y = sin(2*x).*exp(-x/pi);


figure(1)   % Opens a Figure environment

plot(x,y)   % simple plot command

grid on     % Grid lines are displayed

% Adding a second record

y1 = cos(2*x).*exp(-x/pi);

hold on     % The displayed elements are kept.

% The second curve is displayed in red and thicker line width
plot(x,y1,'red','LineWidth',2) 


legend('Kurve1','Kurve 2')  % Adding a legend

axis([0 5 -0.7 1.2])  % The display area is restricted

% It is also possible to set a large number of parameters in the plot. On the 
% one hand, this can be done directly in the graphical user interface, on the 
% other hand it can be done with the commands get and set

get(gca)  % gca stands for 'get current axis'
set(gca, 'FontName', 'Arial', 'FontSize', 14) % Change font type and size


xlabel('Zeit in s', 'FontName', 'Arial', 'FontSize', 14)  % x-axis labeling
ylabel('Amplitude in V', 'FontName', 'Arial', 'FontSize', 14)  % y-axis labeling
title('Spannungsverlauf', 'FontName', 'Arial', 'FontSize', 14) % Labeling of the title

%%

% Different appearance of the lines

close all

figure

x = 0:.1:2*pi;
y = sin(2*x).*exp(-x/pi);

figure 

plot(x,y,'k.')    % Plot in black with dots
hold on
grid on
plot(x,1.5*y,'bo')    % Plot in blue with circles
plot(x,2*y,'c*')      % Plot in cyan with stars
plot(x,2.5*y,'g+')    % Plot in green with crosses
plot(x,3*y,'r:')      % Plot dotted in red
plot(x,3.5*y,'m--')   % Plot in magenta dashed
plot(x,4*y,'y-.')     % Plot in yellow dash-dotted


% Further Plots

figure

loglog(x,abs(y))      % Double logarithmic plot

figure

polar(0:.1:10,0:.1:10) % Polar plot

% Create subplots

figure
subplot(2,1,1)        % Subplot creation
plot(x,y)
grid on
subplot(2,1,2)        % Access to second window
plot(x,2*y)
grid on

%%

% Three dimensional plots

clear all
close all
clc

x = 0:0.01:1;

% Display of a line in space

plot3(sin(x*4*pi),cos(x*4*pi),x,'LineWidth',2)
box on   % Adding a Box
grid on  % Adding grid lines

% Display of surfaces

[xx,yy] = meshgrid(x,x);  % Create coordinate matrix

zz = sin(4*pi*xx).*cos(4*pi*yy).*exp(-xx); % Function to be displayed

% Surface plot
figure
surf(xx,yy,zz)
box on
grid on

% Mesh plot
figure
mesh(xx,yy,zz)
box on
grid on

% 2D contour plot
figure
contour(xx,yy,zz)
box on
grid on





