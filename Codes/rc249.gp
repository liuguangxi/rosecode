calc(k) = {
    my(log_pi, ek_min, ek_max, B, log_pi_appr, p, q);
    my(log_pi_diff, log_e_diff, r1, r2, n_min, n_max, e_min, e_log_pi, e);

    log_pi = log(Pi) / log(10);
    ek_min = floor(exp(1)*10^(k-1)) / 10^(k-1);
    ek_max = (floor(exp(1)*10^(k-1))+1) / 10^(k-1);

    B = 10;
    while (1,
        log_pi_appr = bestappr(log_pi, B);
        p = numerator(log_pi_appr);
        q = denominator(log_pi_appr);
        log_pi_diff = abs(log_pi_appr - log_pi);
        log_e_diff = abs((log(ek_max) - log(ek_min))/log(10));
        r1 = floor(log_e_diff/log_pi_diff/q);
        r2 = floor(q*log_e_diff);
        if (r1 > 50 && r2 > 10, break, B *= 2);
    );
    printf("log_pi_appr = %s\nr1 = %d, r2 = %d\n", log_pi_appr, r1, r2);

    n_min = floor((log(ek_min)/log(10)-log_pi_diff)*q);
    n_max = ceil((log(ek_max)/log(10)+log_pi_diff)*q);
    e_min = q;
    for (n = n_min, n_max,
        e = lift(Mod(n, q)/Mod(p, q));
        e_log_pi = frac(e * log_pi);
        if (e_log_pi >= log(ek_min)/log(10) && e_log_pi < log(ek_max)/log(10),
            if (e < e_min, e_min = e);
        );
    );
    return(e_min);
}


{
default(realprecision, 100);
K = 50;
ek = calc(K);
printf("E(pi, e, %d) = %d\n", K, ek);
}
