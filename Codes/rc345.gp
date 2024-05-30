{
nmin = 10^3;
a = 1;
for (c = a+2, 10, for (e = c+2, 50, for(g = e+2, 200,
    if (a*c*e*g % 17 != 0, next);
    bdfh = 670*a*c*e*g/17;
    fordiv (bdfh, b,
        if (a < b && b <= c,
            dfh = bdfh / b;
            fordiv (dfh, d,
                if (c < d && d <= e,
                    fh = dfh / d;
                    fordiv (fh, f,
                        if (e < f && f <= g,
                            h = fh /f;
                            if (g < h,
                                if (b-a+d-c+f-e+h-g < nmin,
                                    nmin = b-a+d-c+f-e+h-g;
                                    printf("nmin = %d    %d,%d,%d,%d,%d,%d,%d,%d\n", nmin, a, b, c, d, e, f, g, h);
                                    printf("%d-%d,%d-%d,%d-%d,%d-%d\n\n", a+1,b,c+1,d,e+1,f,g+1,h);
                                );
                            );
                        );
                    );
                );
            );
        );
    );
)));
}
