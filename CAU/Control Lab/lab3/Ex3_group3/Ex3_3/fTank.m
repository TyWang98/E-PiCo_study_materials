function [dx, y] = fTank( x, u, par )
    
    % The water levels of the tanks x1,x2 and x3 represent the state 
    % variables of the system.
    x1 = x(1);
    x2 = x(2);
    x3 = x(3);

    % symbolic parameter values
    % At is the cross sectional area of the tanks
    % Av is the cross sectional area of the valves
    % a12, a23, a10, a30I are the correction factors due to internal friction
    %               of the fluid, pipe friction, deformation of water jet
    % g is the gravity
    At      = par(1);
    Av      = par(2);
    a12     = par(3);
    a23     = par(4);
    a10     = par(5);
    a30I    = par(6);
    g       = par(7);
    
%     % Input vector
%     Qp1 = u(1);     % Pump flow of tank 1
%     Qp2 = u(2);     % Pump flow of tank 3    

    % Initialize the xdot vector
    fx = zeros(3,1);

    fx(1) = -(2^(1/2)*Av*a10*(g*x1)^(1/2) + 2^(1/2)*Av*a12*g^(1/2)*sign(x1 - x2)*abs(x1 - x2)^(1/2))/At;
    fx(2) = (2^(1/2)*Av*a12*g^(1/2)*sign(x1 - x2)*abs(x1 - x2)^(1/2) - 2^(1/2)*Av*a23*g^(1/2)*sign(x2 - x3)*abs(x2 - x3)^(1/2))/At;
    fx(3) = - (2^(1/2)*Av*a30I*(g*x3)^(1/2) - 2^(1/2)*Av*a23*g^(1/2)*sign(x2 - x3)*abs(x2 - x3)^(1/2))/At;
    
    g1 = [1/At; 0; 0;];
    g2 = [0; 0; 1/At ];
    gx = [g1 g2];
        
    dx = fx + gx*u;
    
%     dx(1) =  -(2^(1/2)*Av*a10*(g*x1)^(1/2) - Qp1 + 2^(1/2)*Av*a12*g^(1/2)*sign(x1 - x2)*abs(x1 - x2)^(1/2))/At;
%     dx(2) = (2^(1/2)*Av*a12*g^(1/2)*sign(x1 - x2)*abs(x1 - x2)^(1/2) - 2^(1/2)*Av*a23*g^(1/2)*sign(x2 - x3)*abs(x2 - x3)^(1/2))/At;
%     dx(3) = (Qp2 - 2^(1/2)*Av*a30I*(g*x3)^(1/2) + 2^(1/2)*Av*a23*g^(1/2)*sign(x2 - x3)*abs(x2 - x3)^(1/2))/At;

    y = x;
end