figure1 = figure(1);

A = full(gallery('poisson',5));

[x_jacobi_poisson, flag_jacobi_poisson, ...
    rr_jacobi_poisson, it_jacobi_poisson, rv_jacobi_poisson] = jacobi(A, ones(25, 1), ...
    1e-7, 1000);
[x_pcg_poisson, flag_pcg_poisson, ...
    rr_pcg_poisson, it_pcg_poisson, rv_pcg_poisson] = pcg(A, ones(25, 1), 1e-7, 1000);
[x_seidel_poisson, flag_seidel_poisson, ...
    rr_seidel_poisson, it_seidel_poisson, rv_seidel_poisson] = gauss_seidel(A, ones(25, 1), ...
    1e-7, 1000);

loglog(0:it_jacobi_poisson, rv_jacobi_poisson, "r");
title("Konvergenční průběh iteračních metod pro poisson matici");

hold on;

loglog(0:it_pcg_poisson, rv_pcg_poisson, "g");
loglog(0:it_seidel_poisson, rv_seidel_poisson, "b");

legend('jacobi metoda', 'pcg metoda', 'gauss-seidlova metoda');
xlabel("počet iterací");
ylabel("vektor reziduí");




figure2 = figure(2);

A = full(gallery('lehmer',20));

[x_jacobi_lehmer, flag_jacobi_lehmer, ...
    rr_jacobi_lehmer, it_jacobi_lehmer, rv_jacobi_lehmer] = jacobi(A, ones(20, 1), ...
    1e-7, 1000);
[x_pcg_lehmer, flag_pcg_lehmer, ...
    rr_pcg_lehmer, it_pcg_lehmer, rv_pcg_lehmer] = pcg(A, ones(20, 1), 1e-7, 1000);
[x_seidel_lehmer, flag_seidel_lehmer, ...
    rr_seidel_lehmer, it_seidel_lehmer, rv_seidel_lehmer] = gauss_seidel(A, ones(20, 1), ...
    1e-7, 1000);

loglog(0:it_pcg_lehmer, rv_pcg_lehmer, "g");
title("Konvergenční průběh iteračních metod pro lehmerovu matici");

hold on;
%loglog(0:it_jacobi_lehmer, rv_jacobi_lehmer, "r");
loglog(0:it_seidel_lehmer, rv_seidel_lehmer, "b");

legend('pcg metoda', 'gauss-seidlova metoda');
xlabel("počet iterací");
ylabel("vektor reziduí");



figure3 = figure(3);

A = full(gallery('dorr',5));

[x_jacobi_dorr, flag_jacobi_dorr, ...
    rr_jacobi_dorr, it_jacobi_dorr, rv_jacobi_dorr] = jacobi(A, ones(5, 1), ...
    1e-7, 10000);
[x_pcg_dorr, flag_pcg_dorr, ...
    rr_pcg_dorr, it_pcg_dorr, rv_pcg_dorr] = pcg(A, ones(5, 1), 1e-7, 1000);
[x_seidel_dorr, flag_seidel_dorr, ...
    rr_seidel_dorr, it_seidel_dorr, rv_seidel_dorr] = gauss_seidel(A, ones(5, 1), ...
    1e-7, 1000);

loglog(0:it_jacobi_dorr, rv_jacobi_dorr, "r");
title("Konvergenční průběh iteračních metod pro dorrovu matici");

hold on;

%semilogy(0:it_pcg_dorr, rv_pcg_dorr, "g");

loglog(0:it_seidel_dorr, rv_seidel_dorr, "b");

legend('jacobi metoda', 'gauss-seidlova metoda');
xlabel("počet iterací");
ylabel("vektor reziduí");


saveas(figure1, "graph_poisson.png");
saveas(figure2, "graph_lehmer.png");
saveas(figure3, "graph_dorr.png");


% Pro graf lehmerovy matice nebyla zahrnuta jacobiho metoda, protoze
% vratila flag 4, tedy relativni rezidium je prilis velke nebo male, tedy
% nekonverguje

%Pro graf dorrovy matice nebyla zahrnuta pcg metoda, protoze v 
% v pripade pcg vracen flag 4, tedy nekonverguje, v pripade jacobiho vracen
% pri maxit 1000 flag 1, pri navyseni z 1000 na 10000 misto flag 1 vracen
% flag 0

