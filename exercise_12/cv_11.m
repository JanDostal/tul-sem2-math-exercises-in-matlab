% 1. krok urcit. function handle (parametr f ve funkcich) 
% pro diferencialni rovnici (v(t))

m_jezdec = 70; % hmotnost jezdce v kg
P = 20; % hnaci sila N
k = 0.516; % parametr odporove sily v N*m^-2*s^2

m_kola = 15; % hmotnost bicyklu v kg
m = m_jezdec + m_kola; % celkova hmotnost jezdce i kola

dif_rovnice = @(t, v) (P - k .* v.^2) ./ m;

% 2. sestavit ulohu

a = 0; % casovy interval sekundy
b = 100; % casovy interval sekundy
h = 0.1; % krok metody
konstantni_rychlost = 30; % rychlost km/h

y0 = 30 / 3.6; % prevedeno na m/s, protoze v metodach se pouziva function handle f 
% (v nasem pripade differencialni rovnice) pro vypocet vystupu y a jeden
% z parametru f je y, coz je mysleno rychlost a differencialni rovnice
% ocekava rychlost v m/s, v pripade y0 se pomoci neho nastavuje pocatecni
% stav vystupu y


% 3. krok vypocitat prubehy rychlosti u jednotlivych metod

[t_imp, v_imp] = euler_imp(dif_rovnice, a, b, y0, h);

[t_exp, v_exp] = euler_exp(dif_rovnice, a, b, y0, h);

[t_ode, v_ode] = ode45(dif_rovnice, [a, b], y0);


% 4. vypocitat ustalene rychlosti pro vsechny 3 metody

tol = 0.001; % zadani code critic

% implicitni euler

v_end_imp_m = v_imp(end);
t_end_imp = t_imp(end);
i_end_imp = length(t_imp);

for i = 2:length(t_imp)
    
    pokles_rychlosti = abs(v_imp(i) - v_imp(i-1)); % zadani code critic

    casovy_usek = (t_imp(i) - t_imp(i-1)); % zadani code critic

    if pokles_rychlosti / casovy_usek < tol

        v_end_imp_m = v_imp(i);
        t_end_imp = t_imp(i);
        i_end_imp = i;
        break;
    end
end


% explicitni euler

v_end_exp_m = v_exp(end);
t_end_exp = t_exp(end);
i_end_exp = length(t_exp);

for i = 2:length(t_exp)
    
    pokles_rychlosti = abs(v_exp(i) - v_exp(i-1)); % zadani code critic
 
    casovy_usek = (t_exp(i) - t_exp(i-1)); % zadani code critic

    if pokles_rychlosti / casovy_usek < tol

        v_end_exp_m = v_exp(i);
        t_end_exp = t_exp(i);
        i_end_exp = i;
        break;
    end
end


% ode45

v_end_ode_m = v_ode(end);
t_end_ode = t_ode(end);
i_end_ode = length(t_ode);

for i = 2:length(t_ode)
    
    pokles_rychlosti = abs(v_ode(i) - v_ode(i-1)); % zadani code critic

    casovy_usek = (t_ode(i) - t_ode(i-1)); % zadani code critic

    if pokles_rychlosti / casovy_usek < tol

        v_end_ode_m = v_ode(i);
        t_end_ode = t_ode(i);
        i_end_ode = i;
        break;
    end
end

% jelikoz v grafu mame vykreslit ustalenou rychlost jako km/h, prevedu m/s
% na km/h

v_end_ode_km = 3.6 * v_end_ode_m;
v_end_exp_km = 3.6 * v_end_exp_m;
v_end_imp_km = 3.6 * v_end_imp_m;

fprintf('Ustálená rychlost ode45: %.3f km/h\n', v_end_ode_km);
fprintf('Čas dosažení ustálené rychlosti ode45: %.3f s\n', t_end_ode);
fprintf('Index casu ustalene rychlosti ode45: %d \n', i_end_ode);

fprintf('Ustálená rychlost implicitni euler: %.3f km/h\n', v_end_imp_km);
fprintf('Čas dosažení ustálené rychlosti implicitni euler: %.3f s\n', t_end_imp);
fprintf('Index casu ustalene rychlosti implicitni euler: %d \n', i_end_imp);

fprintf('Ustálená rychlost explicitni euler: %.3f km/h\n', v_end_exp_km);
fprintf('Čas dosažení ustálené rychlosti explicitni euler: %.3f s\n', t_end_exp);
fprintf('Index casu ustalene rychlosti explicitni euler: %d \n', i_end_exp);


% 5. na zaklade spocitanych rychlosti urcit ustalenou rychlost

v_end = v_end_exp_km;

% 6. vykreslit graf

fig = figure(1);

% prevedu z m/s na km/h prubehy rychlosti
v_exp_km = 3.6 * v_exp;
v_imp_km = 3.6 * v_imp;
v_ode_km = 3.6 * v_ode;

plot(t_exp, v_exp_km, "r");
hold on;
plot(t_imp, v_imp_km, "g");
plot(t_ode, v_ode_km, "b");
plot(t_end_exp, v_end, '-s','MarkerSize',10,'MarkerEdgeColor','red','MarkerFaceColor', 'red'); % ustalena rychlost

xlabel('Čas (s)');
ylabel('Rychlost (km/h)');
legend("explicitni funkce", "implicitni funkce", "ode45", "ustalena rychlost");
title("Graf prubehu rychlosti cyklisty");

saveas(fig, "graph.png");
