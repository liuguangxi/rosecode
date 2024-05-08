/*
1,2,4,8,16,19,76,304,823,1216,1646,3292,13168,15637,26336,62548,125096,250192,500384
*/


print_data() = print(select(x -> x>0, Data));


dfs(s, k) = {
    if (k == L,
        if (s + Vdiv[k] == N,
            Data[k] = Vdiv[k]; Found = 1; return;
        );
        if (s == N,
            Data[k] = 0; Found = 1; return;
        );
        ,
        if (s + Vdiv[k] <= N,
            Data[k] = Vdiv[k]; dfs(s + Vdiv[k], k + 1);
            if (Found == 1, return);
        );
        Data[k] = 0;
        dfs(s, k + 1);
        if (Found == 1, return);
    );
}


{
N = 1000768;
Vdiv = divisors(N);
L = #Vdiv - 1; Vdiv = Vdiv[1..L];
Data = vector(L);
Found = 0;
dfs(0, 1);
print_data();
}
