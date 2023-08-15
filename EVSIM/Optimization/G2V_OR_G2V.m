function  [c,ceq] = G2V_OR_G2V(X)

global number_of_time_slot battery_capacity delta_t SOC_initial power_surffit SOC_evolution energy_need temperature_evolution SOC_mini V2G_partcipation;

%% power = [power_G2V, power_V2G]
power_G2V = X(:,1);    % 1st Column

power_V2G = X(:,2);    % 2nd Column


energy_G2V = delta_t*ones(1,number_of_time_slot)*power_G2V;
energy_V2G = delta_t*ones(1,number_of_time_slot)*power_V2G;
SOC = SOC_initial + (energy_G2V+energy_V2G)/battery_capacity;


power_cumul = power_G2V + power_V2G;
SOC_cumul = (delta_t*power_cumul)/battery_capacity;
SOC_evolution(1) = SOC_initial ;
temperature_evolution(1) = 20;
for i=1:number_of_time_slot
temperature_evolution(i+1)=  temperature_evolution(i) + 2e-1*(delta_t)*power_G2V(i) + 2e-1*(delta_t)*power_V2G(i)*(-1);
SOC_evolution(i+1) = SOC_evolution(i) + SOC_cumul(i);
end
SOC_evolution(1) = [];
temperature_evolution(1) = [];

P_SOC_T = power_surffit(SOC_evolution,temperature_evolution)/1000;

%% Nonlinear inequality constraints c(x) <= 0 ~ P <= Pmax(SOC) ~ P - Pmax(SOC) <=0



const_1 = -SOC_evolution + SOC_mini;     %   SOC >= SOC_mini to begin V2G   c(x) < 0  0 >= SOC_mini - SOC  -->   -SOC +SOC_mini < 0
const_2 = SOC_evolution - 0.8;        %   SOC <= SOC_max
const_3 = power_G2V' - P_SOC_T;            %   P <= powermap(SOC,T)
const_6 = ( energy_need -(energy_G2V+energy_V2G))*ones(1,number_of_time_slot); %   SOC_final >= SOC_target

c = [const_2 ; const_3 ; const_1 ; const_6 ;];
%c = [];


%% Nonlinear equality constraints
ceq1 = power_G2V.*power_V2G;


ceq = ceq1; 
