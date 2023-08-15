% Fourier series of inversed air gap function g^-1
y1 = 1000/2.7; % minimum value
y2 = 1000/1.4; % maximum value
alpha0 = 1/2*(4/3*y1+2/3*y2); % DC value in Fourier series

N = 2; % the highest harmonic  order
 
for i=1:N
    % coefficient a_n of cos components %
    ivg_a(i) = 1/i/pi*(y1*(sin(2*i*pi/6)+sin(4*i*pi/3)-sin(2*i*pi/3)-sin(5*i*pi/3))...
                  +y2*(sin(2*i*pi/3)-sin(i*pi/3)+sin(5*i*pi/3)-sin(4*i*pi/3)));
end

fa = 0:0.01:2*pi; % mechanical angle in stationary frame (stator)
fs_ivg = alpha0*ones(size(fa)); % request memory and initialization

F_fsivg = alpha0;
syms theta; % rotor position

for i=1:N
    fs_ivg = fs_ivg + ivg_a(i)*cos(2*i*fa);
    F_fsivg = F_fsivg + ivg_a(i)*cos(2*i*(phi-theta));
end

figure()
plot(fa,fs_ivg)
xlabel('\phi (rad)')
title('Fourier series of inversed airgap function')