{
Idx = 60449125275954117495792271813111202393999762409875012980385044815846361032595450296127862666721532739781384807770642238;
S = "-------------AAABBBDEEEEEEEEFHHIILLLLLLMMNNNNOOOOOOOOOOPPPRRRSSSSSSTTTTTTTUUVWYY";
vs = Vec(S); L = #vs;
vp = numtoperm(L, Idx);
ans = concat(vector(L, i, vs[vp[i]]));
print(ans);
}