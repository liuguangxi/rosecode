/*
Transient state:
(1) .
(2) .T
(3) .TH
(4) .THI
(5) .THIS
(6) .I
(7) .E
(8) .EN
(9) .THISI
(10) .THISIS
(11) .THISIST
(12) .THISISTH
(13) .THISISTHE
(14) .THISISTHEE
(15) .THISISTHEEN

Absorbing state:
(16) .THISISTHEEND
(17) .THIS. / .IS / .THE / .END
*/


{
Letter = Vec("ETAOINSRHDLUCMFYWGPBVKXQJZ");
Freq = [1203, 910, 812, 768, 731, 695, 628, 602, 592, 432, 398, 288, 271,
    261, 230, 211, 209, 203, 182, 149, 111, 69, 17, 11, 10, 7];

FreqT = sum(i = 1, #Letter, (Letter[i] == "T") * Freq[i]);
FreqH = sum(i = 1, #Letter, (Letter[i] == "H") * Freq[i]);
FreqI = sum(i = 1, #Letter, (Letter[i] == "I") * Freq[i]);
FreqS = sum(i = 1, #Letter, (Letter[i] == "S") * Freq[i]);
FreqE = sum(i = 1, #Letter, (Letter[i] == "E") * Freq[i]);
FreqN = sum(i = 1, #Letter, (Letter[i] == "N") * Freq[i]);
FreqD = sum(i = 1, #Letter, (Letter[i] == "D") * Freq[i]);

nt = 15; nr = 2;
P = matrix(nt+nr, nt+nr);

P[1,2] = FreqT; P[1,6] = FreqI; P[1,7] = FreqE;
P[1,1] = 10000 - FreqT - FreqI - FreqE;

P[2,2] = FreqT; P[2,3] = FreqH; P[2,6] = FreqI; P[2,7] = FreqE;
P[2,1] = 10000 - FreqT - FreqH - FreqI - FreqE;

P[3,2] = FreqT; P[3,4] = FreqI; P[3,17] = FreqE;
P[3,1] = 10000 - FreqT - FreqI - FreqE;

P[4,2] = FreqT; P[4,5] = FreqS; P[4,6] = FreqI; P[4,7] = FreqE;
P[4,1] = 10000 - FreqT - FreqS - FreqI - FreqE;

P[5,9] = FreqI; P[5,17] = 10000 - FreqI;

P[6,2] = FreqT; P[6,6] = FreqI; P[6,7] = FreqE; P[6,17] = FreqS;
P[6,1] = 10000 - FreqT - FreqI - FreqE - FreqS;

P[7,2] = FreqT; P[7,6] = FreqI; P[7,7] = FreqE; P[7,8] = FreqN;
P[7,1] = 10000 - FreqT - FreqI - FreqE - FreqN;

P[8,2] = FreqT; P[8,6] = FreqI; P[8,7] = FreqE; P[8,17] = FreqD;
P[8,1] = 10000 - FreqT - FreqI - FreqE - FreqD;

P[9,10] = FreqS; P[9,17] = 10000 - FreqS;
P[10,11] = FreqT; P[10,17] = 10000 - FreqT;
P[11,12] = FreqH; P[11,17] = 10000 - FreqH;
P[12,13] = FreqE; P[12,17] = 10000 - FreqE;
P[13,14] = FreqE; P[13,17] = 10000 - FreqE;
P[14,15] = FreqN; P[14,17] = 10000 - FreqN;
P[15,16] = FreqD; P[15,17] = 10000 - FreqD;

P[nt+1, nt+1] = 10000;
P[nt+nr, nt+nr] = 10000;

P /= 10000;

Q = P[1..nt,1..nt];
R = P[1..nt,nt+1..nt+nr];
N = (matid(nt) - Q)^(-1);
B = N * R;
ans = B[1,1];
print(ans);
}
