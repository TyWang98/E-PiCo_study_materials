function [y,x] = simulate(u,G,T,Ts,L,x1)

%% Initialization
length_u = length(u);
y = zeros(length_u,1);
x = zeros(length_u,2);  
x(1,:) = x1;

%% Modeling
A = [0 1; 0 -1/T];
B = [0; G/T];
C = [1 0];
D = 0;

%  Discretization
[Ad,Bd,~,~] = c2dm(A,B,C,D,Ts,'zoh');

for n = 2:length_u
    x_temp = Ad*x(n-1,:)' + Bd*u(n-1);
    x(n,:) = x_temp';
end

% Outputs
teta = x(:,1);
y = round(teta*L/2/pi)*2*pi/L;

end