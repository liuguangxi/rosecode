/* Number with even digits has no solutions */


{
\\ 1 digit
c = 4; s = 2+3+5+7;

\\ 3 digits
forstep (x1 = 3, 7, 4,
    forprime (x2 = 2, 7,
        n = [x1,x2,x1] * [100,10,1]~;
        if (isprime(n), print(n); c++; s += n);
    );
);

\\ 5 digits
forstep (x1 = 3, 7, 4,
    forprime (x2 = 2, 7, forprime (x3 = 2, 7,
        n = [x1,x2,x3,x2,x1] * [10000,1000,100,10,1]~;
        if (isprime(n), print(n); c++; s += n);
    ));
);

\\ 7 digits
forstep (x1 = 3, 7, 4,
    forprime (x2 = 2, 7, forprime (x3 = 2, 7, forprime (x4 = 2, 7,
        n = [x1,x2,x3,x4,x3,x2,x1] * [10^6,10^5,10000,1000,100,10,1]~;
        if (isprime(n), print(n); c++; s += n);
    )));
);

\\ 9 digits
forstep (x1 = 3, 7, 4,
    forprime (x2 = 2, 7, forprime (x3 = 2, 7, forprime (x4 = 2, 7, forprime (x5 = 2, 7,
        n = [x1,x2,x3,x4,x5,x4,x3,x2,x1] * [10^8,10^7,10^6,10^5,10000,1000,100,10,1]~;
        if (isprime(n), print(n); c++; s += n);
    ))));
);

\\ 11 digits
forstep (x1 = 3, 7, 4,
    forprime (x2 = 2, 7, forprime (x3 = 2, 7, forprime (x4 = 2, 7, forprime (x5 = 2, 7,
    forprime (x6 = 2, 7,
        n = [x1,x2,x3,x4,x5,x6,x5,x4,x3,x2,x1] * [10^10,10^9,10^8,10^7,10^6,10^5,10000,1000,100,10,1]~;
        if (isprime(n), print(n); c++; s += n);
    );
    ))));
);

\\ 13 digits
forstep (x1 = 3, 7, 4,
    forprime (x2 = 2, 7, forprime (x3 = 2, 7, forprime (x4 = 2, 7, forprime (x5 = 2, 7,
    forprime (x6 = 2, 7, forprime (x7 = 2, 7,
        n = [x1,x2,x3,x4,x5,x6,x7,x6,x5,x4,x3,x2,x1] * [10^12,10^11,10^10,10^9,10^8,10^7,10^6,10^5,10000,1000,100,10,1]~;
        if (isprime(n), print(n); c++; s += n);
    ));
    ))));
);

\\ 15 digits
forstep (x1 = 3, 7, 4,
    forprime (x2 = 2, 7, forprime (x3 = 2, 7, forprime (x4 = 2, 7, forprime (x5 = 2, 7,
    forprime (x6 = 2, 7, forprime (x7 = 2, 7, forprime (x8 = 2, 7,
        n = [x1,x2,x3,x4,x5,x6,x7,x8,x7,x6,x5,x4,x3,x2,x1] * [10^14,10^13,10^12,10^11,10^10,10^9,10^8,10^7,10^6,10^5,10000,1000,100,10,1]~;
        if (isprime(n), print(n); c++; s += n);
    )));
    ))));
);

\\ 17 digits
forstep (x1 = 3, 7, 4,
    forprime (x2 = 2, 7, forprime (x3 = 2, 7, forprime (x4 = 2, 7, forprime (x5 = 2, 7,
    forprime (x6 = 2, 7, forprime (x7 = 2, 7, forprime (x8 = 2, 7, forprime (x9 = 2, 7,
        n = [x1,x2,x3,x4,x5,x6,x7,x8,x9,x8,x7,x6,x5,x4,x3,x2,x1] * [10^16,10^15,10^14,10^13,10^12,10^11,10^10,10^9,10^8,10^7,10^6,10^5,10000,1000,100,10,1]~;
        if (isprime(n), print(n); c++; s += n);
    ))));
    ))));
);

\\ 19 digits
forstep (x1 = 3, 7, 4,
    forprime (x2 = 2, 7, forprime (x3 = 2, 7, forprime (x4 = 2, 7, forprime (x5 = 2, 7,
    forprime (x6 = 2, 7, forprime (x7 = 2, 7, forprime (x8 = 2, 7, forprime (x9 = 2, 7, forprime (x10 = 2, 7,
        n = [x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x9,x8,x7,x6,x5,x4,x3,x2,x1] * [10^18,10^17,10^16,10^15,10^14,10^13,10^12,10^11,10^10,10^9,10^8,10^7,10^6,10^5,10000,1000,100,10,1]~;
        if (isprime(n), print(n); c++; s += n);
    )))));
    ))));
);

printf("%d,%d\n", c, s);
}
