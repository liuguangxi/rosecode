var x0 >= 0, integer;    /* # people solved none problem */
var x1 >= 0, integer;    /* # people only solved problem 1 */
var x2 >= 0, integer;    /* # people only solved problem 2 */
var x3 >= 0, integer;    /* # people only solved problem 3 */
var x4 >= 0, integer;    /* # people only solved problem 4 */
var x12 >= 0, integer;    /* # people only solved problem 1 & 2 */
var x13 >= 0, integer;    /* # people only solved problem 1 & 3 */
var x14 >= 0, integer;    /* # people only solved problem 1 & 4 */
var x23 >= 0, integer;    /* # people only solved problem 2 & 3 */
var x24 >= 0, integer;    /* # people only solved problem 2 & 4 */
var x34 >= 0, integer;    /* # people only solved problem 3 & 4 */
var x123 >= 0, integer;    /* # people only solved problem 1 & 2 & 3 */
var x124 >= 0, integer;    /* # people only solved problem 1 & 2 & 4 */
var x134 >= 0, integer;    /* # people only solved problem 1 & 3 & 4 */
var x234 >= 0, integer;    /* # people only solved problem 2 & 3 & 4 */
var x1234 >= 0, integer;    /* # people solved all problem 1 & 2 & 3 & 4 */

maximize profit:
    20 * 10000 - 1000 - 30 * (x12 + x13 + x14 + x23 + x24 + x34) - 50 * (x123 + x124 + x134 + x234) - 100 * x1234;

s.t. allpeople: x0 + x1 + x2 + x3 + x4 + x12 + x13 + x14 + x23 + x24 + x34 + x123 + x124 + x134 + x234 + x1234 = 10000;
s.t. problem1: x1 + x12 + x13 + x14 + x123 + x124 + x134 + x1234 = 5101;
s.t. problem2: x2 + x12 + x23 + x24 + x123 + x124 + x234 + x1234 = 4499;
s.t. problem3: x3 + x13 + x23 + x34 + x123 + x134 + x234 + x1234 = 1312;
s.t. problem4: x4 + x14 + x24 + x34 + x124 + x134 + x234 + x1234 = 148;

solve;

printf "Profit: %d\n", 20 * 10000 - 1000 - 30 * (x12 + x13 + x14 + x23 + x24 + x34) - 50 * (x123 + x124 + x134 + x234) - 100 * x1234 > "rc358_max.txt";
printf "x0: %d\n", x0 >> "rc358_max.txt";
printf "x1: %d, x2: %d, x3: %d, x4: %d\n", x1, x2, x3, x4 >> "rc358_max.txt";
printf "x12: %d, x13: %d, x14: %d, x23: %d, x24: %d, x34: %d\n", x12, x13, x14, x23, x24, x34 >> "rc358_max.txt";
printf "x123: %d, x124: %d, x134: %d, x234: %d\n", x123, x124, x134, x234 >> "rc358_max.txt";
printf "x1234: %d\n", x1234 >> "rc358_max.txt";

end;
