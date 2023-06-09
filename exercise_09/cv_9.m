syms x;


% CMR

rectangle_rule_sinX_divide_X = sin(x) ./ x;

rectangle_rule_sinX_divide_X_result_int = ...
double(vpa(int(rectangle_rule_sinX_divide_X, 0, 1), 10));

f_handle = matlabFunction(rectangle_rule_sinX_divide_X);

rectangle_rule_sinX_divide_X_result_composite_midpoint = ...
composite_midpoint(f_handle, 0, 1, 1000);

rectangle_rule_sinX_divide_X_result_integral = integral(f_handle, 0, 1);

nRange = 10 .^ (1:7);
nRange = nRange.';
midPointsRange = zeros(1, length(nRange));

for i=1:length(nRange)
    
    midPointsRange(i) = composite_midpoint(f_handle, 0, 1, nRange(i));
end

midPointsRange = midPointsRange.';

differences = ...
    abs(rectangle_rule_sinX_divide_X_result_integral - midPointsRange);

referenceValue = zeros(1, length(differences));
referenceValue(:) = rectangle_rule_sinX_divide_X_result_integral;
referenceValue = referenceValue.';

T = table(nRange, differences, ...
    referenceValue, ...
    'VariableNames',{'Počet dělení intervalu','Rozdíl', ...
    'Referenční hodnota'});

disp(T);


% ATR

trapezoid_rule_2x_plus_1 = 2.*x + 1;
trapezoid_rule_one_half_plus_cosx_multiply_sinx = (1/2 + cos(x)) .* sin(x);

trapezoid_rule_2x_plus_1_result_int = ...
double(vpa(int(trapezoid_rule_2x_plus_1, -1, 1), 10));
trapezoid_rule_one_half_plus_cosx_multiply_sinx_result_int = ...
double(vpa(int(trapezoid_rule_one_half_plus_cosx_multiply_sinx, 0, 1), 10));

f_handle_first = matlabFunction(trapezoid_rule_2x_plus_1);
f_handle_second = matlabFunction(trapezoid_rule_one_half_plus_cosx_multiply_sinx);

[trapezoid_rule_2x_plus_1_result_adapt_trapz, k1] = ...
adapt_trapz(f_handle_first, -1, 1, 50, 1e-3);
[trapezoid_rule_1_one_half_plus_result_adapt_trapz, k2] = ...
adapt_trapz(f_handle_second, 0, 1, 50, 1e-3);

trapezoid_rule_2x_plus_1_result_integral = integral(f_handle_first, -1, 1);
trapezoid_rule_one_half_plus_cosx_multiply_sinx_result_integral = ...
integral(f_handle_second, 0, 1);

disp("Počet intervalů dělení v prvnim integralu: " + 2^k1);
disp("Počet intervalů dělení v druhem integralu: " + 2^k2);
disp("Počet potrebnych urovni v prvnim integralu: " + k1);
disp("Počet potrebnych urovni v druhem integralu: " + k2);
disp("chyba integrace prvniho integralu v porovnani s referencni hodnotou: " + ...
    abs(trapezoid_rule_2x_plus_1_result_integral - ...
    trapezoid_rule_2x_plus_1_result_adapt_trapz));
disp("chyba integrace druheho integralu v porovnani s referencni hodnotou: " + ...
    abs(trapezoid_rule_one_half_plus_cosx_multiply_sinx_result_integral - ...
    trapezoid_rule_1_one_half_plus_result_adapt_trapz));



