%--------------------------------------------------------------
% Master laboratory - Exercise 2 
%--------------------------------------------------------------


% test
j = 5;
Q = Q_set(j).*eye(6);
R = R_set(j).*eye(3);
cov_Noise = cov_Noise_set(j);
sim("dip_ekf_sim_student_r2017b.slx")


% %run 6 simlation cycles
% for j = 1:6
%     Q = Q_set(j).*eye(6);
%     R = R_set(j).*eye(3);
%     cov_Noise = cov_Noise_set(j);
%     sim("dip_ekf_sim_student.slx")
%     MSE(j,:) = mse(end,:);
% end
