dfs(k1, k2) = {
    my(maxscore, z, num, s, n);
    if (mapisdefined(mscore, [k1, k2], &z), return(z));
    if (k1 == 0 || k2 == 0, return([-2*(k1+k2), 0]));

    if (S1[k1] == S2[k2], s = 2; n = 1, s = -1; n = 0);
    [maxscore, num] = dfs(k1 - 1, k2 - 1) + [s, n];
    [s, n] = dfs(k1, k2 - 1) + [-2, 0];
    if (s > maxscore, [maxscore, num] = [s, n]);
    [s, n] = dfs(k1 - 1, k2) + [-2, 0];
    if (s > maxscore, [maxscore, num] = [s, n]);

    mapput(mscore, [k1, k2], [maxscore, num]);
    return([maxscore, num]);
}


{
Seq1 = "GTAATAGACTCGGAAACGCAACCGTCAGCAAAACGCGTTCGGTCGATCGTAATATGTAAGATCCAATTAGGGCGACCTCTTGTGCGGTCAGTAGGAGTCT";
Seq2 = "ATAACTCTGAATCCCCCGACGTGTCGTGATGGGCGACGGACGGCACCCTTAACGTGATCCTGAACTCCCGTGGGGACCGTTGTCGGTAATGCAGGGTGTG";

S1 = Vec(Seq1); S2 = Vec(Seq2);
len1 = #S1; len2 = #S2;
mscore = Map();
[score, numalign] = dfs(len1, len2);
printf("%d,%d\n", score, numalign);
}
