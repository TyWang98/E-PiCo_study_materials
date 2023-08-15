% Fourier series of Stator turns function %
S_slots = 48;
intv = 2*pi/S_slots; % mechanical angle of each slot

Ns = 3; % unit: turns per coil
T = pi; % here we consider the time period of n_A is pi.
N = 5; % the highest harmonic  order
 
for i=1:N
    % coefficient b_n of sin components %
    bi = intg_sin2nfa(0,intv,i)+ 2*intg_sin2nfa(intv,2*intv,i)+ 3*intg_sin2nfa(2*intv,3*intv,i)+...
        4*intg_sin2nfa(3*intv,8*intv,i)+...
        3*intg_sin2nfa(8*intv,9*intv,i)+ 2*intg_sin2nfa(9*intv,10*intv,i)+ intg_sin2nfa(10*intv,11*intv,i)+...
        (-1)*intg_sin2nfa(12*intv,13*intv,i)+ (-2)*intg_sin2nfa(13*intv,14*intv,i)+ (-3)*intg_sin2nfa(14*intv,15*intv,i)+...
        (-4)*intg_sin2nfa(15*intv,20*intv,i)+...
        (-3)*intg_sin2nfa(20*intv,21*intv,i)+ (-2)*intg_sin2nfa(21*intv,22*intv,i)+ (-1)*intg_sin2nfa(22*intv,23*intv,i);
    nA_b(i) = Ns*2*bi/T;
    % elimination of calculation error %
%     if (abs(nA_b(i))-1e-10 < 0)
%         nA_b(i) = 0;
%     end
end

fa=0:0.01:2*pi; % mechanical angle in stationary frame (stator)
fs_na = zeros(size(fa)); % request memory 
fs_nb = zeros(size(fa));
fs_nc = zeros(size(fa));

syms phi; 
F_fsna = 0;
F_fsnb = 0;
F_fsnc = 0;

for i=1:N
    fs_na = fs_na + nA_b(i)*sin(2*pi*i*fa/T); % phase A
    fs_nb = fs_nb + nA_b(i)*sin(2*pi*i*(fa-2*pi/3)/T); % phase B
    fs_nc = fs_nc + nA_b(i)*sin(2*pi*i*(fa+2*pi/3)/T); % phase C
    F_fsna = F_fsna+nA_b(i)*sin(2*pi*i*phi/T); % symbolic function of this Fourier series
    F_fsnb = F_fsnb+nA_b(i)*sin(2*pi*i*(phi-2*pi/3)/T);
    F_fsnc = F_fsnc+nA_b(i)*sin(2*pi*i*(phi+2*pi/3)/T);
end

figure()
plot(fa,fs_na,fa,fs_nb,fa,fs_nc)
xlabel('\phi (rad)')
ylabel('n(\phi) (turns/coil)')
title('Fourier series of stator turns function')
legend('phase A','phase B','phase C')


