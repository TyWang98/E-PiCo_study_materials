% Calculate the Fourier series of Turns function n_f
Nr = 108; % unit: turns/pole

N = 4; % the highest harmonic  order

for i=1:N
    % coefficient b_n of sin components %
    nf_b(i) = Nr/pi/i*(cos(i*pi/3)-cos(2*i*pi/3)+cos(5*i*pi/3)-cos(4*i*pi/3));
end

fa = 0:0.01:2*pi; % mechanical angle in stationary frame (stator)
fs_nf = zeros(size(fa)); % request memory

F_fsnf = 0;
syms theta; % rotor position

for i=1:N
    fs_nf = fs_nf + nf_b(i)*sin(2*i*fa);
    F_fsnf = F_fsnf + nf_b(i)*sin(2*i*(phi-theta));
end

figure()
plot(fa,fs_nf)
xlabel('\phi (rad)')
ylabel('n_f(\phi) (turns/pole)')
title('Fourier series of rotor turns function')