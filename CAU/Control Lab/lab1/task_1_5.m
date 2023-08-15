a = 0;
z = @(t,vars) M(t,vars,a);
initConditions = [0 pi-0.01 pi-0.01 0 0 0];
[t, y] = ode45(z, [0 10], initConditions);

figure(1)
plot( t, y(:,2))
figure(2)
plot( t, y(:,3))

z1 = @(t,x_num) M2(t,x_num,a);
%initConditions = [0; 0; -0.01; 0; 0-0.01; 0];
[t, y] = ode45(z1, [0 10], initConditions);

figure(3)
plot( t, y(:,3))
figure(4)
plot( t, y(:,5))

[t, y] = my_euler(M, 0, 10, initConditions);

figure(5)
plot( t, y(2,:))
figure(6)
plot( t, y(3,:))