function xe = skal(y, u, G, T, Ts, L, x1_0, P1_0, q)
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
% Kalman gain
[K,~,~,~] = dlqe(Ad, [1;1], C, q, r);

%% Loop n = 1
y_est = H * x1_0 + h;

x1_1 = x1_0 + K * (y(1) - y_est);       
xe(1,:) = x1_1';
f = Bd * u(1);
x_est = F * x1_1 + f;

%% Loop n > 1
for n = 2 : length(u)
    y_est = H * x_est + h;

    x_est = x_est + K * (y(n) - y_est);      
    xe(n,:) = x_est';
    f = Bd * u(n);
    x_est = F * x_est + f;
end

end