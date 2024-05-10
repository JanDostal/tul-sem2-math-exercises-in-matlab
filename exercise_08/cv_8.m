clear;
close all;

data = load("velocity.mat", '-ascii');

speed = data(2, :);
time = data(1, :);

% prevod rychlosti z km/h na m/s
speedMetersPerSecond = speed / 3.6;

% pouziti diferencniho schematu jako centralni diference
a = zeros(1, length(speedMetersPerSecond));

% prvky (x0) zrychleni budou vsechny krome prvniho a posledniho,
% jelikoz centralni diference vyzaduje, aby x0 mel bod pred a za, coz
% u prvního (chybí před) a posledního (chybí za) splněno není
x0_indeces = 2:length(a)-1;

% chceme ziskat bod za x0 a bod pred x0, zde bod za x0
x0plusH_points = speedMetersPerSecond(3:end);

% chceme ziskat bod za x0 a bod pred x0, zde bod pred x0
x0minusH_points = speedMetersPerSecond(1:end-2);

% casovy rozdil je vlastne (x0 + h) - (x0 -h), nemuze se
% predpokladat, ze vzdalenost x0 + h bude stejna jako x0 - h
% rozpeti (index) je samy jako u x0_points, protoze pokud nas zajimaji
% rychlosti v bodech pred a za x0, tak logicky budeme chtít casovy rozdil
% mezi bodem pred a za x0 (aproximace)
not_constant_time_differences = (time(3:end) - time(1:end-2));

delta_x0 = (x0plusH_points - x0minusH_points);

a(x0_indeces) = delta_x0 ./ not_constant_time_differences;

%Na prvni prvek pouzijeme doprednou diferenci, na posledni zpetnou
%diferenci
% duvodem je to, ze centralni diference pro x0 funguje pouze pri existenci
% bodu pred x0 a za x0, ale u 1. bodu chybí bod před a u posledního bodu chybi
% bod za
a(1) = (speedMetersPerSecond(2) - speedMetersPerSecond(1)) ./ ...
(time(2) - time(1));
a(end) = (speedMetersPerSecond(end) - speedMetersPerSecond(end-1)) ./ ...
(time(end) - time(end-1));


% pro zjisteni nulovych casovych okamziku, musim najit prechody mezi
% zrychlenimi, kdy dochazi ke zmene znamenka, to indikuje totiz
% ze doslo k prekroceni hodnoty 0
plus_minus_indeces = find((a(1:end-1) > 0 & a(2:end) < 0) | (a(1:end-1) < 0 & a(2:end) > 0));

% Potom pro nalezene indexy prechodu udela to, ze se pomoci indexu vybere
% casovy okamzik a pote i nasledujici casovy okamzik, tedy 2 a udela se z
% techto casovych okamziku prumerny casovy okamzik
z = (time(plus_minus_indeces) + time(plus_minus_indeces + 1)) / 2;

f = figure(1);

colororder({'b','r'})

yyaxis left;
plot(time, speed);
ylabel("Rychlost km/h");

yyaxis right;
plot(time, a);
ylabel("Zrychleni m/s");

hold on;

for i = 1:length(z)
    xline(z(i), "k--");
end

yline(0, 'r--');

xlabel("Čas v sekundach");

saveas(f, "graph_acceleration.png");
