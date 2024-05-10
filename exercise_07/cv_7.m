clear;
close all;

x = [2 3 4 5 6];
y = [4 8 16 32 64];

p = polyfit(x, y, 1);
k1 = p(1);
q1 = p(2);

[k2, q2] = lin_regression(x, y);

T = readtable("insurance.csv");
T.smoker = convertCharsToStrings(T.smoker);
T.region = convertCharsToStrings(T.region);
T.sex = convertCharsToStrings(T.sex);

smokers = T(T.smoker == "yes",:);
non_smokers = T(T.smoker == "no", :);

smokers_age = smokers.age;
smokers_charges = smokers.charges;
non_smokers_age = non_smokers.age;
non_smokers_charges = non_smokers.charges;

smokers_bmi = smokers.bmi;
non_smokers_bmi = non_smokers.bmi;

[k_age_smokers, q_age_smokers] = lin_regression(smokers_age, smokers_charges);
[k_age_nonsmokers, q_age_non_smokers] = lin_regression(non_smokers_age, non_smokers_charges);

[k_bmi_smokers, q_bmi_smokers] = lin_regression(smokers_bmi, smokers_charges);
[k_bmi_nonsmokers, q_bmi_non_smokers] = lin_regression(non_smokers_bmi, non_smokers_charges);


f1 = figure(1);

plot(smokers_age, smokers_charges, "or");
title("Závislost nákladů na věku");

hold on;

func_age_smokers = @(x) x .* k_age_smokers + q_age_smokers;
plot(5:0.001:100, func_age_smokers(5:0.001:100), "r");

plot(non_smokers_age, non_smokers_charges, "og");
func_age_non_smokers = @(x) x .* k_age_nonsmokers + q_age_non_smokers;
plot(5:0.001:100, func_age_non_smokers(5:0.001:100), "g");

legend('data kuřáků', ...
    sprintf('regresní přímka kůřáků s předpisem: y = %0.4fx%+ .4f', ...
    k_age_smokers, q_age_smokers), 'data nekuřáků', ...
    sprintf('regresní přímka nekůřáků s předpisem: y = %0.4fx%+ .4f', ...
    k_age_nonsmokers, q_age_non_smokers));


xlabel("věk");
ylabel("náklady");


f2 = figure(2);

plot(smokers_bmi, smokers_charges, "or");
title("Závislost nákladů na bmi");

hold on;

func_bmi_smokers = @(x) x .* k_bmi_smokers + q_bmi_smokers;
plot(10:0.001:60, func_bmi_smokers(10:0.001:60), "r");

plot(non_smokers_bmi, non_smokers_charges, "og");
func_bmi_non_smokers = @(x) x .* k_bmi_nonsmokers + q_bmi_non_smokers;
plot(10:0.001:60, func_bmi_non_smokers(10:0.001:60), "g");

legend('data kuřáků', ...
    sprintf('regresní přímka kůřáků s předpisem: y = %0.4fx%+ .4f', ...
    k_bmi_smokers, q_bmi_smokers), 'data nekuřáků', ...
    sprintf('regresní přímka nekůřáků s předpisem: y = %0.4fx%+ .4f', ...
    k_bmi_nonsmokers, q_bmi_non_smokers));


xlabel("bmi");
ylabel("náklady");

saveas(f1, "graph_age.png");
saveas(f2, "graph_bmi.png");

