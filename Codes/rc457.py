from hashlib import md5


def acgt2num(s):
    vs = list(s)
    num = [1 if x == 'A' else 2 if x == 'C' else 3 if x == 'G' else 4 for x in vs]
    return num


def strmatch(s1, s2):
    lens = min(len(s1), len(s2))
    for i in range(lens):
        if s1[i] + s2[i] != 5:
            return False
    return True


# Main
# Input fragments
#Frag = ['CC', 'TGG', 'GG', 'TGCT', 'ACGAT', 'AACC']
Frag = [
'CCGTCCGTTGCCC',
'TGTCTTGAGCTTCGTGCTGAGCACATGTAATCATAC',
'TTATT',
'TGTACAAGCGCGTTTAATGTTATACCAGCATTAATCTACTC',
'GTGAGTGAATGGGTTATAAACCGGCTGTACGGCTGTTGGGTGTACTGGAGCTACTGCCA',
'AGATGGTCAACCCTGCCACATCTCCTCAACATC',
'ACCTCTTCTCGCCTTCACCAGCAAGCATGATT',
'CGAAGCATTGAACAATTT',
'ACCGAACGACTGACATACGCTTTTAAATTCTACCAGTTGGGACGGTGTAGAG',
'ACGTAGGGTATACATTAAACAACCGTTATAGATAT',
'TTTACACTTCTTGTCTTTCCACCGCAATGTCTGTATTCTAAGACGCA',
'GGCCGGCTCTAACCTCGAGACCTATAAATCCAAATTGTAGCTTCAAG',
'CACACT',
'ACATCTGACAGTGTGGAAAAAGACGTTATGTTAGCGGGGT',
'GTGAGTAC',
'ATTTGGATCGCCTGTCGCGTGATTATTAAATCGGGCATAGCTG',
'CACATTCTTCCAACGCCACAAAATGCTGACTTCTAA',
'GCCATTTCGCGCCCGGCCGAGATTGGAGCTCTGGATATTT',
'CGACTCGTGTA',
'CAATCGCGGATATCTTGAGTATACG',
'ATTAAGCACCCTCGCTAAGGGCGGAAC',
'TAACTCGGTGCTTCGTAACTTGTTAAATGGCTTGCTGACTGTATGCGAAAATTTA',
'CATTAGTATGTGGAGAAGAGC',
'ATACAGATTTAATAATACGTAGCTAGGGAGCCACTCATGGTGTAAGAAGGTTGCG',
'AGTTCGCTGCAACTCCGGGCAGAA',
'GTGTTTTACGACTGAAGATTTGTAGACTGTCACACCTTTTTCTGCAA',
'AAAGGTGGCGTTACAGACATAAGATTCTGCGTGCAGCAAACAGTAAGTGGAGACTGAG',
'ATTACGTTAATC',
'CGCC',
'CCGACTGGCAGGCAACGGGAAATGTGAAGAACAG',
'AATAATTTAGCCCGTATCGACCACAGGT',
'ATCCCTCG',
'CGCGTGCCTATGCCGACCATATTGCATCCCATATGTAATTTGTTGGCAATATCTATAT',
'GGGCCTAAACGAGTTCTGTCAAAGGCTCAT',
'AGGTTTAACATCGA',
'CACTTACCCAATATTTGGCCGACATGCCGACAACCCACATGACCTCGATG',
'CCCCGGCGTACAGCTAAAAATAGGCA',
'CAGGTGTTAGCGCCTATAGAACTCATATGCATTCAAGGAG',
'GGCT',
'CGCTTAATCGCCCGGCAGTTATCTTCCGCAGC',
'CAAGGTCCCGCGAGTAGGCCCGGATTTGCTCAAGACAGTTTCCGAGTAGCAGC',
'GATAACTCGGTGGCACCA',
'ACGGTATC',
'TGGTAACAATGCTGCCAAGAG',
'GCATCCACTATTCATTGCGGATTAGTGGGTTCCAGGGCGCTCATCC',
'AGGGCATGTG',
'CGTCGAATAAACATGTTCGCGCAAATTACAATATGGTCGTAATTAGATGAGATTGAGCCA',
'GGAAGTGGTCGTTCGTACTAACTATTGAGCCACCGTGGTGCGCACGGATACGGCTGGTATA',
'CAAAAGAAGTCCTGCACACCGTGTTAAACCTAGCGGACAGCGCACT',
'AATACCGGGGGAGCCTACGTCT',
'TAAGTTCCT',
'GAGTTGTAGTATGTCTAAATTATTATGCATCG',
'TACAATCGCCCCAGCGAATTAGCGGGCCGTCAATAGAAGGCGTCGGGCTGA',
'GACTCGTTTTCTTCAGGACGTGTGGCACA',
'CGACGTTGAGGCCCGTCTTTTATGGCCCCCTCGGATGCAGATAATGCAATTAGGT',
'GTGTCCACCGA',
'TAGTC',
'CGTCGTTTGTCATTCACCTCT',
'AAATTTTCCCCATCGCGCGTCTGCGTAGGTGATAAGTAACGCCTAATCACC',
'TTAAAAGGGGTAGCGCGCAGAC',
'CCGGTAAAGCGCG',
'ATGTCCA',
'TTGACCATTGTTACGACGGTTCTCTA',
'TAATTCGTGGGAGCGATTCC',
'CCGTACACGGGGCCGCATGTCGATTTTTATCCGTACAGAACTCGAAGCA'
]


