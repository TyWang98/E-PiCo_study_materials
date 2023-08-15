function [x,y] = my_euler(ode, tmin, tmax, int)
% Euler's Method
% Initial conditions and setup

h = 0.001;
x = tmin:h:tmax;  % the range of x
y = zeros(6, size(x,2));  % allocate the result y
y(:,1) = int';  % the initial y value
n = size(x,2);  % the number of y values

% The loop to solve the DE
for i=1:n-1
    f = ode(x(i),y(:,i),0);
    y(:,i+1) = y(:,i) + h * f;
end

end