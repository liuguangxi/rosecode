f(n) = {
    my(phi, phi2, k, ret);
    n--; if (n == 0, return(1));
    phi = (1+sqrt(5))/2; phi2 = phi + 1;
    if (ceil(n/phi) == floor((n+1)/phi),
        k = ceil(n/phi); ret = floor(k*phi2) + 1,
        k = ceil(n/phi2); ret = floor(k*phi) + 1;
    );
    return(ret);
}


{
N = 2357111317192329;
s = f(N);
print(s);
}
