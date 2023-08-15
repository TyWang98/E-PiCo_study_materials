function dy = mass_spring_model_ode(t, y, sys)
    % y(1) = p; y(2) = p_dot
    dy = zeros(2,1);
    dy(1) = y(2); 
    dy(2) = (-1/sys.mass)*(sys.damping*y(2) + sys.stiffness*y(1));
end
