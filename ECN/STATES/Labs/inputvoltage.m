function u = inputvoltage(D,A,Delta,Ts)
t = 0:Ts:D;
u = A/2*square(2*pi*t/Delta);
u = u';
end