/*
#black = 0: 8^3
#black = 1: 6*8^2
#black = 2: 12*8
#black = 3: 8
*/


{
prob = 6*8^2/1000 * 1/6 + 12*8/1000 * 2/6 + 8/1000 * 3/6;
print(prob);
}