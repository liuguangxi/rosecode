/* Farm Frenzy */
/* (4,4) */


var x >= 0, integer;    /* wheat */
var y >= 0, integer;    /* rye */

maximize profit:
    500 * x + 300 * y;

s.t. acres: 7 <= x + y <= 10;
s.t. costs: 200 * x + 100 * y <= 1200;
s.t. hours: x + 2 * y <= 12;

solve;

printf "(%d,%d)\n", x, y > "rc12.txt";

end;
