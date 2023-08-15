% x∗ = [1.71, −0.14, 0.29]


fun = @(x) x(1) + x(2)^2 + x(2)*x(3) + 2*x(3)^2;

x0 = rand(1,3);

Aeq = [1, 0, 1];
beq = 2;
A = [];
b = [];
lb = [];
ub = [];


nonlcon = @circlecon;
x = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon)


function [c,ceq] = circlecon(x)
c = x(1)^2 + x(2)^2 - 4;
ceq = [];
end