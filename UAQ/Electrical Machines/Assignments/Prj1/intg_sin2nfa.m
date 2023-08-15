%% Integral of sin(2nfa) %%
function [result] = intg_sin2nfa(fa1,fa2,n)
% fa1: lower limit fa2: upper limit 
result = (-1/(2*n))*(cos(2*n*fa2)-cos(2*n*fa1));
end

