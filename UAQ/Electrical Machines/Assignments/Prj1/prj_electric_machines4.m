mu0 = 4*pi*(1e-7); % permeability of vacuum
r = 422.656*(1e-3); 
L = 273.05*(1e-3);

fcna = F_fsna*F_fsna*F_fsivg; % n_A*M_A*g^-1
fcnb = F_fsnb*F_fsnb*F_fsivg;
fcnc = F_fsnc*F_fsnc*F_fsivg;

fcnaf = F_fsnf*F_fsna*F_fsivg; % n_f*M_A*g^-1
% fcnbf = F_fsnf*F_fsnb*F_fsivg;
% fcncf = F_fsnf*F_fsnc*F_fsivg;

syms LAA(theta) LBB(theta) LCC(theta)
syms LAF(theta) LBF(theta) LCF(theta)

LAA(theta) = mu0*r*L*(int(fcna,phi,[0 2*pi])); % [lower bound, upper bound]
LBB(theta) = mu0*r*L*(int(fcnb,phi,[0 2*pi]));
LCC(theta) = mu0*r*L*(int(fcnc,phi,[0 2*pi]));

LAF(theta) = mu0*r*L*(int(fcnaf,phi,[0 2*pi])); 
% LBF(theta) = mu0*r*L*(int(fcnbf,phi,[0 2*pi]));
% LCF(theta) = mu0*r*L*(int(fcncf,phi,[0 2*pi]));

% numerically approximate the integral by using vpa
LAA(theta) = vpa(LAA(theta)); 
LBB(theta) = vpa(LBB(theta));
LCC(theta) = vpa(LCC(theta));

% LAF(theta) = vpa(LAF(theta));
% LBF(theta) = vpa(LBF(theta));
% LCF(theta) = vpa(LCF(theta));

figure()
plot(fa,LAA(fa),fa,LBB(fa),fa,LCC(fa))
xlabel('\theta (rad)')
ylabel('Inductance (H)')
title('Stator magnetizing inductances')
legend('L_A_A','L_B_B','L_C_C')

figure()
plot(fa,LAF(fa),fa,LBF(fa),fa,LCF(fa))
xlabel('\theta (rad)')
ylabel('Inductance (H)')
title('Mutual inductances')
legend('L_A_F','L_B_F','L_C_F')
