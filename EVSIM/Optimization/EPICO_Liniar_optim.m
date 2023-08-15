
global number_of_time_slot battery_capacity delta_t SOC_initial power_surffit SOC_mini energy_need;

%% Inputs of our optimization Problem
number_of_time_slot = 300;
SOC_initial = 0.5;
SOC_target = 0.6;
SOC_mini = 0.2;
battery_capacity = 60; % kWh
energy_need = 1*(SOC_target - SOC_initial)*battery_capacity; % Energy requirement or Mobility need in kWh
delta_t= 1/60;  % The sampling Time 


%% G2V Charging Daily Energy Prices (DEP)
K1= 0.7*ones(1,number_of_time_slot/3);
K2= 0.2*ones(1,number_of_time_slot/3);
K3= 0.5*ones(1,number_of_time_slot/3);
K= [K1  K2  K3];
%K = randi([10 30],1,number_of_time_slot)/100;
price_elec_charging = K;


%% V2G Discharging Daily Energy Prices (DEP)
%price_elec_discharging = [0.1 0.3 0 0.2 0 0 0.4 0.1 0.1 0.6 0.2 0];
%price_elec_discharging = randi([70 80],1,number_of_time_slot)/100;
K1= 0.9*ones(1,number_of_time_slot/3);
K2= 0.1*ones(1,number_of_time_slot/3);
K3= 0.3*ones(1,number_of_time_slot/3);
K= [K1  K2  K3];
price_elec_discharging = K;
%K = 0.1593*rand(1,N);


%% Modeling of the Powerpmap Function
load power_fit_data.mat;
[soc_Data, temperature_Data, power_Data] = prepareSurfaceData(soc,temp,power_p);
%clear soc temp power;
power_surffit = fit([soc_Data, temperature_Data], power_Data,'poly55','normalize','on');
clear soc_Data temperature_Data  power_Data; 



%% power = [power_G2V, power_V2G]  power_G2V = power(:,1) and    power_V2G = power(:,2)
% Objective function = minimize charging and discharging cost 
fun = @(power) 10000*price_elec_charging*power(:,1)*delta_t + 10000*price_elec_discharging*power(:,2)*delta_t;

%soc = @(power) (1/195)*(delta_t/3600)*ones(1,N)*power;

%% energy_G2V + energy_V2G >= energy_need   with energy_G2V >=0 and energy_V2G <= 0
% Constaint  A*x <= b   x = 24x1
% A =  [-delta_t*ones(1,number_of_time_slot) -delta_t*ones(1,number_of_time_slot)];
% b =  [-energy_need];
A = [];
b = [];
%% constraint Aeq*power = beq  Soc final = Soc target
Aeq = [];
beq = [];
%%    0kW <= power_G2V <= 40 kW                 -40kW <= power_V2G <= 0 kW
% Lower bound and upper bound of power 

lb = [0*ones(number_of_time_slot,1) , -7*ones(number_of_time_slot,1)]; 
ub = [7*ones(number_of_time_slot,1) , 0*ones(number_of_time_slot,1)] ;

%% initial value or Starting point X0 
power0= [7*ones(number_of_time_slot,1) , -7*ones(number_of_time_slot,1)] ;

nonlcon = @G2V_OR_G2V;


options = optimoptions('fmincon','Display','iter','Algorithm','sqp','ConstraintTolerance',1e0,'OptimalityTolerance', 1e-1, 'StepTolerance', 1e-2,'FunctionTolerance',1e0 );

%% Solving the problem :  Finding the optimal Solution of the EV charging scheduling 
[power,fval] = fmincon(fun,power0,A,b,Aeq,beq,lb,ub,nonlcon,options);


%% Adaptating the output to the ploting

power_cumul = power(:,1)+power(:,2);
SOC_cumul = (delta_t*power_cumul)/battery_capacity;
SOC_evolution(1) = SOC_initial ;
for i=1:number_of_time_slot
SOC_evolution(i+1) = SOC_evolution(i) + SOC_cumul(i);
end 

%close all;
grid on;
number_row_window = 2; 
number_col_window = 2; 
indice_graphe = 1;
axis = subplot(number_row_window,number_col_window,indice_graphe); % top subplot
bar(power,'BarWidth', 2.5)
str = sprintf('Charging Power');
title(axis,str);
xlabel(axis,'Time');
ylabel(axis,'Power [kW]');

indice_graphe = 2;
axis = subplot(number_row_window,number_col_window,indice_graphe); % top subplot
plot(100*SOC_evolution, 'b--o')
str = sprintf('SOC evolution');
title(axis,str);
xlabel(axis,'Time');
ylabel(axis,'SOC[%]');

indice_graphe = 3;
axis = subplot(number_row_window,number_col_window,indice_graphe);
bar(price_elec_charging)
str = sprintf('Electricity Price G2V');
title(axis,str);
xlabel(axis,'Time');
ylabel(axis,'Energy Price [€/kWh]');

indice_graphe = 4;
axis = subplot(number_row_window,number_col_window,indice_graphe);
bar(price_elec_discharging)
str = sprintf('Electricity Price V2G');
title(axis,str);
xlabel(axis,'Time');
ylabel(axis,'Energy Price [€/kWh]');

energy_G2V = delta_t*ones(1,number_of_time_slot)*power(:,1);
energy_V2G = delta_t*ones(1,number_of_time_slot)*power(:,2);
Cost_charging = price_elec_charging*power(:,1)*delta_t;
Cost_discharging = price_elec_discharging*power(:,2)*delta_t;
Cost = Cost_charging + Cost_discharging;
SOC_final = SOC_initial + (energy_G2V+energy_V2G)/battery_capacity;

 
display(fval);
%display(power);
display(SOC_final*100);

 
