At = 0.0154;
Av = pi*(0.0040)^2;
a12 = 0.3485;
a23 = 0.3485;
a10 = 0.6677;
a30I = 0.6591;
g = 9.80665;
par = [At Av a12 a23 a10 a30I g];

x0 = [0;0;0];


y10 = x0(1);
y20 = x0(3);
y1T = 0.2;
y2T = 0.25;
T = 80;
p1 = 10;
p2 = 10;

parameter_controller = [y10 y20 y1T y2T T p1 p2];