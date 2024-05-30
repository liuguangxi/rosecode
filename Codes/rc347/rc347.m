clc;    clear;

fid = fopen('lip.txt');
s = fgetl(fid);
fclose(fid);
s = s - 0;

lens = length(s);
lens9 = lens*8/9;
s9 = zeros(1, lens9);
k = 1;    r = 0;
for i = 1:lens9
    s9(i) = mod(s(k), 2^(8-r)) * 2^(r+1) + floor(s(k+1) / 2^(7-r));
    if r == 7
        k = k + 2;
    else
        k = k + 1;
    end
    r = mod(r + 9, 8);
end
w = zeros(1, 2^9);    % weights for 0 ~ 2^9-1
for i = 1:lens9
    w(s9(i) + 1) = w(s9(i) + 1) + 1;
end
symbols = 0:2^9-1;
idx = find(w > 0);
symbols = symbols(idx);
w = w(idx);
p = w / lens9;
dic = huffmandict(symbols, p);

hcode = huffmanenco(s9, dic);
fprintf('Coded Bytes = %d\n', ceil(length(hcode)/8));    % 59198
