function xe = kal(y, u, G, T, Ts, L, x1_0, P1_0, q)
A = [0 1; 0 -1/T];  
B = [0; G/T];  
C = [1 0];  
D = 0;
[Ad,Bd,~,~] = c2dm(A,B,C,D,Ts,'zoh');

xe = zeros(length(u), 2);

H = C;  
h = 0;  
r = (2*pi/L)^2/12; 
F = Ad;

%% Loop n = 1
y_est = H * x1_0 + h;
C_xy = P1_0 * H';
C_yy = H * P1_0 * H' + r;

x1_1 = x1_0 + C_xy / C_yy * (y(1) - y_est); 
xe(1,:) = x1_1';
P1_1 = P1_0 - C_xy / C_yy * C_xy';

f = Bd * u(1);
x_est = F * x1_1 + f;
P = F * P1_1 * F' + q;

%% Loop n > 1
for n = 2 : length(u)
    y_est = H * x_est + h;
    C_xy = P * H';
    C_yy = H * P * H' + r;

    x_est = x_est + C_xy / C_yy * (y(n) - y_est);      
    xe(n,:) = x_est';
    P = P - C_xy / C_yy * C_xy';
    
    f = Bd * u(n);
    x_est = F * x_est + f;
    P = F * P * F' + q;
end

end