# Preprocess data
N = len(Frag)
Frag.sort()
Nsym = 0
frag_num = []
for i in range(N):
    frag_num.append(acgt2num(Frag[i]))
    Nsym += len(Frag[i])


# DFS
vuse = [0] * N
num_rest = N
vidx = [[0]*N, [0]*N]
kidx = 0
vidx[0][kidx] = 1
vidx[1][kidx] = 1
vstr1 = [0] * Nsym
kstr1 = 0
vstr2 = [0] * Nsym
kstr2 = 0
isfound = False

while True:
    while vidx[1][kidx] <= N:
        if not vuse[vidx[1][kidx] - 1]:
            str0 = frag_num[vidx[1][kidx] - 1]
            lenstr = len(str0)
            if kstr1 == kstr2:
                vstr1[kstr1:kstr1+lenstr] = str0
                kstr1 += lenstr
                vuse[vidx[1][kidx] - 1] = 1
                num_rest -= 1
                break
            elif kstr1 < kstr2:
                if strmatch(str0, vstr2[kstr1:kstr2]):
                    vstr1[kstr1:kstr1+lenstr] = str0
                    kstr1 += lenstr
                    vuse[vidx[1][kidx] - 1] = 1
                    num_rest -= 1
                    break
            else:
                if strmatch(str0, vstr1[kstr2:kstr1]):
                    vstr2[kstr2:kstr2+lenstr] = str0
                    kstr2 += lenstr
                    vuse[vidx[1][kidx] - 1] = 1
                    num_rest -= 1
                    break
        vidx[1][kidx] += 1

    if vidx[1][kidx] <= N:
        if num_rest == 0 and kstr1 == kstr2:
            isfound = True
            break
        kidx += 1
        if kstr1 <= kstr2:
            vidx[0][kidx] = 1
        else:
            vidx[0][kidx] = 2
        vidx[1][kidx] = 1
    else:
        vidx[0][kidx] = 0
        vidx[1][kidx] = 0
        kidx -= 1
        if kidx < 0:    break
        vuse[vidx[1][kidx] - 1] = 0
        num_rest += 1
        lenstr = len(frag_num[vidx[1][kidx] - 1])
        if vidx[0][kidx] == 1:
            vstr1[kstr1-lenstr:kstr1] = [0] * lenstr
            kstr1 -= lenstr
        else:
            vstr2[kstr2-lenstr:kstr2] = [0] * lenstr
            kstr2 -= lenstr
        vidx[1][kidx] += 1


# Display results
if isfound:
    symrest1 = Nsym // 2
    symrest2 = Nsym // 2
    strand1 = []
    strand2 = []
    for i in range(N):
        str0 = Frag[vidx[1][i] - 1]
        if vidx[0][i] == 1:
            strand1.append(str0)
            symrest1 -= len(str0)
            if symrest1 > 0:
                strand1.append(',')
        else:
            strand2.append(str0)
            symrest2 -= len(str0)
            if symrest2 > 0:
                strand2.append(',')
    strand1 = ''.join(strand1)
    strand2 = ''.join(strand2)
    print(f'Strand 1: {strand1}')
    print(f'Strand 2: {strand2}')
    print(md5(strand1.encode('ascii')).hexdigest())
