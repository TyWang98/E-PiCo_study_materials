function y = mass_spring_model_solution(time, stateInit, sys)
    w_0 = sqrt(sys.stiffness/sys.mass);
    deta = sys.damping/(2*sys.mass);
    w = sqrt(w_0^2-deta^2);
    p0 = stateInit(1);
    p0_dot = stateInit(2);
    
    state = zeros(2,1);
    state(1) = exp(-deta*time)*(p0*cos(w*time)+(p0_dot + deta*p0)/w*sin(w*time));
    state(2) = exp(-deta*time)*( -p0*sin(w*time)*w + (p0_dot + deta*p0)*cos(w*time) ) - deta*state(1);
end
