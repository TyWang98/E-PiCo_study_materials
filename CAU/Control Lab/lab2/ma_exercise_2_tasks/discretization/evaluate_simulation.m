out = sim('discretization_example_student.slx');

ts_state_exact = out.state_exact;
ts_state_euler = out.state_euler;
ts_state_heun = out.state_heun;
ts_state_RK4 = out.state_rk4;
ts_state_implicit = out.state_implicit;

%% Plot
figure()
subplot(2, 2, 1)
plot(ts_state_euler - ts_state_exact)
title("explicit Euler")
grid on
subplot(2, 2, 2)
plot(ts_state_heun - ts_state_exact)
title("explicit Heun")
grid on
subplot(2, 2, 3)
plot(ts_state_RK4 - ts_state_exact)
title("explicit RK4")
grid on
subplot(2, 2, 4)
plot(ts_state_implicit - ts_state_exact)
title("implicit Euler")
grid on
