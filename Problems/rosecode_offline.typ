//--------------------------------------------------------------------
// Global setup
#set document(
  title: [RoseCode Unofficial Offline Edition],
  author: ("Guangxi Liu")
)

#let ColorPrimary = rgb("#b45211")
#let ColorSecondary = rgb("#1174b4")

#let FontSerif = "Minion Pro"
#let FontSans = "Myriad Pro"

#let Problems = json("data/prob.json")
#let Results = json("data/res.json")
//--------------------------------------------------------------------


//--------------------------------------------------------------------
// Cover
#[
#set page(paper: "a4")
#set text(font: FontSans)
#v(8em)
#text(size: 36pt)[
  #text(fill: gradient.linear(ColorPrimary, ColorPrimary.lighten(50%)))[*RoseCode*]
]
#v(-2em)
#text(size: 36pt)[
  *Unofficial Offline Edition*
]
#v(-2em)
#text(size: 18pt)[
  *Problem Set From
  #link("https://rosecode.neocities.org")[#text(fill: ColorPrimary)[rosecode.neocities.org]]*
]
#align(right + bottom)[
  #text(size: 14pt)[
    Revision #text(fill: ColorPrimary)[*v2024.1*] \
    July 2024
  ]
]
#pagebreak(weak: true)
]
//--------------------------------------------------------------------


//--------------------------------------------------------------------
// Main body setup
#set page(
  paper: "a4",
  header: [
    #set align(center)
    #box(width: 1fr, inset: (y: 5pt), stroke: (bottom: 0.75pt))[
      #smallcaps[RoseCode Unofficial Offline Edition]
    ]
    #counter(footnote).update(0)
  ],
  footer: [
    #set align(center)
    #text(number-type: "old-style")[
      Page #counter(page).display("1 of 1", both: true)
    ]
  ]
)

#counter(page).update(1)

#set footnote(
  numbering: it =>
    text(fill: ColorSecondary)[#counter(footnote).display("1")]
)

#set text(
  font: FontSerif,
  size: 11pt
)

#set par(
  justify: true
)

#show heading: set text(
  font: FontSans,
  fill: ColorPrimary
)

#show link: set text(fill: ColorSecondary)

#show raw.where(block: true): block.with(
  fill: gradient.linear(ColorSecondary.lighten(85%), ColorSecondary.lighten(95%)),
  width: 100%,
  inset: 5pt
)

#set quote(block: true)
#show quote: set align(center)


#let problem-block(body, number: 1) = {
  [
    #let bookmark-title = [Problem \##number: #Problems.at(number - 1).at("title")]
    #set text(size: 0pt)
    #heading(hide[#bookmark-title])
    #label("p" + str(number))
  ]

  [
    #let title = Problems.at(number - 1).at("title")
    #set text(font: FontSans, size: 14.5pt)
    #box(
      fill: gradient.linear(ColorPrimary, ColorPrimary.lighten(25%)),
      inset: (x: 5pt, y: 5pt)
    )[
      #text(fill: white)[*#number*]
    ]
    #box(inset: (x: 0pt, y: 5pt))[
      #text(fill: ColorPrimary)[#h(8pt) *#title*]
    ]
    #parbreak()
  ]

  [
    #set text(font: FontSans, size: 10pt, weight: "bold")
    #grid(
      fill: ColorPrimary.lighten(90%),
      columns: (2.5fr, 2fr, 1fr, 2fr),
      inset: 6pt,
      Problems.at(number - 1).at("entered"),
      text(fill: ColorPrimary)[by #Problems.at(number - 1).at("authid")],
      [#Problems.at(number - 1).at("pt") xp],
      text(fill: ColorPrimary)[#Problems.at(number - 1).at("type2")]
    )
    #v(10pt)
  ]

  [#body]

  [
    #parbreak()
    #v(10pt)
    #set text(font: FontSans, size: 10pt, weight: "bold")
    #box(
      fill: gradient.linear(ColorPrimary, ColorPrimary.lighten(25%)),
      inset: (x: 5pt, y: 5pt)
    )[
      #text(fill: white)[*Answer*]
    ]
    #if Results.at(number - 1) != "" {[
      #h(-2pt)
      #box(inset: (x: 5pt, y: 5pt), fill: ColorPrimary.lighten(90%))[
        #text(fill: ColorPrimary)[*#Results.at(number - 1)*]
      ]
    ]}
  ]
  pagebreak(weak: true)
}
//--------------------------------------------------------------------


//--------------------------------------------------------------------
// Preface
= Preface
#quote[
_Time may end, but hope will last forever._
]


== About RoseCode
This document collects all the problems from #link("https://rosecode.neocities.org") (RoseCode), which is a website that is along the lines of ProjectEuler. Unfortunately, only the remaining content of the problems can be seen on the website now, and a lot of useful information has been lost.

Due to various reasons, the content of some of the problems are incomplete, and some of them are even unworkable. In addition, the reference answer string is processed by the original answer (see next section), and quite a few answers are misplaced.

Despite all obstacles, the author tries his best to ensure that the content of the problems and the corresponding answers are complete and correct.


== Note for the answer
The _answer_ to each problem is processed from the original answer string. The following example Python code shows the process of getting the final answer.

```python
from hashlib import md5

f = lambda x: md5(md5(x.encode('ascii')).hexdigest().encode('ascii')).hexdigest()

ans = '123456'
print(f'{ans}\n{f(ans)}')
```

The running result is

```
123456
14e1b600b1fd579f47433b88e8d85291
```

This means that if the original answer string is *`123456`*, after processing the final answer string is *`14e1b600b1fd579f47433b88e8d85291`*.

#pagebreak(weak: true)


// Problem #1
#problem-block(number: 1)[
Prime numbers are numbers that are only divisible by $1$ and themselves. The first prime number is $2$. The $10000$th is $104729$.

Find the $78200$th prime number.
]


// Problem #2
#problem-block(number: 2)[
Fibonacci terms are generated by adding previous two terms. So by starting with $1,1$ the sequence would be: $1,1,2,3,5,8,13,21,dots$ and so on.

Find the first Fibonacci term that exceeds $100$ in its digital sum (sum of digits).
]


// Problem #3
#problem-block(number: 3)[
Palindromic prime is a prime number when reversed is the same prime. For example, $191$ is one. Assume all one digit primes are palindromic.

Find sum of all palindromic primes not exceeding one million.
]


// Problem #4
#problem-block(number: 4)[
The pair $3,5$ is special as it is the first prime pair to have difference of two (Twin primes). After this, comes pair $5,7$. The distance between these two pairs is $2$ as it is calculated by subtracting the first member of each pair. Under $100$, the pair $59,61$ has the longest length from such previous pair $41,43$ with the distance of $18$.

Find longest distance of such prime pair, each member below one million, from such previous pair.
]


// Problem #5
#problem-block(number: 5)[
Write a program that will accept a fraction of the form $N/D$, where $N$ is the numerator and $D$ is the denominator, that prints out the decimal representation. If the decimal representation has a repeating sequence of digits, it should be indicated by enclosing it in brackets. For example, $1/3 = .33333333 dots$ is denoted as $.(3)$, and $41/333 = .123123123 dots$ is denoted as $.(123)$.

Typical conversions are:
#par(leading: 11pt)[
$1/3 = .(3)$ \
$22/5 = 4.4$ \
$1/7 = .(142857)$ \
$3/8 = .375$ \
$45/56 = .803(571428)$
]

Sample Run

```
ENTER N,D: 1,7
1/7 = .(142857)
```

What is the answer for the fraction $11/59$?

Source: 1993 USACO Qualifying Round
]


// Problem #6
#problem-block(number: 6)[
Pair $3,7$ is the first concatable prime pair as $3,7,37$ and $73$ are all prime. When each member is below $100$, there are $24$ such pairs.

How many concatable prime pairs exist when each member is below one thousand?
]


// Problem #7
#problem-block(number: 7)[
Number $21$ in base $10$ is special as it is the first two-digit number to have palindromic base $4$ and base $6$. We call a number palindromic if the number stays same when reversed. So, $21$ in base $4$ is $111$ which is also palindromic. Similarly, in base $6$ it is $33$. Find sum of all such numbers in base $10$ under ten million.

Note: All one digit numbers are assumed to be palindromic
]


// Problem #8
#problem-block(number: 8)[
$79$ is $117$ in base $8$. When we reverse $79$ we get $97$. $97$ is also $117$ in base $9$. Find the maximum number under $10$ million that performs this peculiarity. Give your answer in base $8$ or in base $9$.
]


// Problem #9
#problem-block(number: 9)[
The following cryptarithm is a multiplication problem that can be solved by substituting digits from a specified set of $N$ digits into the positions marked with `*`. If the set of prime digits $2,3,5,7$ is selected, the cryptarithm is called a PRIME CRYPTARITHM.

```
      * * *
   x    * *
 -----------
    * * * *
  * * * *
 -----------
  * * * * *
```

Write a program that will find all solutions to the cryptarithm above for any subset of digits from the set $1,2,3,4,5,6,7,8,9$.

Sample Run

```
ENTER A SET OF DIGITS: 23468

      2 2 2
   x    2 2
 -----------
      4 4 4         <3 more not shown>
    4 4 4
 -----------
    4 8 8 4
```

The number of unique solutions = $4$


Test your program with the prime digits $2,3,5,7$. What is the number of unique solutions?

Source: 1993 USACO Qualifying Round 1
]


// Problem #10
#problem-block(number: 10)[
Examine the 6x6 checkerboard below and note that the six checkers are arranged on the board so that one and only one is placed in each row and each column, and there is never more than one in any diagonal. (Diagonals run from southeast to northwest and southwest to northeast and include all diagonals, not just the major two.)

```
     Column
   1 2 3 4 5 6
  -------------
1 | |O| | | | |
  -------------
2 | | | |O| | |
  -------------
3 | | | | | |O|
  -------------
4 |O| | | | | |
  -------------
5 | | |O| | | |
  -------------
6 | | | | |O| |
  -------------
```

The solution shown above is described by the sequence $2 thin 4 thin 6 thin 1 thin 3 thin 5$, which gives the column positions of the checkers for each row from $1$ to $6$.

```
ROW     1 2 3 4 5 6
COLUMN  2 4 6 1 3 5
```

This is one solution to the $6 times 6$ Checker Challenge. Write a program that searches and finds all unique solution sequences to the $6 times 6$ Checker Challenge. What is the total number of solutions found (including reflections and rotations)?

Source: 1993 USACO Qualifying Round 1
]


// Problem #11
#problem-block(number: 11)[
A square arrangement of numbers

```
1 2 3 4 5
2 1 4 5 3
3 4 5 1 2
4 5 2 3 1
5 3 1 2 4
```

is a $5 times 5$ Latin Square because each whole number from $1$ to $5$ appears once and only once in each row and column.

Write a program that will compute the number of $N times N$ Latin Squares whose first row is:

```
1 2 3 4 5 ... N
```

Sample Run
```
ENTER A WHOLE NUMBER (2-9): 4
THE NUMBER OF 4 x 4 LATIN SQUARES IS 24.
```

What is the number of $5 times 5$ Latin squares?

Source: 1993 USACO Qualifying Round 1
]


// Problem #12
#problem-block(number: 12)[
A farmer has $10$ acres to plant in wheat and rye. He has to plant at least $7$ acres. However, he has only $1200$ to spend and each acre of wheat costs $200$ to plant and each acre of rye costs $100$ to plant. Moreover, the farmer has to get the planting done in $12$ hours and it takes an hour to plant an acre of wheat and $2$ hours to plant an acre of rye. If the profit is $500$ per acre of wheat and $300$ per acre of rye, how many acres of each should be planted to maximize profits? Give your answer as a pair in the form $(x,y)$ where $x$: wheat, $y$: rye.
]


// Problem #13
#problem-block(number: 13)[
A perfect number is a positive integer that is equal to the sum of its proper divisors. For example, $6$ is a perfect number because $6=1+2+3$.

$8128$ is also a perfect number. Find the next smallest perfect number that ends with $8128$.
]


// Problem #14
#problem-block(number: 14)[
Consider the following algorithm:
#[
+ input $n$
+ print $n$
+ if $n = 1$ then STOP
+ if $n$ is odd then $n <- 3n + 1$
+ else $n <- n\/2$
+ GOTO 2
]

Given the input $22$, the following sequence of numbers will be printed \ $22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1$.

It is conjectured that the algorithm above will terminate (when a $1$ is printed) for any integral input value. Despite the simplicity of the algorithm, it is unknown whether this conjecture is true. It has been verified, however, for all integers $n$ such that $0 < n < 1000000$. (and, in fact, for many more numbers than this.)

Given an input $n$, it is possible to determine the number of numbers printed (including the $1$). For a given $n$ this is called the cycle-length of $n$. In the example above, the cycle length of $22$ is $16$.

For any two numbers $i$ and $j$ you are to determine the maximum cycle length over all numbers between $i$ and $j$ (inclusive).

What is the answer if $i=1, j=1000000$?
]


// Problem #15
#problem-block(number: 15)[
#set enum(numbering: "(1)")

Given:
+ $X$, $Y$ and $Z$ are different integers between $0$ and $9$ (both included)
+ $(10 times X+Y)/(10 times Y+Z) = X/Z$ (with infinite precision)

How many triplets are there?

Source: Prolog Contest 1 Ithaca
]


// Problem #16
#problem-block(number: 16)[
Kangaroos are fascinating creatures. For one, the idea of carrying around their offspring in a pouch is very cute, and it reminds us of our own ways of transporting babies. For another, they can jump really far. That can be quite useful, in particular if you are a kangaroo stuck in a swamp with only small islands of land, and crocodiles swimming around. In that case, you would rather not land in the water. Besides mere jumping strength, it is also useful to have some computational power to compute how exactly to use that jumping strength to get where you need to go.

Here is how we model Kangaroo movement. Kangaroos can only move North-South or East-West; no other directions (such as diagonals). Kangaroos can jump any integer distance between $1$ and $5$ in one hop, which takes them one unit of time. However, after a longer jump, they have to rest before being able to jump again. Specifically, after jumping distance $d$, the Kangaroo has to rest $(d - 1)^2$ time units before being able to jump again. Also, if the next jump is in a different direction from the previous one, the Kangaroo takes an extra one time unit between the jumps to turn around.

The swamp will be described by a two-dimensional grid. Each entry is either water, denoted by a dot (`.`), or land, denoted by `X`. Two locations will be marked with special symbols. `K` denotes the initial position of the Kangaroo, and `G` is the goal the Kangaroo wants to reach (both of these are of course land). You are to find the shortest time in which the Kangaroo could get to the goal (if at all). It does not matter if the kangaroo is tired when it arrives at its destination; it doesn not have to rest.

What is the answer for the following input?

```
.......XXX......XX.....X.X.XX.
XK....XXXXXXXX..XX............
X......XXXXX....XX.X.X.X....X.
.......XXX....XX..............
..............XX...........XX.
...........................XX.
...XX....XX................XX.
..XXXX.....................X..
..XXXX........................
...XX.........XX....X....XXX..
........XX....XX.X..X..X.XGX..
.......XX................XXX..
```

Source: USC Contest Fall 2008
]


// Problem #17
#problem-block(number: 17)[
Climate changes made the rolling mountains of Alaska a perfect place for all-season skiing. To transform this region into a successful area for skiing, however, ski lifts are needed. People skiing do not like walking upwards. They want to ski downhill; when needed they are willing to ski on the same level for some time.

Optimal use of the area requires that, starting from an arbitrary point, a skier should be able to reach any other point just by skiing downhill or staying at the same level, and occasionally taking a ski lift.

A sufficient amount of ski lifts must be planned and constructed such as to fulfill this condition. On the other hand, building more ski lifts than necessary is a waste of money. What is the minimal number of ski lifts needed?

As ski lifts are built on high poles, we assume that a ski lift can be constructed from any place to any place, regardless of the terrain in between. A ski lift is unidirectional. It is important to know that in Alaska one is not allowed to ski in any other direction than North, South, East or West.

*Input format*

A line with two positive numbers $w$ and $l$ with $1 <= w, l <= 500$: the width and length of the area. $w$ lines, each line containing $l$ positive numbers $h(i,j)$, with $0 <= h(i,j) <= 10^9$, representing the height in each point of the area.

*Input*

#link("https://rosecode.neocities.org/ski.txt")[ski.txt]

Source: Benelux Algorithm Programming Contest 2005
]


// Problem #18
#problem-block(number: 18)[
Zebras are very social animals. Like other members of the horse family, they form groups that tend to stick together and hang out fairly regularly, though not exclusively. (Humans also come to mind in this respect.) Lately, researchers have been trying to understand just how the communities of zebras evolve over time, what triggers changes, and so forth. Of course, all they have to go by is observations of where the zebras are over time. From that, we would like to figure out what are the most natural groups. The assumptions are that (a) if a zebra is part of a group, it tends to spend time close to others in that group, (b) if a zebra is not part of a group, it tends to spend time further away from others in that group, and (c) zebras do not change their group membership very often.

Let us make this more precise. You will be given a sequence of observations of zebras. For each observation time, you will have the exact location of each zebra. The distance between two zebras is exactly their Euclidean (straight-line) distance. We assume that there are exactly two groups of zebras in the herd, and will denote them by two colors. What we want to do is color each zebra either red or blue for each time step, expressing membership to one or the other group. To express assumption (c) above, we will assess a penalty of some given number $c$ every time a zebra changes colors. To express assumptions (a) and (b), we look at the distance $d(i, j)$ between every pair $i, j$ of zebras. If $i$ and $j$ are of the same color, then we assess a penalty of $a dot d(i, j)$ for this pair. If i and j are of opposite colors, then we assess a penalty of $-b dot d(i, j)$ (i.e., we give a bonus).

Thus, if you are given a proposed labeling of all zebras with either red or blue for each time step, you can compute how good an explanation of zebra activity it is. Your goal is to find the best possible labeling, in the sense that it has the smallest possible total penalty. But you will only need to output the total penalty of the labeling, not the labeling itself.

*Input Format*

The first line of data set contains two integers $z, t$, the number of zebras $2 <= z <= 10$, and the number of time steps $2 <= t <= 50$. Next comes a line with three floating point numbers $a, b, c >= 0$, the penalty multipliers. This is followed by $t$ lines, describing zebra positions. Each line contains $2z$ floating point numbers, giving the positions of the zebras in the form `x1 y1 x2 y2 ... xz yz`. The first line contains the positions at time $1$, the second line at time $2$, and so forth.

*Input*

#link("https://rosecode.neocities.org/zebra.txt")[zebra.txt]

Give your answer rounded to two decimals like `[wholepart].cd`

Source: USC Contest Fall 2008
]


// Problem #19
#problem-block(number: 19)[
Here is a DFA given in the table form

#table(
  columns: (auto, auto, auto),
  align: center,
  inset: 5pt,
  table.header([*State*], [*a*], [*b*]),
  [1], [2], [4],
  [2], [1], [4],
  [3], [1], [4],
  [4], [3], [3]
)

In the minimal representation which states can be represented as just one state? What number is formed if you concatenate the state numbers you have found in increasing order?
]


// Problem #20
#problem-block(number: 20)[
Let
$
A(x) = mat(delim: "|",
  x, 2x, x^2;
  x+1, 2x+1, x^2+1;
  x+2, 2x+2, x^2+2
)
$
including the determinant operator.

Compute the sum of all $A(x)$ where $x$ varies from $1$ to $10^9$ inclusive.
]


// Problem #21
#problem-block(number: 21)[
Find the sum of the one hundred thousand smallest positive integers that use only the digits $1$ and $0$ and are perfectly divisible by $19$. We're still dealing with base $10$.
]


// Problem #22
#problem-block(number: 22)[
A happy number is built by adding the squares of its digits. Doing this permanently, the numbers will end in $1$ or $4$.

If a positive integer ends with $1$, then it is a happy number.

The first few happy prime numbers are: \
$7, 13, 19, 23, 31, 79, 97, 103, 109, dots$

What is the sum of the first $30000$ happy prime numbers?
]


// Problem #23
#problem-block(number: 23)[
A hexagonal number is computed as follows using the formula: \
$H(n) = n(2n-1)$

As shown, the first 5 hexagonal numbers are: \
$1, 6, 15, 28, 45$

How many of the first $100000000$ hexagonal numbers are divisible by all the numbers from $1$ through $15$?
]


// Problem #24
#problem-block(number: 24)[
What is the sum of the digits of $50000!$?
]


// Problem #25
#problem-block(number: 25)[
Given the Triangle of primes.

```
2
3 5
7 11 13
17 19 23 29
31 37 41 43 47
53 59 61 67 71 73
...
```

The sum of the $6$th row is $384$. Give the sum of the $1000$th row.
]


// Problem #26
#problem-block(number: 26)[
What is the *digital sum* of *sum of numbers* in the *1000001th* row of Pascal Triangle?
]


// Problem #27
#problem-block(number: 27)[
Consider a function $f:A->B$. What is the digital sum of number of surjective functions if $|A|=1678, |B|=1543$?
]


// Problem #28
#problem-block(number: 28)[
Assume you have $3$ kinds of fruit in a basket: Apples, Bananas, Coconuts. And assume you have an unlimited source of these fruits. Then there are $15$ ways to pick $4$ fruits

```
4A, 4B, 4C
3A1B, 3A1C, 3B1A, 3B1C, 3C1A, 3C1B
2A2B, 2A2C, 2B2C
1A1B2C, 1A1C2B, 1B1C2A
```

Calculate how many ways to pick up $100000$ fruits from $55555$ kinds. What is the digital sum of this huge number?

#text(fill: rgb(255, 0, 0))[Note: Problem reseted in Nov 26, 2009 as the answer in database was wrong.]
]


// Problem #29
#problem-block(number: 29)[
How many integers between $1$ and $2009$ are divisible by a non-trivial cube ($p^3$ where $p>1$)?

Note: Please solve by pencil and paper. It is very easy by programming.
]


// Problem #30
#problem-block(number: 30)[
Consider the equation \
$a+b+c+dots.h.c+y+z=100$ \
($a$ to $z$: There are $26$ variables in total)

How many solutions (number of all distinct $[a,b,c,dots]$ lists) are there if all $a,b,c,dots$ are odd and positive?
]


// Problem #31
#problem-block(number: 31)[
In the card game of preference, the deck of $32$ cards($4$-suit, $7$-to-ace) is dealt among three players, so that every player gets $10$ cards and the two remaining cards form the widow. How many ways are there to deal hands in such a way that the widow does not consist of two aces?
]


// Problem #32
#problem-block(number: 32)[
Calculate the probability that in the game of preference ($32$ dealt among three players, $10$ cards each, and $2$ cards go to the widow) every player gets precisely one ace. Give the ratio in lowest terms.
]


// Problem #33
#problem-block(number: 33)[
Consider the equation ($x,y$ integers) \
$1773 bold(x) + 1865 bold(y) = 1$

What is the smallest positive integer value for $x$?
]


// Problem #34
#problem-block(number: 34)[
You roll a pair of fair dice. Compute the expectation (expected value) of the maximum of the two results. Give the answer in lowest terms.

Info: #link("http://en.wikipedia.org/wiki/Expected_value")[Expected Value: Wikipedia]
]


// Problem #35
#problem-block(number: 35)[
What is digital sum of the number of required moves to solve $300000$-disk Tower of Hanoi puzzle?
]


// Problem #36
#problem-block(number: 36)[
What is the number of non-isomorphic (distinct) simple graphs on $28$ nodes?
]


// Problem #37
#problem-block(number: 37)[
Mergesort is a recursive sorting algortihm defined as:
- Assume length of input ($n$) is a power of two
- If $n=1$, return the element
- If $n>1$, break list into two
- call mergesort on each half
- merge the sorted lists

How many comparisons are required (in worst case) to sort a list with $2^150$ elements using mergesort?
]


// Problem #38
#problem-block(number: 38)[
You have this rather mysterious message in decimal ascii form:

```
50 31 22 23 14 29 26 11 16 73 26 8 22 14 26 11 18 13 83 12 4 73 1 0 22 5 93 101
```

You only know that the key to decipher this message is $4$ lettered. Find the secret message and type it.
]


// Problem #39
#problem-block(number: 39)[
Write "Fuck World" in Brainfuck language.
]


// Problem #40
#problem-block(number: 40)[
Count the number of unique words in this file: #link("https://rosecode.neocities.org/ipsum.txt")[ipsum.txt].
]


// Problem #41
#problem-block(number: 41)[
Write a Brainfuck code to output the input.
]


// Problem #42
#problem-block(number: 42)[
What is the mean distance between two random points in a unit square? Give your answer to five decimal places.
]


// Problem #43
#problem-block(number: 43)[
Write a Brainfuck code that outputs the input in reverse.
]


// Problem #44
#problem-block(number: 44)[
A guy has $8$ five-sided dice numbered from $1$ to $5$. A girl has $6$ six-sided dice numbered from $1$ to $6$. They roll their dice and compare totals. The max total wins and it is a draw if sums are equal. What is the probability that the guy beats the girl? Round your answer to $9$ decimal places.
]


// Problem #45
#problem-block(number: 45)[
Derive a formula for the number of strings of length $n$ over the alphabet ${0, 1, 2}$ which have no consecutive zeroes. What is the answer for $n=150$?
]


// Problem #46
#problem-block(number: 46)[
Write a code in Brainfuck that given positive integer input $n$ outputs $n$th Fibonacci number. *Assume 1st and 2nd are both 1.* Assume that the input will be between $1$ and $13$.
]


// Problem #47
#problem-block(number: 47)[
In this game of lottery $6$ different numbers are chosen among $49$. How many different combinations are there? Compute it, namely $49$ choose $6$.

Contributed by: *Gizmore*
]


// Problem #48
#problem-block(number: 48)[
I lost my password to a .rar file. It is heavily encrypted and I only get $73$ passwords per second. Luckily I remember parts of my password, but I am not sure how long it would take.

The static string `Giz` appears somewhere or maybe does not.

There is definitely a fake 20th century birth year (only the year) somewhere.

There are $1$-$8$ special characters (scattered and no multiple instances) from this charset: `#+%&*!^;:-?/`

Finally there is a word from my dictionary ($65535$ words) somewhere.

Note that any block can appear anywhere in the password. Could you please tell me how many days it will take to try every password if the speed is at $73$ pass/s? Round your answer to $6$ decimal places.

Contributed by: *Gizmore*
]


// Problem #49
#problem-block(number: 49)[
Write a Brainfuck code that given a binary string outputs its decimal value. For simplicity only at max $8$-bit binary values will be provided. Note that leading zeroes will be omitted.
]


// Problem #50
#problem-block(number: 50)[
Write a Brainfuck code that given positive integer $n$, outputs its digital sum meaning the sum of every digit.
]


// Problem #51
#problem-block(number: 51)[
Write a Brainfuck code that given $n$, outputs $n$'s totient value. $n$ will be random between $1$ and $255$.
]


// Problem #52
#problem-block(number: 52)[
A rectangular grid of $4$ by $3$:

#table(
  columns: (15pt, 15pt, 15pt, 15pt),
  inset: (x: 20pt, y: 8pt),
  [], [], [], [],
  [], [], [], [],
  [], [], [], []
)

includes a total of $60$ rectangles (including squares). How many rectangles are there in a $1453$ by $1881$ grid?
]


// Problem #53
#problem-block(number: 53)[
Write a Brainfuck code that given a string, outputs hex code of given string.
]


// Problem #54
#problem-block(number: 54)[
```
11 21 22 31 32 41 33 42 51 43 52 61 ?
```

Hint: _feel it_
]


// Problem #55
#problem-block(number: 55)[
A number can be converted to a palindrome by summing the cube of each digit and repeating this procedure. For example $36$ converts to $99$ in $2$ steps. Likewise $17$ converts to $737$ in $6$ steps. We assume a number is not convertible in this way if it does not reach a palindrome in at most $100$ steps. Below one million, which number has to undergo most steps (if there are more than one, assume smallest). Give your answer as `number.steps`
]


// Problem #56
#problem-block(number: 56)[
Square root of $2$ can be represented as $[1;(2)]$ where $(2)$ means $2$ repeats _ad infinitum_. In a similar way, $sqrt(23)=[4;(1,3,1,8)]$ (Note: #link("http://mathworld.wolfram.com/ContinuedFraction.html")[Continued Fraction])

Surprisingly, \
$upright(e) = [2; 1,2,1, 1,4,1, 1,6,1 , dots , 1,2k,1, dots]$.

The first ten terms in the sequence of convergents for $upright(e)$ are: \
$2, 3, 8\/3, 11\/4, 19\/7, 87\/32, 106\/39, 193\/71, 1264\/465, 1457\/536, dots$

Find the sum of digits in the numerator of the $1000$th convergent of the continued fraction for $upright(e)$.

Note: An extension of Project Euler #link("https://projecteuler.net/problem=65")[Problem 65]
]


// Problem #57
#problem-block(number: 57)[
Write a counter function that counts from $1$ to one million (inclusive) but only counts numbers whose digits don't repeat. As an example, $98,(99,100,101),102$ is a jump of $4$. Submit total count of numbers and biggest jump. Format: `total.jump`
]


// Problem #58
#problem-block(number: 58)[
Have you ever seen the movie Gattaca?

All capitals.

Hint: _matching strand?_
]


// Problem #59
#problem-block(number: 59)[
Let $|V|=1000$, and assume $W$ a subset of $V$ is selected at random from the collection of all subsets of $V$. Let us form the complete bipartite graph $G$ with parts $W$ and $V backslash W$ (in other words, we connect two vertices if and only if one of them is in $W$ while another is not). What is the expected number of edges in $G$? Round to an integer if needed.
]


// Problem #60
#problem-block(number: 60)[
A pandigital number makes use of the digits $1$ through $9$ at least once but not in any particular order. For example: \
$146523798$ is a $9$ digit pandigital.

What is the sum of values of $i$ such that $3^i$ has it's last $9$ digits pandigital from $1$ to $9$, where $1<=i<=1000000$?
]


// Problem #61
#problem-block(number: 61)[
Write a Brainfuck code that given positive integer $n$, outputs its factorial.
]


// Problem #62
#problem-block(number: 62)[
Suppose that $n$ ovals (an oval is a closed curve that does not cross over itself) are drawn on the plane such that no three ovals meet in a point and each pair of ovals intersects in exactly two points. How many distinct regions of the plane are create by $n$ ovals? Provide a closed form answer including $n$.

Note: Use `^` as the power operator. Do not use paranthesis (or spaces) anywhere. Use precedence rules instead. You should write terms decreasingly in terms of power of $n$.
]


// Problem #63
#problem-block(number: 63)[
Suppose we want to find the number of ways to parenthesize the expression \
$a+b+c+....+y+z$ ($26$ terms) \
so that a parenthesized form of the expression reflects the process of adding two terms. How many ways are there?
]


// Problem #64
#problem-block(number: 64)[
Write a Brainfuck code that given string $n$, it sorts characters in string in increasingly alphabetic order then outputs this sorted string. Thus, given "haeusl" it outputs "aehlsu".
]


// Problem #65
#problem-block(number: 65)[
Find two six sided dice, such that the probability of each sum from $2$ to $12$ is the same as two standard dice. Each side must have least one dot. Negative numbers are not allowed. There is another answer besides two standard $123456$ dice. Format of the answer should be `111222,113344` (just an example) where first integer is the smaller and integers acquired by concatenation increasingly.
]


// Problem #66
#problem-block(number: 66)[
Write a Brainfuck code that given input string $x$, outputs number of unique characters.
]


// Problem #67
#problem-block(number: 67)[
Write a Brainfuck code that given $n$, outputs $n$th prime. Assume $n$ will be between $1$ and $54$.
]


// Problem #68
#problem-block(number: 68)[
Bob and Stephen are brothers. Stephen is twelve years older than Bob. What is the maximum possible age of Bob such that the ratio between ages of two brothers is an integer?
]


// Problem #69
#problem-block(number: 69)[
How many real solutions are there for the following equation: \
$x^2010+2009=2008x$
]


// Problem #70
#problem-block(number: 70)[
Given $x+y=<2009$ and $y+z<=2010$. Suppose the number of non-negative integer solutions to these inequalities is in the form $2k(6k+1)(6k+2)$ with $k$ positive, find $k$.
]


// Problem #71
#problem-block(number: 71)[
```
5 85 987 4482 ?
```

Hint 1: _Think title_ \
Hint 2: _4 digits_
]


// Problem #72
#problem-block(number: 72)[
A $9$-digit representation of 8-puzzle `abcdefgh0` corresponds to:

```
a b c
d e f
g h
```

where `0` is the place of the empty cell.

Given $100$ start states in #link("https://rosecode.neocities.org/8puzzle.txt")[8puzzle.txt] compute the average of shortest path distance (that takes the least number of moves) to goal `253176408`. You can use any of the suiting heuristic functions you like. Round your answer to $2$ decimal places.
]


// Problem #73
#problem-block(number: 73)[
Consider a mouse in a maze. There are four possible paths such that path $1$ takes $5.32$ minutes to escape, path $2$ takes $3.12$ minutes to espace, path $3$ takes $8.24$ minutes to return to same place and path $4$ takes $2.35$ minutes to return to same place. Given that the mouse chooses any of the four paths at random what is the expected time of escape in minutes? Round your answer to $4$ decimal places.
]


// Problem #74
#problem-block(number: 74)[
Write a Brainfuck code that shifts input string chars by one and outputs it. Ex. `javaist` $->$ `kbwbjtu`
]


// Problem #75
#problem-block(number: 75)[
Here is a simple question:

```
2+2=?
```

The problem here is that there is no usual way to submit the solution. You need to figure that out by yourself!!
]


// Problem #76
#problem-block(number: 76)[
Here is a flash dice simulator. It is somewhat biased, however. You need to roll two $6$s in order to get the secret code. If you do not hack somehow, you will never be able to get that lucky!! When you get the code submit like you did for problem $75$.
]


// Problem #77
#problem-block(number: 77)[
In this problem we provide the answer. It is: javaist. However, the server will first decode the answer you submit. Unfortunately, the encode/decode algorithm used is unknown. However, we provide a basic flash tool to help you. Given an encoded text it provides the original data. Feel free to experiment and then encode the actual answer before submitting.

Note: The returned string of flash tool is only a crude report of actual encoded string. It is not totally dependable. So examine its source code, find the intermediate page and that way your experimentation with encoding will be more dependable.
]


// Problem #78
#problem-block(number: 78)[
#link("https://rosecode.neocities.org/p78.php")[p78.php] creates a random png image. Your task is to detect the average RGB values for the image and POST it to the same page (p78.php) via `rgb=RAvg:GAvg:BAvg&submit=true`. Round each average to $2$ decimal places. Note that you have $1$ second to do so after you see the random image.
]


// Problem #79
#problem-block(number: 79)[
In this problem you will be supplied with several thousands of random triangle vertice positions(in cartesian coordinates). Your task is to compute number of triangles that contain the origin.

#link("https://rosecode.neocities.org/p79.php")[p79.php] supplies the list of triangles in the form `Ax,Ay,Bx,By,Cx,Cy` per line.(where ABC are the vertices). When you get the answer POST to same page (p79.php) as `amount=A&submit79=true`. You have $1.86$ secs to do so.
]


// Problem #80
#problem-block(number: 80)[
Here is a barcode like image. Can you extract the code?
]


// Problem #81
#problem-block(number: 81)[
In this problem you need to interrogate an ex-agent prisoner. You can perform $4$ actions. The prisoner's state is kept as a session variable on the server side and you will be able to see it once you get to the secret page. You also receive a text regarding the state.

These $4$ actions translate to some basic arithmetic operations done on the variable. When the condition is met the prisoner will confess the secret code.

Note: You need to make the variable somehow $1000$ to see the password. Brute force is not necessary from now on. It is simple reverse engineering.
]


// Problem #82
#problem-block(number: 82)[
The radical of $n$, $r(n)$, is the product of distinct prime factors of $n$. For example, $156 = 2 times 2 times 3 times 13$, so $r(156) = 2 times 3 times 13 = 78$. If we calculate $r(n)$ for $1 <= n <= 10$, then sort them on $r(n)$, and sorting on $n$ if the radical values are equal, we get: \
$1,2,4,8,3,9,5,6,7,10$

let $S(k)$ be the $k$th element on the sorted list. So $S(3) = 4$, $S(7) = 5$ etc. #link("https://rosecode.neocities.org/p82.php")[p82.php] will print random $M$ and $N$ values where $r(i)$ is sorted for $1 <= i <= M$ and the answer is $S(N)$. POST to p82.php as `ans=S(N)&submit82=true`. You have $1.12$ secs to calculate!!.

Note: M will be between $8000$ and $10000$, whereas $N$ will be between $1000$ and $3000$.

Fix: Fixed index problem. Now the S array starts from $1$ as described above instead of starting from $0$.
]


// Problem #83
#problem-block(number: 83)[
#link("https://rosecode.neocities.org/p83.php")[p83.php] creates some random binary looking data. Your task is to decode that into english letters. (not necessarily forming a meaningful word!). Then POST as `ans=letters&submit83=true`. Time limit is $0.7$ secs.
]


// Problem #84
#problem-block(number: 84)[
On the real number axis, Goppy the Grasshopper can hop along (starting from $0$) the axis either way, $364$ or $715$ units length. What can be the minimum distance of any hopped point to point $2010$.
]


// Problem #85
#problem-block(number: 85)[
There is an integer sequence:

```
1, 8, 216, 13824, 4741632, 11119431168, 19421724672, 263128269312, 224188386112438272,
391914614322266112, ?, ...
```

Find the number which the question mark represents.
]


// Problem #86
#problem-block(number: 86)[
For $n$ bigger than $1$, how many multiplications we need to perform (at least) to calculate $n$ to the power $13$?
]


// Problem #87
#problem-block(number: 87)[
Looking the same, but having different wieghts, we have 50 balls. We also have a $3$-slot scales. This scales can sort $3$ balls from least to most in weight with a single measurement and it only accepts $3$ balls (no more no less) at a time.
The question then is, how many measurements (at minimum) we need to perform to find the $2$nd lightest ball?
]


// Problem #88
#problem-block(number: 88)[
One of the professors in Math department gives a lot of homework. We have $3$ particular students in this class called Alice, Ben, and Clark. When Alice and Ben works together they finish a day's homework in $5$ hours. Clark and Alice together finish it in $3$ hours as they kind of fancy each other `:)` and like to work together. Ben and Clark, together, finish in $4$ hours. One day both Ben and Clark are sick and they cannot work. Alice has to do it alone. How long will it take (in hours)? Round to $2$ decimal places.
]


// Problem #89
#problem-block(number: 89)[
You are a reporter of Chicago Tribune Entertainment section. There was a celebrity couple-exclusive party in Chicago. It was a formal and fabulous one `:)` so everyone in the party had hanshaked others excluding their own partners. Your paparazzo were able to capture $144$ handshakes. You know that they are the best in this job. So your director in the newspaper wants you to report how many couples there were in the party?
]


// Problem #90
#problem-block(number: 90)[
You are the head of a jewelry design firm. One of your clients asked you to design a specific brand of jewelry that will be called UnHumDrum. So here is the challenge. The materials will used are composed of $2$ crimson red, $2$ metallic blue, and $2$ cyanic green beads. (there is no difference in these beads other than their color). You have to line these beads on a linear (not circular) silken strand and beads with same color must not be next to each other to avoid humdrum. (there comes the brand name `:)`) So in your catalog for this new brand, how many distinct products can you name?
]


// Problem #91
#problem-block(number: 91)[
What minimum number of friends do I need to have to be sure that at least $7$ of my friends have their birthdays in same month?
]


// Problem #92
#problem-block(number: 92)[
We have a mega box composed of small cubes attached together. The box is a $3$d rectangular shape in that each dimension includes $9,10,11$ cubes respectively ($9 times 10 times 11$ cubes included). We paint the whole surface of this box to red. The question is that how many cubes will not be painted at all?
]


// Problem #93
#problem-block(number: 93)[
On a conventional chess board($8 times 8$), we want to place $3$ rooks. How many different placements are there so that they won't have a chance to attack each other?
]


// Problem #94
#problem-block(number: 94)[
Mr. Bombastic wants to enqueue his students in a row. There are $7$ students in the class that are queued according to their heights from shortest to longest currently. Mr. Bombastic has a taste of fashion and does not like orderly stuff. So he decides to disrupt the queue. However, the school directors only permit $2$ but only $2$ swaps starting from height order. A swap is between *any* two students. So how many different queue options does Mr. Bombastic have by exactly two successive swaps?

Note: There was a confusion about number of swaps available. It is EXACTLY two swaps. No more no less.
]


// Problem #95
#problem-block(number: 95)[
You have $10$ distinct army units in a strategy game online. One of your allies warns you that you will witness an upcoming attack. This attack will simultaneously target $4$ areas of your empire. As a commander, you want to evaluate your options. You decide that each area needs at least one army unit and also you have to deploy all of your $10$ units no matter what. How many possible deployment options are there?

Note: There was a spacing error in the answer in the database. Problem fixed on 26 July 2012.
]


// Problem #96
#problem-block(number: 96)[
Some compression has been done on #link("https://rosecode.neocities.org/box1000box.gz")[this file]. Solution lies deep inside.
]


// Problem #97
#problem-block(number: 97)[
```
10 29 36 bb 61 07 c3 82 90 b1 a6 ?
```

Hint 1: _think baseic_ \
Hint 2: _think as a whole_
]


// Problem #98
#problem-block(number: 98)[
```
20,23,5,14,20,25,20,23,5,14,20,25,20,8,18,5,5,6,9,22,5,6,15,21,18,20,5,5,14,20,23,...
```

Get the rule for this sequence. Then what term waits longest to make its first appearance, tell me?
]


// Problem #99
#problem-block(number: 99)[
#[
#show "25": set text(fill: red)
#show "16": set text(fill: green)
#show "18": set text(fill: orange)
#show "15": set text(fill: gray)

```
88 op. 63 = 25
25 op. 9 = 16
38 op. 16 = 18
33 op. 18 = 15
32 op. 15 = x
```
]

Find the rule then find `x`, but think out of the box. `op.` is *not* a conventional operator.
]


// Problem #100
#problem-block(number: 100)[
#[
#show "18": set text(weight: "bold")
#show "14": set text(weight: "bold")
#show "22": set text(weight: "bold")
#show "x": set text(weight: "bold")
#show "40": set text(weight: "bold")
#show "35": set text(weight: "bold")
#show "15": set text(weight: "bold")
#show "20": set text(weight: "bold")

```
34-16 = 18
32-18 = 14
36-14 = 22
46-22 = x
64-x  = 40
75-40 = 35
50-35 = 15
35-15 = 20
```
]

Think out of the box again!! Submit `x`. "`-`" is not necessarily subtraction operator.
]


// Problem #101
#problem-block(number: 101)[
Your task is to inject `<script>alert()</script>` into #link("https://rosecode.neocities.org/p100.php")[this page]. Note that there are some crude protection and illusions on the way. When you get the pass after injection just submit here.
]


// Problem #102
#problem-block(number: 102)[
This is our starter exe challenge. The solution is obtained through a slight! modification. We are dealing with command line (so expect no UI for now) Feel free to discuss spoiler free thoughts on the forum.

#link("https://rosecode.neocities.org/apps/intro1.zip")[Download the App]
]


// Problem #103
#problem-block(number: 103)[
Another intro exe challenge. Still we are dealing in command line. This one lacks some arguments obviously.

#link("https://rosecode.neocities.org/apps/intro2.zip")[Download the App]
]


// Problem #104
#problem-block(number: 104)[
Some clicking involved!

#link("https://rosecode.neocities.org/apps/UnClickable.exe")[Download the App]
]


// Problem #105
#problem-block(number: 105)[
If you place $1$ to $8$ into this puzzle

```
*	*	*
  *	*	*
  *	*
```

where no consecutive ($+1$ / $-1$) will be adjacent to each other (left, right, up, down, up-right, etc., all directions), you will have $6$ solutions. Namely, one is this:

```
7 4 6
  1 8 2
  3 5
```

So the question is, how many solutions are there for $1$ to $10$ for this puzzle

```
*	*	*
  *	*	*
*	*
  *	*
```
]


// Problem #106
#problem-block(number: 106)[
Here you have a #link("https://rosecode.neocities.org/real/1/ins/")[link] to an insurance website. This insurance company has suspended its services lately due to its underpopularity. Your friend John Milkway is a customer of this website and has already paid for his insurance plan. He wants his insurance back. Aware of your hacking skills he requested help. Help him to get what he wants.

Hint 1: _robots_ \
Hint 2: _\<Limit\>_

Select area to reveal hints if desired.
]


// Problem #107
#problem-block(number: 107)[
This time javaist.com needs your help. There is a secret hacking team called Munati. They have chosen javaist.com as their newest target. Find exploit and login to their administration before it is too late.

#link("https://rosecode.neocities.org/real/2/")[Link to Munati]

Hint 1: _schema_

#text(fill: rgb(255, 0, 0))[NOTE: Problem is unavailable/unsolvable till a second notice due to database issues. Sorry for inconvenience...]
]


// Problem #108
#problem-block(number: 108)[
The following message has been encrypted using the RSA algorithm (#link("http://en.wikipedia.org/wiki/RSA")).

```
Message:
5270520056270255633349794102662146088700587067743698074774401192
3847352489345495988265259619286488631483317732994244643357354751
9287620596940036558335740983810271503064948492663425315576482108
0559744153567574381389598019296701861993253450006887163420818773
64884130165379971128518570467092626371748600039
```

For the conversion from text to number, treat a text of $N$ bytes as $N times 8$-bit big endian number as in the following examples:

```
YOU = 89,79,85 -> hex: 594F55 decimal: 5853013
YOU CAN = 89,79,85,32,67,65,78 -> hex: 594F552043414E decimal: 25138499959341390
```

You are given the following RSA public key:

```
N =
6000448200243096997311180274736010139143866945550988201685002174
8739658862996422859619109213678968055145301683382976222210480135
9987695864415136344185954945286773854249588357461032878749312395
9570387283082631329238518405786607791478421823609345485233086548
71204913382882966214741283716047066022304286877

E =
5158023707740549673024298923137970117927796628442809247177892775
1105717909512676627114980499027410324845069540466241220902950388
3395360985550494492934002445385787731172407347263592136446777198
2606935670578340411244533070952883031679573061445213299472912441
18700665840856941580663774265885674204692471913
```

Can you decrypt the message?

Anwser format: The secret phrase
]


// Problem #109
#problem-block(number: 109)[
by *sinan*

How many times must a die with $6$ faces be thrown, on average, until one face appears $4$ times?

For example, one set of throws might be $1,2,1,4,3,5,2,4,6,1,3,1$.

Submit your answer as `a/b`, where $a$ and $b$ are two relatively prime, positive integers.
]


// Problem #110
#problem-block(number: 110)[
A box contains `r` red balls and `b` blue balls. Balls are removed sequentially from the box (without replacement). What is the expected number of balls left in the box at the first instant at which all the remaining balls are of the same colour?

Give your answer in closed form and simplify as much as you can, use paranthesis where needed. After simplification, there will be a few possible answers depending on ordering of the terms and only one will be accepted so try all.
]


// Problem #111
#problem-block(number: 111)[
Let's define a fast-growing sequence. \
$F_n = 2^2^n + 1, n >= 1$

Now let's calculate the sum $s$ of all pairwise gcd (namely sum of greatest common divisors of all $2$ element combinations). Now the sequence starts with $n=1$ and goes up to $n=x$. Give the answer as a polynomial in $x$. Output format is `(a,b,c)` where $a x^2 + b x + c$ is the polynomial. Use reals with one digit after the decimal point.
]


// Problem #112
#problem-block(number: 112)[
Mirror (Palindromic) prime is a prime number when reversed is the same prime.
Assume all one digit primes are mirror primes.

Find the sum of all mirror primes with all *prime digits* not exceeding $10^20$.

Answer format: `count,sum`

Example: `8,2227` for all mirror primes with all *prime digits* not exceeding $10^3$ ($2$, $3$, $5$, $7$, $353$, $373$, $727$, $757$).
]


// Problem #113
#problem-block(number: 113)[
by *Philippe_57721*

Let $P[X,n] = (1 + X + X^2)^n$

$P[X,7] = X^14 + 7 X^13 + 28 X^12 + 77 X^11 + 161 X^10 + 266 X^9 + 357 X^8 + 393 X^7 + 357 X^6 + 266 X^5 + 161 X^4 + 77 X^3 + 28 X^2 + 7 X + 1$

It contains $11$ odd coefficients: $1,7,77,161,357,393,357,161,77,7,1$

How many odd coefficients are there in $P[X,6700417]$?

*[My timing: < 100 ms]*
]


// Problem #114
#problem-block(number: 114)[
Let $a(n)$ be the $n$-th term of a sequence.

We have the following relation: \
$a(n) = 3 dot a(n-1) - 2 dot a(n-2) + 1 dot a(n-3)$

What is $a(1)$ if we have the following values: \
$a(10^100 + 0) = 0$ \
$a(10^100 + 1) = 1$ \
$a(10^100 + 2) = 2$

Submit your answer as $a(1) mod 10^9$.

Problem maintainer: *sinan*
]


// Problem #115
#problem-block(number: 115)[
Order the numbers $1$ to $66$ in such a way that sum of any $2$ consecutive numbers is a square number. In case there are multiple solutions, find the lexicographically first solution.

Answer format: concatenate every $5$th number starting with the 1st. (i.e: $1$st, $6$th, $11$th, ..., $66$th)

Example: `831116` for $1$ to $16$ (#text(fill: rgb(255, 0, 0))[$8$], $1$, $15$, $10$, $6$, #text(fill: rgb(255, 0, 0))[$3$], $13$, $12$, $4$, $5$, #text(fill: rgb(255, 0, 0))[$11$], $14$, $2$, $7$, $9$, #text(fill: rgb(255, 0, 0))[$16$])
]


// Problem #116
#problem-block(number: 116)[
See p319.
#footnote[Actually #link(<p323>)[Problem 323].]
The same definition and the same answer format. Find those with *100th biggest area* for $R = 10^10 + 19$.

*[My timing: < 10 s]*
]


// Problem #117
#problem-block(number: 117)[
Author *Philippe_57721*

A partition of $n$ is pure if it can express every number between $1$ and $n$ in exactly one way.

There are $8$ pure partitions of $11$:
- $6 med 3 med 1 med 1 = $ $1$ $(1+1)$ $3$ $(3+1)$ $(3+1+1)$ $6$ $(6+1)$ $(6+1+1)$ $(6+3)$ $(6+3+1)$ $(6+3+1+1+1)$
- $6 med 2 med 2 med 1 = $ $1$ $2$ $(2+1)$ $(2+2)$ $(2+2+1)$ $6$ $(6+1)$ $(6+2)$ $(6+2+1)$ $(6+2+2)$ $(6+2+2+1)$
- $6 med 1 med 1 med 1 med 1 med 1 = $ $1$ $(1+1)$ $(1+1+1)$ $(1+1+1+1)$ $(1+1+1+1+1+1)$ $6$ $(6+1)$ $(6+1+1)$ $(6+1+1+1)$ $(6+1+1+1+1)$ $(6+1+1+1+1+1+1)$
- $4 med 4 med 2 med 1 = $ $1$ $2$ $(2+1)$ $4$ $(4+1)$ $(4+2)$ $(4+2+1)$ $(4+4)$ $(4+4+1)$ $(4+4+2)$ $(4+4+2+1)$
- $4 med 4 med 1 med 1 med 1 = $ $1$ $(1+1)$ $(1+1+1)$ $4$ $(4+1)$ $(4+1+1)$ $(4+1+1+1)$ $(4+4)$ $(4+4+1)$ $(4+4+1+1)$ $(4+4+1+1+1)$
- $3 med 3 med 3 med 1 med 1 = $ $1$ $(1+1)$ $3$ $(3+1)$ $(3+1+1)$ $(3+3)$ $(3+3+1)$ $(3+3+1+1)$ $(3+3+3)$ $(3+3+3+1)$ $(3+3+3+1+1)$
- $2 med 2 med 2 med 2 med 2 med 1 = $ $1$ $2$ $(2+1)$ $(2+2)$ $(2+2+1)$ $(2+2+2)$ $(2+2+2+1)$ $(2+2+2+2)$ $(2+2+2+2+1)$ $(2+2+2+2+2)$ $(2+2+2+2+2+1)$
- $1 med 1 med 1 med 1 med 1 med 1 med 1 med 1 med 1 med 1 med 1 = $ $1$ $(1+1)$ $(1+1+1)$ $(1+1+1+1)$ $(1+1+1+1+1)$ $(1+1+1+1+1+1)$ $(1+1+1+1+1+1+1)$ $(1+1+1+1+1+1+1+1)$ $(1+1+1+1+1+1+1+1+1+)$ $(1+1+1+1+1+1+1+1+1+1)$ $(1+1+1+1+1+1+1+1+1+1+1)$

How many pure partitions of $46079$ are there?

*[My timing: < 100 ms]*
]


// Problem #118
#problem-block(number: 118)[
Find the biggest number whose any $4$ consecutive digits sum to a square number and whose any decimal digit is not used more than $5$ times.

For example $522007$ is such a number: $5+2+2+0=9$, $2+2+0+0=4$, $2+0+0+7=9$.
]


// Problem #119
#problem-block(number: 119)[
Let's define: \
$"R2"(x) = x^(1/2)$ (Square root) \
$"R3"(x) = x^(1/3)$ (Cubic root)

We can simplify the following expression: \
`R3(R3(2)-1)` as \
`R3(1/9)-R3(2/9) + R3(4/9)`

LaTeX code
$ root(3, root(3, 2) - 1) = root(3, 1\/9) + root(3, 2\/9)root(3, 4\/9) $

Can you simplify `R2(R3(3645)-R3(2916))`?

LaTeX code
$ sqrt(root(3, 3645) - root(3, 2916)) $

Format answer: a linear combination of radicands in increasing order using functions `R2`, `R3` and without spaces.

Hint: The anwser involves only small integers ...
]


// Problem #120
#problem-block(number: 120)[
Alice and Bob have the following RSA keys:

```
N_bob =
2843320233792542251053357394068088686668524975752636080093537940
4832527514764874620628848105181825527933880102457169730719923244
6420151499813375523635289637990354962034693574665424583399133573
0583501632679081431737342001818666796295631297455573102373116440
3029788484704936984714437598885024284453243844454411794042986345
2670573135811710297531056679013108703134713805990185300653031156
4180092399756052224998536204529486287954472923574337261846322017
890592838801890702039

E_bob =
2291100640658304898982037736299578548614658498374369307423059101
7753909793205446710905103866626852874140382358105613997851675753
6616368494790527495119970061488145079661142528335377919451554688
6154257484268335107367291548215957325536731933203947342597628607
0538102530714442994442646163672237217358454654896394943346204459
0665520882478282704144094054610779463057719130141630088734441774
4643471937489057261616554090115047189679240761528659032842549170
461539414559766262563

N_alice =
5686640467585084502106714788136177373337049951505272160187075880
9665055029529749241257696210363651055867760204914339461439846489
2840302999626752018801395151071678016047051400133923004670186013
9988684396623348180130983267413984406693145186191663434333107341
4271159645546495517290635898239652290125489708412903139175746507
8882509062160255488830168051051374738819714402801269575387131769
8468196572196081277369024478340281325985826876817304126462736931 162058746229329458443

E_alice =
5532204639026134156498081092471471626870989697962125080810121970
0937589706597407035452447205974152734582820015569746612727007206
2814426400049844220852036436793883376956881347807180964186086536
6805991700540784345980142718081120280543581590237686483113697701
6509366984984445443725555441703117867313078723749470914317101582
9520122197714627967971392769730377826127068782925537780549266077
9768718083990120844013377666526983516809292705750575751662270100
621679600058468454699
```

Alice sends Bob the following message:

```
M_AtoB =
1396364112413623642374178953014019904568061507434558505408267555
8231810369233960158591102037668709444252754006802542256490072017
0291609574950964015823622596731476468470628411816615719782348534
7273167553704712490006234283555813449834048635758312335972910209
5849958053264948388306938543259511664955402250394909679552507339
2828805017197137725781299915845926173013085987451784686823149814
4313379547441762202636503884816587950694638762568426358881638049
169947376779771961136
```

What should Bob send back to Alice?

Input format: The first $100$ digits of the message encrypted using Alice's public key

*[My timing: < 1 m]*
]


// Problem #121
#problem-block(number: 121)[
Author *Philippe_57721*

We are reading the decimal part of PI by slices of $10$ digits: \
$1415926535, 8979323846, 2643383279, 5028841971,dots$

In the first $20000000$ digits, how many slices are the closest of $1415926535$ (not included) in the sense of the Damerau-Levenshtein distance?

Answer format: `Count,(Slice with the closest euclidian distance)`

Example: `3,1145726635` (for the first $2000000$ digits)

*[My timing: 35 sec]*

PS: As there are two slightly different algorithms for this distance, the problem is using the restricted edit distance version.
]


// Problem #122
#problem-block(number: 122)[
For $1 <= x,y <= 1000$, the smallest possible value of $|x dot "PI" - y dot upright(E)|$ is reached for $(x,y) = (777,898)$ ($"PI" = 3.141592 dots$, $upright(E) = 2.71828 dots$)

Which pair $(x,y) <= 10^20$ does yield the smallest value?

Answer format: `x,y`
]


// Problem #123
#problem-block(number: 123)[
Let there be creatures with different $N$ colors $(1,dots,N)$ for $N>7$. Let $"num"(i)$ be the number of creatures with $i$-th color on a specific day.

The following events occur within an $N$-day period.

On the $i$-th day of the period:

number of cretures with $i$-th color increase by $1000$ more than the sum of existing creatures with $(i+1)$-th, $(i+2)$-th and twice the $(i+3)$-th colors. \
$"num"(i) = "num"(i) + "num"(i+1) + "num"(i+2) + 2 dot "num"(i+3) + 1000$

number of ceatures with $(i+4)$-th color becomes $17$ more than twice the existing creatures of that color. \
$"num"(i+4) = 2 dot "num"(i+4) + 17$

All the $(i+5)$-th colored creatures but one change their color to $i$-th color (i.e. one of them doesn't change its color).

number of creatures with $(i+6)$-th color quadruples. \
$"num"(i+6) = 4 dot "num"(i+6)$

Find the total number of creatures after $10^19$ days if $N=11$ and initially there is $1$ creature of each color.

Assume that the first day is the first day of the period.

Note: $(i+n)$-th color should mean $((i+n)-N)$-th color if $i+n>N$. For example if $i=9$ then $(i+4)$-th should mean 2nd ($9+4-11=2$)

Input format: total $mod 10^9$

Example: `619784765` for $100$th day when $N=10$.

*[My timing: < 1 s]*
]


// Problem #124
#problem-block(number: 124)[
Author *Philippe_57721*

We are reading the decimal parts of PI and E by slices of $10$ digits: \
$"PI" = 1415926535, 8979323846, 2643383279, 5028841971, dots$ \
$upright(E) = 7182818284, 5904523536, 0287471352, 6624977572, dots$

What is the "first" slice appearing in both constants?

"first" means it requires the minimum numbers of digits in the decimal parts.

For slices of $5$ digits, the answer would be: $32823$

*[My timing: < 3 sec]*
]


// Problem #125
#problem-block(number: 125)[
Two friends, Arya and Bran are being held captive in separate places. They request a trial by game from their captivators.

Here is the deal: Arya has to choose a random number between $1$ and $101010101$ (inclusive). Bran has to choose also but between $1$ and $303030303$ (inclusive). There is no possible communication between them and they will only be freed if the sum of their numbers is odd. Otherwise they are doomed forever.

What is the probability of them being freed? Give the answer as an irreducible fraction.
]


// Problem #126
#problem-block(number: 126)[
Mr. Bombastic wants to enqueue his students in a row. There are $50$ students in the class that are queued according to their heights from shortest to longest currently.

Mr. Bombastic has a taste of fashion and does not like orderly stuff. So he decides to disrupt the queue. However, the school directors only permit $20$ but only $20$ swaps.

A swap is between any two students. So how many different queue options does Mr. Bombastic have such that at least $30$ or more students are not at their original places after exactly twenty successive swaps?

*[My timing: < 1 s]*
]


// Problem #127
#problem-block(number: 127)[
A factorisation of $N$ in factors is fine if each factor contains only $1$ prime number.

$6! = 720$ possesses $10$ fine factorisations:
- $5 med 9 med 16$
- $3 med 3 med 5 med 16$
- $2 med 5 med 8 med 9$
- $2 med 3 med 3 med 5 med 8$
- $4 med 4 med 5 med 9$
- $3 med 3 med 4 med 4 med 5$
- $2 med 2 med 4 med 5 med 9$
- $2 med 2 med 3 med 3 med 4 med 5$
- $2 med 2 med 2 med 2 med 5 med 9$
- $2 med 2 med 2 med 2 med 3 med 3 med 5$

How many fine factorisations are there for $10000!$.

Give the digital sum of this large number.

*[My timing: 1 sec]*
]


// Problem #128
#problem-block(number: 128)[
Let $B$ be the binary digits of an integer $N$. $B = {b_1, b_2, b_3, dots, b_n}$, $b_1$ is the least significant bit and $b_n = 1$.

Consider the subsets of $B$ whose elements are alternately $0$ and $1$.

Example: $N = 40$, $B = {0, 0, 0, 1, 0, 1}$.

There are $11$ such flip-flop subsets (including the empty set):

#table(
  columns: (auto, auto),
  align: center,
  inset: 5pt,
  table.header([*Index*], [*Values*]),
  [$[]$], [${}$],
  [$[1,4]$], [${0,1}$],
  [$[1,6]$], [${0,1}$],
  [$[2,4]$], [${0,1}$],
  [$[2,6]$], [${0,1}$],
  [$[3,4]$], [${0,1}$],
  [$[3,6]$], [${0,1}$],
  [$[5,6]$], [${0,1}$],
  [$[1,4,5,6]$], [${0,1,0,1}$],
  [$[2,4,5,6]$], [${0,1,0,1}$],
  [$[3,4,5,6]$], [${0,1,0,1}$]
)

How many flip-flop subsets are there for $N = 1234567891011121314$?

*[My timing: < 100 ms]*
]


// Problem #129
#problem-block(number: 129)[
World cup 2014 got crazier then ever.

Each new day a new team registers to world cup with an insane match schedule. Team registered at day $i$ dictates that they will only be able to play $i$ days and then they will take rest for i days after and this pattern will continue on.

In an example team registered at day $1$ will have an availability schedule like: \
$10101010 dots$ (where $1$ denotes available)

Availability for Team registered in day $2$: \
$011001100 dots$

Availability for Team registered in day $3$: \
$00111000111 dots$

So on and so forth ...

The administration wants to match up all teams at $i$th day. So, number of available teams at day $i$ must be even to do that.

The question is just for mathematical enthusiasm and it may make no sense. So, how many days will *NOT* be valid for such a matching if the world cup lasted for $10^18$ days?
]


// Problem #130
#problem-block(number: 130)[
In 1947, William Mills proved the following theorem:

There exists a real number $M$ such as $[M^(3^k)]$ is a prime number for all $k >= 1$ ($[x]$ is the integer part of $x$).

Find the smallest real $P$ such as $[P^(2^k)]$ is prime for $k$ in ${1,2,3,4,5,6,7}$.

Answer format: Round your answer to $30$ digits after the decimal point

*[My timing: < 1 sec]*
]


// Problem #131
#problem-block(number: 131)[
The Champernowne constant is the real number whose decimal part is the concatenation of all positive integers: \
$C = 0.1234567891011121314151617181920 dots$

At which index does appear the first occurence of the substring $803396454804396$?

Hint: The substring $91$ appears at index $9$.

*[My timing: < 100 ms]*
]


// Problem #132
#problem-block(number: 132)[
In the main hall of the King's palace there are pillars disposed in a rectangular grid $N times M$.

The king wants to dispose $4$ guards at the $4$ directions of each pillar.
A guard at the east of a pillar is at the west of the next pillar, etc ...

Being mathematically inclined, the king wants that for each pillar, there are exactly $2$ guards looking at it and $2$ guards turning their back.

Here is an example with $2 times 3$ pillars (and $17$ guards):

#grid(
  columns: (16pt,)*7,
  align: center,
  inset: (x: 8pt, y: 4pt),
  [], [$arrow.b$], [], [$arrow.t$], [], [$arrow.t$], [],
  [$arrow.l$], [$circle$], [$arrow.r$], [$circle$], [$arrow.r$], [$circle$], [$arrow.l$],
  [], [$arrow.t$], [], [$arrow.t$], [], [$arrow.b$], [],
  [$arrow.r$], [$circle$], [$arrow.r$], [$circle$], [$arrow.r$], [$circle$], [$arrow.r$],
  [], [$arrow.t$], [], [$arrow.t$], [], [$arrow.b$], []
)

How many possible configurations are there for $4 times 6$ pillars?

You are given: $374$ configurations for $2 times 3$ pillars.

*[My timing: 25 sec]*
]


// Problem #133
#problem-block(number: 133)[
See the problem 130.
#footnote([Actually #link(<p132>)[Problem 132].])
Find a recurrence relation for $M times 8$ grid for $M>0$.

Then how many configurations are there for $8^88 times 8$ grid?

Input format: enter the rightmost $20$ digits

Hint: Solve the p130 first.
#footnote([Actually #link(<p132>)[Problem 132].])
Once solved, you can access to a reasonably fast code in the problem forum. If you opt to use it, you need to improve it to solve this one. Then you need to calculate the solutions for $M=1,2,dots,72$ to find a recurrence equation.

*[My timing: 45 s]*
]


// Problem #134
#problem-block(number: 134)[
$105$ is the smallest integer which can be decomposed in $10$ ways as sum of distinct Fibonacci numbers:
- $1 med 2 med 5 med 8 med 13 med 21 med 55$
- $1 med 2 med 5 med 8 med 34 med 55$
- $1 med 2 med 5 med 8 med 89$
- $1 med 2 med 13 med 34 med 55$
- $1 med 2 med 13 med 89$
- $3 med 5 med 8 med 13 med 21 med 55$
- $3 med 5 med 8 med 34 med 55$
- $3 med 5 med 8 med 89$
- $3 med 13 med 34 med 55$
- $3 med 13 med 89$

What is the smallest integer with $5000$ decompositions?

*[My timing: 80 sec]*
]


// Problem #135
#problem-block(number: 135)[
Consider the primitive Phytagorean triangles with an hypotenuse equal to a Pythagorean prime (i.e. a prime of the form $4n+1$).

How many such triangles are there if their hypotenuses are between $10^19$ and $10^19+10^6$?

Input format: `count,sum of the smallest sides`

Example: `11,248` for such triangles with hypotenuses in the range $[1,100]$.

*[My timing: < 8 s]*
]


// Problem #136
#problem-block(number: 136)[
Let $n = "product"(p=2, 2 times 10^13, "GCD"(((p-1)!+1)\/p,p))$, where $p$ runs on primes in the $[2,2 times 10^13]$ interval. Find the prime factorization of $n$.

Answer format: `p1,p2,...` (the prime factors (in increasing order) separated by commas)
]


// Problem #137
#problem-block(number: 137)[
Let $n=a^3+b^3+c^3-3 dot a dot b dot c$ for $a=6^58$, $b=9^77$ and $c=10^107$. Find the largest prime factor of $n$.

Answer format: the first $15$ digits of $p$ (where $p$ is the largest prime factor of $n$)
]


// Problem #138
#problem-block(number: 138)[
Factorize

```
n=607276355939551395694982966044853363251342292177823373417587 84713877172821406508105108904580762643099722451038071790577629 66146955927832350716773086591287243257004809800687612881198923 12964954781339200674374192464853793312653411362168644077995148 82737480091560848572467009817477287506184262337350899238591586 60165210989162315162237390274079347400510539774234802757173409 900779266325776828376103361629
```

if you know that $n = p dot q dot r dot s dot t$ (where $p < q < r < s < t$ are primes) and $a(k)=p^k+q^k+r^k+s^k+t^k$ is also given for $k=1,2,3,4$.

```
a(1)=453306060916445726446955842710001266645415882171369174540 545924454461622792521197

a(2)=412388085910145742639378306590809549247806487325798372900 59245194079972906154093103939592496434982514076077514851921775 290041532158103511462156470745708110025037

a(3)=376457151856844823991928212346099344993790369186748265217 38654613892459171474496511969709382919811744994610512839233935 48261024280834398924731925789449892141131187714843927528816158 972950469861033059950606994804630313833406221358401579103605

a(4)=344837785052229879929633968218624753055360189677589857384 06632682262315858765640669324039738708246441562105120956216321 57297123761957784882209548382514367318717411453259136909844948 96073358196417987776533296882038572085793093406337685989015708 73462550791352914700063280706923742527650079450664756326761568
5644489544816085
```

Answer format: `L(p),L(q),L(r),L(s),L(t)` (where $L(x)$ is the first five digits of $x$)
]


// Problem #139
#problem-block(number: 139)[
There is a $30$ disk layout as shown below (from bottom to top) - *not necessarily reached by way of always making the optimal moves*:

```
1| 21 13 8 5 3 2 1
2| 25 16 9 4
3| 30 29 28 27 26 24 23 22 20 19 18 17 15 14 12 11 10 7 6
```

Target is to move all the disks to the second peg. To reach that target, what would be the layout after $10^9$ *optimal* moves and what would be total of the moves if we assign $12$ for a move from first to second, $13$ for a move from first to third, etc. (possible moves would be $12,13,21,23,31,32$)?

Input format: `1st peg,2nd peg,3rd peg,total`

Example: `10965,321,874,2191` for the following

First layout for a $10$-disk configuration:

```
1| 10 9 8 5 4
2| 7 6 3
3| 2 1
```

The layout after $100$ moves targeting to move all the disks to the $3$rd peg:

```
1| 10 9 6 5
2| 3 2 1
3| 8 7 4
```

$italic("total") = 2191$
]


// Problem #140
#problem-block(number: 140)[
$C$ is the Champernowne constant (See problem 129).
#footnote([Actually #link(<p131>)[Problem 131].])

Define $K(n) = [C dot (10^10^n)]$ where $[x]$ is the integer part of $x$ (the first $10^n$ digits of $C$).

Example: $K(1) = 1234567891$.

What is the digital sum of the digital sum of $K(100)$?

You are given: \
$K(10) = 44567901235$ \
$K(15) = 4441049382716054$ \
$K(20) = 441486267257142575580$

*[My timing: < 100 ms]*
]


// Problem #141
#problem-block(number: 141)[
$p=79888923798664049$ divides $n=a^b+c^d$ for some $0 < a,b,c,d < 18000$ (integers) where $a < c$. Find $n$, so the $a,b,c,d$ quadruplet. The solution is unique.

Answer format: `a,b,c,d` (where $a < c$)

*[My timing: 61 seconds]*
]


// Problem #142
#problem-block(number: 142)[
On an event there are three possible outcomes. The provided odds on these are: $2$, $3$ and $7$. Suppose that you have $m=614889782588491410$ (money), and you can place bets on all of these $3$ outcomes. What is the maximal profit that you can reach (indepedently from the occuring outcome)? The answer is an integer.

Answer format: `profit`
]


// Problem #143
#problem-block(number: 143)[
For $a,b,c,d$ all being positive integers, we have the following: \
$L_1: y=(b\/a) dot x$ \
$L_2: y=-(a\/b) dot x+a$ \
$L_1$ and $L_2$ cross at a $P(c,d)$ point. \
The distances from $P$ to origin $(0,0)$ and to $(0,a)$ and to $(b,0)$ points are all integers.

Let $f(R)$ denote the number of $(a,b,c,d)$ solutions if $P$ is inside $x^2+y^2=R^2$ circle.

You are given: $f(10^5)=3782$.

What is $f(10^19)$?

*[My timing: < 100 ms]*
]


// Problem #144
#problem-block(number: 144)[
Find a recurrence relation for the following sequence: \
$1, 2, 3, 5, 8, 3, 11, 14, 25, 39, 64, 25, 89, 114, 203, 317, 520, 203, 723, 926,dots$

Then what is the $10^100$-th number modulo $10^9$?
]


// Problem #145
#problem-block(number: 145)[
Assume a $D$ point inside an $A B C$ equilateral triangle with $A D=x$, $B D=y$, $C D=z$, $0 < x <= y <= z < 100$ and $x,y,z$ are all integers.

Let the length of the sides ($s$) of the triangle be a function of $x,y,z$: $s=f(x,y,z)$.

Find all such triangles.

Input format: `cnt,sum of s's` ($3$ digits after decimal point)

Example: `13,59.831` for $0 < x <= y <= z < 5$.
]


// Problem #146
#problem-block(number: 146)[

Assume a $D$ point on the AB side of an ABC equilateral triangle with $A D=x$, $B D=y$, $C D=z$, $0 < x < y < z$ and $x,y,z$ are all integers.

Let the sides of the ABC triangle be equal to $s=x+y$.

Find all such triangles for $s<10^8$.

Input format: `cnt,sum of z's,sum of s's`

Example: `35,1853,2081` for $s<100$.

*[My timing: < 10 s]*
]


// Problem #147
#problem-block(number: 147)[
The function `T` is defined as:

```js
T(x,y,z) =
	  if x <= y
		    return y
	  else
		    return T(T(x-1,y,z),T(y-1,z,x),T(z-1,x,y))
```

The function `U` is defined as: \
`U(n) = T(n,0,n+1)`

We consider the number of times the *else* clause in the `T` function is invoked when computing `U(n)` (no memoization). Let $E(n)$ this number.

You are given $E(5) = 223$.

What is $E(100)$?

Answer format: Give the digital sum of this huge number
]


// Problem #148
#problem-block(number: 148)[
$36$ can be written in $9$ ways as product of factors $> 1$:
- ${36}$
- ${3,12}$
- ${4,9}$
- ${6,6}$
- ${2,18}$
- ${3,3,4}$
- ${2,3,6}$
- ${2,2,9}$
- ${2,2,3,3}$

A number is highly composite if it has more divisors than all smaller numbers.

What is the first highly composite number which can be written in more than $10^8$ ways as product of factors $> 1$?

Answer format: `n,(number of products)`

Example: `20160,1261` (for a threshold of $1000$)

*[My timing: 45 sec]*
]


// Problem #149
#problem-block(number: 149)[
Let $P$ be the product of first $20$ primes. \
$P="prod"(i=1,20,"prime"(i))=557940830126698960967415390$

In how many ways can $200 dot P$ be written as product of factors $> 1$?

*[My timing: < 10 s]*
]


// Problem #150
#problem-block(number: 150)[
In a game of Hanoi with $n$ disks, we can consider the layout after $m$ moves as a permutation of ${1, dots, n}$.

For instance, with $15$ disks, after $12345$ moves the layout is:
- `Peg-1 : 7 8 9 10 11 12 15`
- `Peg-2 : 1 4 5 6 13 14`
- `Peg-3 : 2 3`

corresponding to permutation: `7 8 9 10 11 12 15 1 4 5 6 13 14 2 3`

The index of this permutation in lexicographic order is $563569656784$.

With $70$ disks, what is the index of the permutation corresponding to the layout after $123456789101112131415$ moves?

*[My timing: < 100 ms]*
]


// Problem #151
#problem-block(number: 151)[
For $a,b,c,d$ all being positive integers, consider $2$ similar triangles with the following lengths: \
$T_1: a,b,c med (a < b < c)$ \
$T_2: b,c,d med (b < c < d)$

What is the smallest pair of such triangles for which the ratio $(a+b+c)\/(a+b-c)$ first exceeds $10^10$?

Input format: `perimeter of T1 (a+b+c)`
]


// Problem #152
#problem-block(number: 152)[
Condider $A(x_a,y_a)$, $B(x_b,y_b)$, $C(x_c,y_c)$, $D(x_d,y_d)$ lattice points in the first quadrant (i.e. coordinates with integer x,y: $x>=0$ and $y>=0$).

$A B$ segment is parallel to $D C$ and $A D$ parallel to $B C$.

Consider $N$ points $M_1, M_2, dots, M_N$ on $B C$ segment that split $B C$ into $N$ equal segments: \
For $x_c>x_b$ and $y_c>y_b$, \
$M_1 (x_b+1 dot (x_c-x_b)\/N, y_b+1 dot (y_c-y_b)\/N)$, \
$M_2 (x_b+2 dot (x_c-x_b)\/N, y_b+2 dot (y_c-y_b)\/N)$, \
$dots$ \
$M_N (x_b+N dot (x_c-x_b)\/N, y_b+N dot (y_c-y_b)\/N)=C(x_c,y_c)$.

$M_1, M_2, dots, M_N$ are *not necessarily lattice points* but all the line segments drawn from $A$ to $M_1, M_2, dots, M_N$ cross $B D$ segment at lattice points.

What is the smallest area of $A B C D$ you can get for $N=1000$?

Input format: $"Area"(A B C D) mod 10^9$
]


// Problem #153
#problem-block(number: 153)[
For $a,b,c$ being positive *coprime* integers and $a < b < c$, consider the following 2 integer sided squares: \
$S_1: A(0,0); B(c,0); C(c,c); D(0,c)$ \
$S_2: A'(a,0); B'(a+b,a); C'(b,a+b); D'(0,b)$

What is the best approximation for $"Area"(S_1)\/"Area"(S_2)=2$ if $"Area"(S_2)<10^24$? In other words find the $(a,b,c)$ triples that minimize $|"Area"(S_1)\/"Area"(S_2)-2|$.

Input format: enter the list of "a" values separated by commas (possibly more than one)

Example: `a1,a2,...,an` ($italic("a1") < italic("a2") < dots.h.c < italic("an")$)
]


// Problem #154
#problem-block(number: 154)[
Let $P(x) = x^19 + 6$ \
Let $G(n) = "GCD"( P(n), P(n+1))$

The sequence ${G(1), G(2), G(3), dots}$ seems constant and equal to $1$ for an awful long time ...

What is the first $n$ for which $G(n) > 1$?

Answer format: `n`

*[My timing: < 5 sec]*
]


// Problem #155
#problem-block(number: 155)[
If we apply the permutation $P$ with index $I$ (in lexicographic order) to the string $S$ for the following values:

```
I = 366899275
S = "-EHILNOOSTTU"
```

we get
$P = {10,3,2,1,9,7,5,12,11,4,8,6}$ \
=> `"THE-SOLUTION"` (Take the $10$th char, then the $3$rd, ... in $1$-based origin)

Apply the permutation P with index I to the string S for the following values:

```
I =
6044912527595411749579227181311120239399976240987501298038504481
5846361032595450296127862666721532739781384807770642238
S =
"-------------AAABBBDEEEEEEEEFHHIILLLLLLMMNNNNOOOOOOOOOOPPPRRRSSSSSSTTTTTTTUUVWYY"
```

and you'll get a good lead to solve problem 152.
#footnote[Actually #link(<p154>)[Problem 154].]

Answer format: the string
]


// Problem #156
#problem-block(number: 156)[
See the following code:

```pascal
function(N)
begin
    UP=101
    DOWN=211
    FACTOR=-2
    temp=0
    loop for each decimal digit of N from left to right
    begin // loop
        if digit is equal to 1; add UP to temp
        else if digit is equal to 2; subtract DOWN from temp
        else if digit is equal to 3; multiply temp by FACTOR
    end // loop
    return temp
end
```

What is the smallest $N$ for which $"function"(N)$ returns $100000001$?

*[My timing: < 1 m]*
]


// Problem #157
#problem-block(number: 157)[
A beautiful theorem of elementary geometry only discovered in 1898 by Frank Morley states: _In any triangle, the three points of intersection of the adjacent angle trisectors form an equilateral triangle._

What is the side of the Morley's triangle for the integer sided triangle: $(20424, 24167, 29791)$. It's a rational number.

Answer format: `P/Q` \
(in irreductible form)
]


// Problem #158
#problem-block(number: 158)[
Find an integer sided isoceles triangle
- whose perimeter is between $94000$ and $95000$
- whose Morley's triangle has a rational side

Answer format: `a,b,p/q`
- $a < b$ are the $2$ sides of the isoceles triangle ($a$ and $b$ are coprime) \
- $p\/q$ is the side of the Morley's triangle in irreductible form

*[My timing: 15 min ...]*
]


// Problem #159
#problem-block(number: 159)[
Find the smallest $n > 0$ such that $"Fibonacci"(n)$ ends in nine nines. \
$F(1)=1, F(2)=1, F(3)=2$

by *Buri*
]


// Problem #160
#problem-block(number: 160)[
Let the following function

```pascal
function(n)
begin
	  count = 0
	  for i in 1 to n
		    for j in (i+1) to n
			      if 1 = GCD(i,j)
				        count = count+1
	  return count
end
```

What is $"function"(123456789)$.

You are given: $"function"(10^5) = 3039650753$.

*[My timing: 80 sec]*

PS: I slightly changed the parameter (and the answer) as the original solution might be easily found on the web.
]


// Problem #161
#problem-block(number: 161)[
A golygon is a polygon:
- whose all angles are right
- whose lengths are the consecutive integers $1,2,3,dots$ in that order

There is $1$ non-crossing golygon with $8$ sides:

#align(center)[
  #v(5pt)
  #include "figures/p161.typ"
  #v(5pt)
]

It's area is $52$.

Find the minimum and maximum area amongst all non-crossing $24$ sides golygons.

Answer format: `min,max`

Example: `384,664` (for $16$ sides golygons)

*[My timing: 30 sec]*
]


// Problem #162
#problem-block(number: 162)[
An integer is perfect if it is equal to the sum of its proper divisors.

Let say an integer is quasi-perfect if it can be written as a sum of some distinct of its proper divisors.

For instance, $N = 150$ as the following proper divisors: \
$1,2,3,5,6,10,15,25,30,50,75$ \
and can be written as:
- $1 + 3 + 5 + 6 + 10 + 50 + 75$
- $1 + 3 + 6 + 10 + 25 + 30 + 75$
- $1 + 3 + 6 + 15 + 50 + 75$
- $2 + 3 + 5 + 10 + 25 + 30 + 75$
- $2 + 3 + 5 + 15 + 50 + 75$
- $2 + 3 + 15 + 25 + 30 + 75$
- $5 + 15 + 25 + 30 + 75$
- $10 + 15 + 50 + 75$
- $25 + 50 + 75$

Find the first such decomposition for $1000768$ (in lexicographic order).

Answer format: comma separated list of divisors in ascending order

Example: `1,3,5,6,10,50,75`

*[My timing: 50 sec]*
]


// Problem #163
#problem-block(number: 163)[
See #link(<p162>)[Quasi-perfect numbers problem] from Philippe. This time find the first decomposition in lexicographic order for $N=30380400$.

Answer format: $P mod 98961651023$ \
(where $P$ is the product of all terms in the decomposition)

Example: `3375000` (for $N=150$)

*[My timing: 24 seconds]*
]


// Problem #164
#problem-block(number: 164)[
Find the sum of all integers with at most $12$ digits and containing exactly one '$1$', two '$2$', three '$3$' and four '$4$' in their digital representation (e.g.: $23313447424$).

You are given: $121970799987802920$ (for all integers with at most $10$ digits and containing exactly one '$1$', two '$2$' and three '$3$')

*[My timing: 15 sec]*
]


// Problem #165
#problem-block(number: 165)[
For $N>0$, consider the ways to write $N$ as the sum of consecutive integers from $a$ to $b$ where $b>=a>0$. \
$N=a+(a+1)+(a+2)+...+(b-1)+b$

For example: \
$N=9=4+5=2+3+4$ \
$N=10=1+2+3+4$

Let $N$ be the product of first $42$ primes: \
$N="prod"(i=1,42,"prime"(i))$

$N=5397346292805549782720214077673687806275517530364350655459511599582614290$

How can we write $N$ in such a way that $(b-a)$ is *maximized*?

Input format: `a,b`

Example: \
`1,20` for the product of first $4$ primes: \
$N = 2 times 3 times 5 times 7 = 210 = 1+2+3+dots+20$
]


// Problem #166
#problem-block(number: 166)[
Let's define $A(n) =$ Arithmetic mean of $"GCD"(n,k)$ for $k$ in ${1, dots, n}$.

Find $A(30!)$.

You are given $A(1000) = 17\/2$.

Answer format: `P/Q`

*[My timing: 36 sec]*
]


// Problem #167
#problem-block(number: 167)[
Let's define $H(n) =$ Harmonic mean of $"GCD"(n,k)$ for $k$ in ${1, dots, n}$.

For the record, if $V = {V_1, V_2, dots, V_n}$ the harmonic mean of $V = n\/(1\/V_1 + 1\/V_2 + dots.h.c + 1\/V_n)$.

Find $H(25!)$.

You are given $H(1050) = 52500\/22403$.

Answer format: `P/Q`

*[My timing: 5 sec]*
]


// Problem #168
#problem-block(number: 168)[
It can be proved that there is a smallest integer $bold(h)$ such as for any sequence of $k$ (greater or equal to $h$) consecutive integers there is always one whose digital sum is divisible by $11$.

It is not true for less than $h$ consecutive integers.

What is $h$?

What is the first exception, i.e. the smallest $bold(e)$ such as the $(h-1)$ consecutive integers starting with $bold(e)$ have their digital sum not divisible by $11$?

Answer format: `h,e`
]


// Problem #169
#problem-block(number: 169)[
A huge crowd is celebrating the new season.

There are $N$ people (numbered from $1$ to $N$) in the crowd and they gather in a *circle* in sequence.

They decide to play a game like this: \
It starts with $1$st person. He eliminates person $2$ with a wooden sword and gives the sword to $3$. Then $3$ eliminates $4$ and sword is passed to $5$. So each person eliminates the one next to himself and passes the sword to the other next. The winner of the game is the last person standing.

Which number is the winner if $N=9*10^29$?

Hint: Deduce a formula from smaller cases.
]


// Problem #170
#problem-block(number: 170)[
Solve the modular equation
$
314159265358979323846^x = 271828182845904523536 \
"modulo" 3506457161893013907641318390893283649218125103
$

Answer format: `x`

*[My timing: 45 sec]*
]


// Problem #171
#problem-block(number: 171)[
Just get the correct value and enter as the answer!
#h(3pt)
#box(width: 10em, baseline: 25%, radius: 3pt, inset: (y: 8pt), stroke: gray)
#h(3pt)
#box(baseline: 25%, fill: luma(90%), inset: (x: 2pt, y: 4pt), stroke: gray)[Try it]

#parbreak()
#v(10pt)
#text(fill: ColorSecondary)[
  The JavaScript code for this problem is as follows:
]

```js
function f(N)
{
    var a,b,c,d,e,f,g,h,s=0,tb,tc,td,te,tf,tg,th;
    for(a=0;a<=N;a+=1){
        for(b=0;b<=N;b+=2){
            tb=a+b;if(tb>N)break;
            for(c=0;c<=N;c+=3){
                tc=tb+c;if(tc>N)break;
                for(d=0;d<=N;d+=4){
                    td=tc+d;if(td>N)break;
                    for(e=0;e<=N;e+=5){
                        te=td+e;if(te>N)break;
                        for(f=0;f<=N;f+=6){
                            tf=te+f;if(tf>N)break;
                            for(g=0;g<=N;g+=7){
                                tg=tf+g;if(tg>N)break;
                                for(h=0;h<=N;h+=8){
                                    th=tg+h;if(th>N)break;
                                    if(th==N)
                                    {
                                        s++;
                                        if((s&0x3FFFF)==0)
                                        {
                                            var ans=prompt('Taking too long... Continue?','Yes');
                                            if(ans!='Yes')return (0-document.myform.myinput.value);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return s;
}

function try_it()
{
    var N=document.myform.myinput.value;
    if (N==f(1234)){
        alert("Right! Just submit it below.");
    }else{
        alert("Wrong");
    }
}
```
]


// Problem #172
#problem-block(number: 172)[
The function F is defined by \
$F(1) = 1$ \
$F(3) = 3$ \
$F(2 dot n) = F(n)$ \
$F(4 dot n+1) = 2 F(2 dot n+1)-F(n)$ \
$F(4 dot n+3) = 3 F(2 dot n+1)-2 F(n)$

A fixed point is $n$ such as $F(n) = n$.

How many fixed points less or equal to $10^100$ have $F$?

Answer format: the count

*[My timing: < 100 ms]*
]


// Problem #173
#problem-block(number: 173)[
Consider the number of ways to paint the faces of a cube using $n$ distinct colors.

Let $d(i)$ be $i$-th decimal digit of $41152\/333333=0.123456123456 dots$ i.e. $d(1)=1, d(5)=5, d(9)=3$, etc.

Let $F(n)$ be the number of different cubes that can be obtained if it is allowed that upto $d(i)$ faces can be painted with the $i$-th color. $i=1,2,dots,n$.

What is $F(1001)$?

Example: `415` for $F(5)$.
]


// Problem #174
#problem-block(number: 174)[
```
23800-728-5852-36176-23800-3360-3312-78624-25536-5408-988-192192-?-?
```

Input format: `number1-number2`

Hint: This sequence is a tweaked form of a sequence that otherwise can be found easily (even in OEIS).

Another hint: It has been tweaked in such a way that \
OEIS: $f(0,1)-f(1,1)-f(2,1)-dots.c.h$ \
This: $f(0,0)-f(1,0)-f(2,0)-dots.c.h$

#text(fill: rgb(255, 0, 0))[Yet another hint: solve p188]
#footnote[Actually #link(<p190>)[Problem 190].]
]


// Problem #175
#problem-block(number: 175)[
We have $19 = 201$ in base $3$.

Can you find all the prime numbers $p$ such as there is a base $b$ in which $p$ can be written with all digits ${0,dots,b-1}$ used exactly once?

Digit $0$ on the left is allowed.

Answer format: `p1,p2,...` \
(in ascending order)
]


// Problem #176
#problem-block(number: 176)[
What is the GCD of all numbers $(n^37 - n)$ when $n >= 1$?

Answer format: the GCD
]


// Problem #177
#problem-block(number: 177)[
Just get the correct value and enter as the answer!
#h(3pt)
#box(width: 10em, baseline: 25%, radius: 3pt, inset: (y: 8pt), stroke: gray)
#h(3pt)
#box(baseline: 25%, fill: luma(90%), inset: (x: 2pt, y: 4pt), stroke: gray)[Try it]

#parbreak()
#v(10pt)
#text(fill: ColorSecondary)[
  The JavaScript code for this problem is as follows:
]

```js
var M=13;

function func(X,N)
{
    if(((X-1)%M)==0){
        return (func(((X-1)/M)*(M-2),N-1));
    } else if(N>0){
        return (-1);
    } else {
        return (X);
    }
}

function test()
{
    var t=document.myform.myinput.value;
    t>>=30;
    t>>=17; // answer < 2^47
    if (t == 0)
    {
        t=func(document.myform.myinput.value,M);
    }
    if(t>0)
        alert("Right! Just submit it below.");
    else
        alert("Wrong");
}
```
]


// Problem #178
#problem-block(number: 178)[
The Diophantine equation $n^2 - n dot m - m^2 = 1$, ($n, m > 0$) has infinitely many solutions.

If $n, m < 10^15$, what is the maximum of $n^2+m^2$?
]


// Problem #179
#problem-block(number: 179)[
Consider the diophantine equation $x^2+3*y^2 = z^2$ ($0 < x,y,z$ and coprime).

How many solutions are there with $z <= 10^9$?

You are given:
- $276$ solution for $z < 1000$
- $2767$ solution for $z < 10000$
- $27574$ solution for $z < 100000$

Answer format: the count

*[My timing: 120 sec]*
]


// Problem #180
#problem-block(number: 180)[
For real numbers $a, k > 0.0$, let $F(a,k)$ denotes the number of lattice points
inside the $O A B$ triangle with the following vertices: \
$O(0.0,0.0)$ \
$A(a,0.0)$ \
$B(0.0,k dot a)$

For example: \
$F(5.0,5.0)=81$ for $O(0.0,0.0), A(5.0,0.0), B(0.0,25.0)$.

What is $F(10^16+1,2\/(sqrt(5)+1))$?

*[My timing: 1 s]*
]


// Problem #181
#problem-block(number: 181)[
For real numbers $a, m > 0.0$, let $F(a,m)$ denote the number of lattice points
inside the OAB tringle with the following vertices: \
$O(0.0,0.0)$ \
$A(a,0.0)$ \
$B(x_b,y_b)$ which is the intersection point of the following lines: \
$L_1: y=x\/m$ \
$L_2: y=m dot (x-a)$

For example: \
$F(8.0,3.0)=19$ for $O(0.0,0.0), A(8.0,0.0), B(9.0,3.0)$.

What is $F(123456789101112,2\/(sqrt(5)-1))$?

*[My timing: 1 s]*

Note: You are advised to solve p178 first.
#footnote[Actually #link(<p180>)[Problem 180].]
]


// Problem #182
#problem-block(number: 182)[
Consider $6$ tubes named $A,B,C,D,E,F$ with capacities $10,10,7,7,7,7$ respectively.

In the first state they contain the following unit amounts of a certain liquid ($A$ to $F$): \
$9, 7, 6, 5, 0, 0$

And the goal state is as follows ($A$ to $F$): \
$9, 2, 2, 2, 5, 7$

Treat each state as a hex number (`FEDCBA`) and assign a $6$-digit number for them
as in the following example: \
The first state = `005679` \
The last state = `752229`

We need to reach to the goal state with the mimimum number of steps.

Let $A$ be the eventual array of size $k$ with the states (from first to last) in it: \
$A=[$`005679`$,dots,$`752229`$]$ \
where $A[i]$ is the state at the $i$-th phase, $i=1,dots,k$.

Let $N$ be the hex number obtained by concatenating the hex digits of the above array: \
$N = $ `005679...752229` or \
$N = A[1] dot B^(k-1) + A[2] dot B^(k-2)+ dots.h.c + A[k] dot B^0$ where $B=16^6$.

Find the smallest $N$. (i.e. Find the lexicographically first, shortest path.)

Answer format: $N mod 1000000007$

Example: \
Capacities: $7, 6, 5, 4, 4, 4$ \
First: $7, 5, 0, 0, 0, 0$ \
Last: $3, 2, 3, 4, 0, 0$

$1: 7, 5, 0, 0, 0, 0 quad s=$ `000057` \
$2: 3, 5, 0, 4, 0, 0 quad s=$ `004053` \
$3: 3, 5, 4, 0, 0, 0 quad s=$ `000453` \
$4: 3, 6, 3, 0, 0, 0 quad s=$ `000363` \
$5: 3, 2, 3, 4, 0, 0 quad s=$ `004323`

$N =$ `000057004053000453000363004323` (hex) \
$N mod 1000000007 = 10356901$ (decimal)

*[My timing: 25 s]*
]


// Problem #183
#problem-block(number: 183)[
Here's a javascript code in action. Experiment with it and submit the value for $M=1000000000$.

*[My timing: 42 s]*

#align(center)[
M = #h(3pt)
#box(width: 10em, baseline: 25%, radius: 3pt, inset: (x: 2pt, y: 4pt), stroke: gray)[
  #align(left)[20]
]
#h(3pt)
#box(baseline: 25%, fill: luma(90%), inset: (x: 2pt, y: 4pt), stroke: gray)[Run it]
]

#[
#set text(fill: rgb(0, 0, 255))
#show "M=20": set text(weight: "bold")
#show "found 7 solutions": set text(weight: "bold")

```
M=20

a=2 b=2 k=1 nt=1
a=4 b=4 k=2 nt=2
a=6 b=3 k=2 nt=3
a=6 b=6 k=3 nt=4
a=8 b=8 k=4 nt=5
a=12 b=4 k=3 nt=6
a=12 b=6 k=4 nt=7

found 7 solutions
```
]

#parbreak()
#v(10pt)
#text(fill: ColorSecondary)[
  The JavaScript code for this problem is as follows:
]

```js
function func()
{
    var M=myform.myinput.value;
    var nt=0;
    var outputDiv = document.getElementById("outputDiv");
    outputDiv.innerHTML = "<pre\\>";
    if (M<=0 || M>99) {
        alert("Should be >0 and <100");
    } else {
        outputDiv.innerHTML += "<font size=+2 \\><b\\>M="+M+"<\/b\\><\/font\\><br\\><br\\>";
        for (var a=1; a<M; a++){
            for (var b=1; b<=a; b++){
                var ab=a+b;
                if (ab>=M) break;
                var k=Math.floor(0.5+(a*b)/ab);
                var diff=Math.abs(a*b-k*ab);
                if (diff==0){
                    nt++;
                    outputDiv.innerHTML += "a="+a+" b="+b+" k="+k+" nt="+nt+"<br\\>";
                }
            }
        }
        outputDiv.innerHTML += "<br\\><b\\>found "+nt+" solutions<\/b\\>";
    }
    outputDiv.innerHTML += "<\/pre\\>";
}
```
]


// Problem #184
#problem-block(number: 184)[
There is one integer $N$ such as $N times 2^100$ is a $100$-digits number containing only $1$'s and $2$'s.

Can you find it.

*[My timing: < 100 ms]*
]


// Problem #185
#problem-block(number: 185)[
Find all the triples $(a,b,c)$ with $0 < a < b < c$ such as: \
$(a-1) dot (b-1) dot (c-1)$ divides $a dot b dot c - 1$.

Answer format: `(a1,b1,c1)(a2,b2,c2)...` \
($italic("a1") < italic("a2") dots$)
]


// Problem #186
#problem-block(number: 186)[
See p180 from Sinan.
#footnote[Actually #link(<p182>)[Problem 182].]
Now there are $10$ tubes named with $A,B,C,D,E,F,G,H,I,J$ with capacities $14,13,12,12,10,10,7,7,7,7$ respectively. The first state is ($A$ to $J$) $10,9,11,10,9,8,5,5,4,2$. The goal state is ($A$ to $J$) $13,12,11,11,4,6,6,0,6,4$. Encode each state as a hex number `JIHGFEDCBA`, so the starting state is `245589AB9A`, the ending state is `460664BBCD`.

We need to reach to the goal state with the mimimum number of steps.

Let A be the eventual array of size k with the states (from first to last) in it: \
$A=[$`245589AB9A`$,dots,$`460664BBCD`$]$ \
where $A[i]$ is the state at the $i$-th phase, $i=1,dots,k$.

Let N be the hex number obtained by concatenating the hex digits of the above array: \
$N=$ `245589AB9A...460664BBCD` or \
$N = A[1] dot B^(k-1) + A[2] dot B^(k-2)+ dots.h.c + A[k] dot B^0$ where $B=16^10=2^40$.

Find the smallest $N$. (i.e. Find the lexicographically first, shortest path.)

Answer format: $N mod 1000000007$

*[My timing: 60 sec] (using less than 1GB of Ram)*
]


// Problem #187
#problem-block(number: 187)[
There is an obvious generalization of p183 from Philippe.
#footnote[Actually #link(<p185>)[Problem 185].]
Find all $1 < a < b < c < d < e < f$ (integer) sextuplets for that
$(a-1) dot (b-1) dot (c-1) dot (d-1) dot (e-1) dot (f-1)$ divides $a dot b dot c dot d dot e dot f - 1$. You can easily check that this is a valid sextuplet: \
$[3, 5, 17, 257, 65555, 226112997]$.

Answer format: `cnt,s` \
where `cnt` is the number of solutions and `s` is the sum of $a+b+c+d+e+f$ values over all solutions.

*[My timing: < 1 sec]*
]


// Problem #188
#problem-block(number: 188)[
Find all $1 < a < b < c < d < e < f < g$ (integer) septuplets for that $(a-1) dot (b-1) dot (c-1) dot (d-1) dot (e-1) dot (f-1) dot (g-1)$ divides $a dot b dot c dot d dot e dot f dot g - 1$.

Answer format: `cnt,s` \
where `cnt` is the number of solutions and `s` is the sum of $a+b+c+d+e+f+g$ values over all solutions.

*[My timing: 2 min]*
]


// Problem #189
#problem-block(number: 189)[
*Proposition*:

For any partition of ${3,dots,n} = A union B$ the equation $x dot y = z$ where $x,y,z$ (not necessarily distinct) are all in $A$ or all in $B$ has always a solution.

Find the least integer n such as this proposition is true.

*[My timing: pencil and paper]*
]


// Problem #190
#problem-block(number: 190)[
Here is an hex dump of a password protected data:

```
50 4b 03 04 0a 00 01 00 00 00 ae 60 6b 45 68 81
7f 1e 18 00 00 00 0c 00 00 00 01 00 00 00 01 3e
24 52 bf a8 02 52 f9 7a 98 64 65 da e2 4e 27 a7
f4 22 2c 77 6b 7b fd
```

I believe you can easily figure out what it is and brute force the password using the following hints:
- Static string "sinan" is a part of the password (any uppercase lowercase combination is possible)
- It has a $3$-digit decimal number in it $[000-999]$
- $4$ distinct characters are also present in it from the set {'`(`', '`)`', '`:`', '`;`', '`_`', '`.`', '`,`'}
- The above mentioned parts may appear in any order (i.e. $6!$ possibilities)

Answer format: enter the decrypted data

Note: The decrypted data is an hint for the problem 172.
#footnote[Actually #link(<p174>)[Problem 174].]
So this problem is more rewarding than its points.

*[My timing: 460 s]*
]


// Problem #191
#problem-block(number: 191)[
On a $5 times 5$ chessboard, there are $8$ ways to place $3$ white queens and $5$ black queens so that no queen of a given color can attack a queen of another color.

One position is

```
+---+---+---+---+---+
| W | W |   |   |   |
+---+---+---+---+---+
|   |   |   | B | B |
+---+---+---+---+---+
|   |   |   |   | B |
+---+---+---+---+---+
| W |   |   |   |   |
+---+---+---+---+---+
|   |   | B | B |   |
+---+---+---+---+---+
```

How many ways are there to place $5$ white queens and $6$ black queens on a $6 times 6$ chessboard the same way?

Answer format: `Count/White queens positions/Black queens positions` \
for the $1$st solution in lexicographic order.

A position is given as: $(i,j)$ where $i, j$ are the row and column index starting from the upper left cell, index starting at $1$.

Example: `8/(1,1)(1,2)(4,1)/(2,4)(2,5)(3,5)(5,3)(5,4)` \
for $3$ white and $5$ black queens on a $5 times 5$ chessboard.

*[My timing: 40 sec]*
]


// Problem #192
#problem-block(number: 192)[
Consider the decimal part of PI by groups of $2$ digits.

We get the following sequence for the $20$ first elements: \
$14,15,92,65,35,89,79,32,38,46,26,43,38,32,79,50,28,84,19,71$

Subtract from each element of this sequence $50$: \
$-36,-35,42,15,-15,39,29,-18,-12,-4,-24,-7,-12,-18,29,0,-22,34,-31,21$

You can verify that the sub-sequence starting at index $3$ and ending at index $7$ $(42,15,-15,39,29)$ has the largest sum: $110$.

Now group the decimal part of PI by groups of 10 digits and subtract 10^10/2 from each element.

We get the sequence: \
$S = -3584073465,3979323846,-2356616721,28841971,1939937510,$ $820974944,923078164,-4371379101,3628034825,-1578829321, dots$

What is the sub-sequence with the largest sum in the first $5000000$ elements of $S$?

Answer format: `Sum,Starting index,Ending index`

Example: `110,3,7`

*[My timing: 2 sec] (Computation of PI not included!)*
]


// Problem #193
#problem-block(number: 193)[
Let $F(n)=11+105^n$.

Let $S$ be the serie of $F(n)$ values for $n=1,2,dots$: \
$116, 11036, 1157636, 121550636, 12762815636, 1340095640636, dots$


What is the $10^4$-th term *that can be divided by 27126986671934931497 with no remainder*.

Answer format: the term mod $10^9$

*[My timing: 3 s]*
]


// Problem #194
#problem-block(number: 194)[
On a circular track, three trains travel at the same speed: one unit per second.

The track has a length of $641$ units.

- Train no. $1$ has a length of $11$ units and occupies the position $0$ to $10$. It travels clockwise
- Train no. $2$ has a length of $13$ units and occupies the position $100$ to $112$. It travels counter-clockwise
- Train no. $3$ has a length of $17$ units and occupies the position $200$ to $216$. It travels clockwise

When two trains collide, they collide elastically, and go in the opposite direction at the same speed.

The trains start to move at $T=0$.

At which $T$ do the trains occupy the same position again?

*[My timing: 5 sec]*

Here is an example:
#footnote[Selected key frames from the original GIF.]

#grid(
  columns: (1fr,)*8,
  column-gutter: 2pt,
  row-gutter: 10pt,
  image("figures/p194/1.png"),  image("figures/p194/5.png"),
  image("figures/p194/9.png"),  image("figures/p194/13.png"),
  image("figures/p194/17.png"),  image("figures/p194/21.png"),
  image("figures/p194/25.png"),  image("figures/p194/29.png"),
  image("figures/p194/33.png"),  image("figures/p194/37.png"),
  image("figures/p194/41.png"),  image("figures/p194/45.png"),
  image("figures/p194/49.png"),  image("figures/p194/53.png"),
  image("figures/p194/57.png"),  image("figures/p194/61.png"),
  image("figures/p194/65.png"),  image("figures/p194/69.png"),
  image("figures/p194/73.png"),  image("figures/p194/77.png"),
  image("figures/p194/81.png"),  image("figures/p194/85.png"),
  image("figures/p194/89.png"),  image("figures/p194/93.png"),
  image("figures/p194/97.png"),  image("figures/p194/101.png"),
  image("figures/p194/105.png"),  image("figures/p194/109.png"),
  image("figures/p194/113.png"),  image("figures/p194/117.png"),
  image("figures/p194/121.png"),  image("figures/p194/125.png"),
  image("figures/p194/129.png"),  image("figures/p194/133.png"),
  image("figures/p194/137.png"),  image("figures/p194/141.png"),
  image("figures/p194/145.png"),  image("figures/p194/149.png"),
  image("figures/p194/153.png"),  image("figures/p194/157.png"),
  image("figures/p194/161.png"),  image("figures/p194/165.png"),
  image("figures/p194/169.png"),  image("figures/p194/173.png"),
  image("figures/p194/177.png"),  image("figures/p194/181.png"),
  image("figures/p194/185.png"),  image("figures/p194/189.png"),
  image("figures/p194/193.png"),  image("figures/p194/197.png"),
  image("figures/p194/201.png"),  image("figures/p194/205.png"),
  image("figures/p194/209.png"),  image("figures/p194/213.png"),
  image("figures/p194/217.png"),  image("figures/p194/221.png"),
  image("figures/p194/225.png"),  image("figures/p194/229.png"),
  image("figures/p194/233.png"),  image("figures/p194/237.png"),
  image("figures/p194/241.png"),  image("figures/p194/245.png"),
  image("figures/p194/249.png"),  image("figures/p194/253.png"),
  image("figures/p194/257.png"),  image("figures/p194/261.png"),
  image("figures/p194/265.png"),  image("figures/p194/269.png"),
  image("figures/p194/273.png"),  image("figures/p194/277.png"),
  image("figures/p194/281.png"),  image("figures/p194/285.png"),
  image("figures/p194/289.png"),  image("figures/p194/293.png"),
  image("figures/p194/297.png"),  image("figures/p194/301.png"),
  image("figures/p194/305.png"),  image("figures/p194/309.png"),
  image("figures/p194/313.png"),  image("figures/p194/317.png")
)

(Image credit: apgoucher. I will remove it if there is a copyright issue)
]


// Problem #195
#problem-block(number: 195)[
A number is antipodean if it is equal to is rotation by $180 degree$: you type such a number on a calculator and turn it upside down, you read the same value.
- $1961$ is such a number

How many antipodean numbers with a number of digits less or equal to $17$ are there and what is there sum?

Answer format: `Count,Sum`

You are given: `14404,5947658589706` for $9$ digits or less.

*[My timing: 50 sec]*
]


// Problem #196
#problem-block(number: 196)[
There are $2$ points ($A$ and $B$) $100$ kms apart. A vehicle ($italic("VA")$) starts to travel from point $A$ to point $B$ and another ($italic("VB")$) from $B$ to $A$ at the same time (00:00:00).

$italic("VA")$ travels at a speed (km/h) equal to the distance-to-$B$ $+ 13$ at any time while $italic("VB")$ travels at the speed of $61$ km/h at any time.

So for example when $italic("VA")$ is $91.1$ kms away from $B$, its speed would be $104.1$ km/h at that time.

At what time do the two vehicles meet?

Answer format: `HH:MM:SS:ms` \
(rounded to milliseconds)

Example: `01:11:17:691`
]


// Problem #197
#problem-block(number: 197)[
The application $T$ operates on a sequence $S$ as: \
$T(S) = {1, S[1], 2, S[2], ..., S[n], n+1}$

For instance: \
$T({10, 20, 30}) = {1, 10, 2, 20, 3, 30, 4}$

Consider the infinite sequence $S = T(T(T(T(T(dots({1})dots)))))$. $T$ is applied infinitly.

What is $S[12345678910111213]$?

*[My timing: < 100 ms]*
]


// Problem #198
#problem-block(number: 198)[
Consider an $N times N$ grid ($N<16$) where hex digits $1$ to $N$ are used only once in each row or column and treat the whole grid as a number starting from first row to the last.

What is the smallest number for $N=13$?

Answer format: last $2$ rows as uppercase hex

Example for $N=5$:

```
1, 2, 3, 4, 5
2, 1, 4, 5, 3
3, 4, 5, 1, 2
4, 5, 2, 3, 1
5, 3, 1, 2, 4
```

Number = `1234521453345124523153124`

Answer = `4523153124`
]


// Problem #199
#problem-block(number: 199)[
```
1,17,283,48405761,21491955953121731720119,?
```

Hint: solve p196 first.
#footnote[Actually #link(<p198>)[Problem 198].]
]


// Problem #200
#problem-block(number: 200)[
A derangement is a well known kind of permutation with no fixed point.

Define a $2$-derangement as a pair $P_1, P_2$ of derangements where: $P_1[i] != P_2[i]$ for all $i$.

Here are $2$ examples of $2$-derangements for $5$ elements:

```
2 4 5 3 1
4 5 1 2 3

4 5 1 2 3
2 4 5 3 1
```

How many $2$-derangements are there for $208$ elements?

As the answer is a BIG number, use the following condensed representation: \
`First 10 digits[number of remaining digits]Last 10 digits`

For instance, for $2^127$, the representation is: \
`1701411834[19]5884105728`

*[My timing: 40 sec]*
]


// Problem #201
#problem-block(number: 201)[
How many numbers below $10^15$ can be divided by sum of their digits?

For example, $54$ is such a number, the sum of its digits is $5+4=9$, $9$ can divide $54$.

Answer format: number

Example: `32` if below $10^2$ or `11871` if below $10^5$.

*[My timing: 6 s]*
]


// Problem #202
#problem-block(number: 202)[
Here's a javascript code in action. Experiment with it and submit the value for $M=100$ and $N=200$.

Use the following condensed representation: \
`First 10 digits[number of remaining digits]Last 10 digits`

For instance, for $2^127$, the representation is: \
`1701411834[19]5884105728`

#align(center)[
M = #h(3pt)
#box(width: 8em, baseline: 25%, radius: 3pt, inset: (x: 2pt, y: 4pt), stroke: gray)[
  #align(left)[5]
]
#h(3pt)
N = #h(3pt)
#box(width: 8em, baseline: 25%, radius: 3pt, inset: (x: 2pt, y: 4pt), stroke: gray)[
  #align(left)[5]
]
#h(3pt)
#box(baseline: 25%, fill: luma(90%), inset: (x: 2pt, y: 4pt), stroke: gray)[Run it]
]

#[
#set text(fill: rgb(0, 0, 255))
#show "M=5, N=5": set text(weight: "bold")

```
M=5, N=5

COUNT=771
```
]

#parbreak()
#v(10pt)
#text(fill: ColorSecondary)[
  The JavaScript code for this problem is as follows:
]

```js
/*
See the following pseudo code:

   define global variables ROWS, COLS and COUNT
   define GRID as a ROWS by COLS matrix and initialize it to zero

recursive_function(row=1, col=1, row_max=1)
begin
   set GRID[row, col] to 1
   if col+1 is less than or equal to COLS
   begin // if
      if GRID[row, col+1] is equal to zero; call recursive_function(row, col+1, row_max)
   end // if
   else if row_max is equal to ROWS; add 1 to COUNT

   if row+1 is less than or equal to ROWS and GRID[row+1, col] is equal to zero;
      then call recursive_function(row+1, col, row_max+1)

   if row-1 is greater than zero and GRID[row-1, col] is equal to zero;
      then call recursive_function(row-1, col, row_max)
   set GRID[row, col] to 0
end

main(M,N)
begin
   ROWS=M
   COLS=N
   COUNT=0
   call recursive_function(row=1, col=1, row_max=1)
   return COUNT
end
*/


var ROWS;
var COLS;
var GRID = new Array();
var COUNT;

function recursive_function(row,col,row_max)
{
    GRID[row-1][col-1]=1;
    if(col+1<=COLS){
        if(GRID[row-1][col+1-1]==0) recursive_function(row,col+1,row_max);
    } else if (row_max==ROWS) COUNT++;
    if (row+1<=ROWS && GRID[row+1-1][col-1]==0) recursive_function(row+1,col,row_max+1);
    if (row>1 && GRID[row-1-1][col-1]==0) recursive_function(row-1,col,row_max);
    GRID[row-1][col-1]=0
}

function main()
{
    var M=myform.myM.value;
    var N=myform.myN.value;
    if (M<=0 || M>=10 || N<=0 || N>=10) {
        alert("Should be >0 and <10");
    } else {
        ROWS=M;
        COLS=N;
        COUNT=0;
        for (i=0;i<ROWS;i++){
            GRID[i]=new Array();
            for (j=0;j<COLS;j++){
                GRID[i][j]=0;
            }
        }
        recursive_function(1,1,1);
        outputDiv.innerHTML = "<pre><font size=+2 \\><b\\>M="+M+", N="+N+"</b\\></font\\>";
        outputDiv.innerHTML += "<b\\>COUNT="+COUNT+"</b\\></pre>";
    }
}
```
]


// Problem #203
#problem-block(number: 203)[
Starting with a sequence of signs `+` and `-`, we form a "pascal-like" triangle applying the following rules:
- the $1$st row is the initial sequence
- each next row is built by combining each $2$ consecutive signs from the previous row, with the classical rules (`+` $times.circle$ `+` $=>$ `+`, `+` $times.circle$ `-` $=>$ `-`, etc.)

For instance, starting with '`-+--`', we obtain the following triangle:

```
- + - -
 - - +
  + -
   -
```

Such a triangle is said balanced if it contains the same number of `+` and `-`.
The following triangle is balanced:

```
- + - +
 - - -
  + +
   +
```

Find the number of sequences with $23$ signs containing the largest number of `+` which produce a balanced triangle and give the last one (lexicographic order).

Answer format : `count,sequence of + and - without spaces`

PS: `count` is the number of sequences with that largest number of `+`.

For $7$ signs, the anwser would be: `5,+++-++-`

*[My timing: 100 sec]*
]


// Problem #204
#problem-block(number: 204)[
Let $f(n)$ be the sum of the squares of the digits of $n$. Iterate this process, if we can reach $1$ in this sequence then we say $n$ is a happy number. $H(n)$ denotes the number of (positive) happy numbers up to $n$. For example $n=736$ is a happy number as the iterated sequence is $736,94,97,130,10,1$.

Find $H(12345678)$.

Example: $H(1000)=143$.
]


// Problem #205
#problem-block(number: 205)[
Find $H(2^300)$ so the number of happy numbers up to $2^300$.
]


// Problem #206
#problem-block(number: 206)[
See p201 from Philippe.
#footnote[Actually #link(<p203>)[Problem 203].]
Find the answer for $47$ signs!

Answer format: `count,sequence of + and - without spaces` \
where `count` is the number of sequences with that largest number of `+`.

*[My timing: 2 min]*
]


// Problem #207
#problem-block(number: 207)[
Laver tables, discovered by Richard Laver, are very intriguing mathematical objects.

Although their definition is elementary, some of their properties cannot be proved in the classical set theory (ZFC), but require (so far) some hypotheses about large cardinals.

Let's define the operation $star$ for integers in range $[1 dots n]$ ($n$ is a power of $2$) by the following axioms: \
$x star 1 = (1 + x) mod n$ \
$x star (y star z) = (x star y) star (x star z)$

Here is the Laver table for $n = 8$:

```
    1   2   3   4   5   6   7   8
  + - + - + - + - + - + - + - + - +
1 | 2 | 4 | 6 | 8 | 2 | 4 | 6 | 8 |
  + - + - + - + - + - + - + - + - +
2 | 3 | 4 | 7 | 8 | 3 | 4 | 7 | 8 |
  + - + - + - + - + - + - + - + - +
3 | 4 | 8 | 4 | 8 | 4 | 8 | 4 | 8 |
  + - + - + - + - + - + - + - + - +
4 | 5 | 6 | 7 | 8 | 5 | 6 | 7 | 8 |
  + - + - + - + - + - + - + - + - +
5 | 6 | 8 | 6 | 8 | 6 | 8 | 6 | 8 |
  + - + - + - + - + - + - + - + - +
6 | 7 | 8 | 7 | 8 | 7 | 8 | 7 | 8 |
  + - + - + - + - + - + - + - + - +
7 | 8 | 8 | 8 | 8 | 8 | 8 | 8 | 8 |
  + - + - + - + - + - + - + - + - +
8 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |
  + - + - + - + - + - + - + - + - +
```

You'll notice that, except for the last one, all rows are periodic.

Find the periodic part of the $1$st row for $n = 2^16$.

Answer format: comma delimited list of values

Example: for $n = 8$, the anwser would be: `2,4,6,8`.

N.B.: It can be proved that the periodicity of the $1$st row is unbounded. But the first $n$ for which the period is greater that the one you'll find for $2^16$ is greater than $A(9,A(8,A(8,255)))$. $A$ is the Ackerman function ...

*[My timing: < 1 s]*
]


// Problem #208
#problem-block(number: 208)[
See problem 205.
#footnote[Actually #link(<p207>)[Problem 207].]

Find the periodic part of the $1$st row for $n = 2^23$.

Answer format: to keep the answer short, give the first difference of the vector of values divided by $2$

For instance, for $2^10$, the first row is: \
$2,12,14,240,242,252,254,768,770,780,782,1008,1010,1020,1022,1024$

So the answer would be: \
`5,1,113,1,5,1,257,1,5,1,113,1,5,1,1`

*[My timing: 32 sec]*
]


// Problem #209
#problem-block(number: 209)[
Let $"Fib"(N)$ be $N$-th Fibonacci number with $"Fib"(1)=1$ and $"Fib"(2)=1$.

What is $"Fib"("Fib"(1000000)) mod 1000000007$?

*[My timing: 2 s]*
]


// Problem #210
#problem-block(number: 210)[
Solve in real variables: \
$(sin x)^2+(cos y)^2=y^2$ \
$(sin y)^2+(cos x)^2=x^2$

Submit all solution in lexicographic increasing way.

Answer format: `(x1,y1),(x2,y2),...` \
Here lex. sorting means that $(a,b)<(c,d)$ if $a < c$ or {$a=c$ and $b < d$}. You can assume that all solution is in fact rational, so submit them as $x=p\/q$, where $q>0$, $gcd(p,q)=1$ (and not use $q$ if $x$ is integer).

Example: `(-1/2,0),(3/4,7)`
]


// Problem #211
#problem-block(number: 211)[
Consider the function $F(X) = 1 \/ ( 2 dot [X] - X + 1 )$ where $[X]$ is the integer part of $X$.

It is quite remarkable that the sequence ${0, F(0), F(F(0)), F(F(F(0))), dots}$ contains every non-negative rational exactly once. ${0, F(0), F(F(0)), F(F(F(0))), dots} = bb(Q)_+$.

We note $F(0)^n = F(F(dots(F(0))dots))$, function $F$ is applied $n$ times.

What is $F(0)^1413121110987654321$ \
Find $n$ such as $F(0)^n = 1415926535\/5772156649$

Answer format: `N/D,Index`

*[My timing: < 100 ms]*
]


// Problem #212
#problem-block(number: 212)[
Consider a Phytagorean right-angled triangle with lengths $a$, $b$, and $c$ ($a < b < c$).

Its Perimeter: $P=a+b+c$. Its Area: $A=a dot b\/2$.

Find the $(a,b,c)$ triple with maximum $A\/P$ ratio if $P<=10^17$.

Answer format: `a,b,c`

Example: `280,294,406` if $P<=10^3$ \
$A=41160, P=980, A\/P=42$

*[My timing: 40 s]*
]


// Problem #213
#problem-block(number: 213)[
Let $S$ be the set of numbers up to $40$. $S={1,2,dots,40}$.

Note the following subsets: \
$S 1$ is the prime numbers in $S$. \
$S 2$ is the semiprime numbers in $S$. \
$S 3$ is the all other numbers of $S$. \

Now consider $4$ subsets all with $4$ distinct numbers. \
$A$ is a subset of $S 1$. \
$B$ is a subset of $S 2$. \
$C$ is a subset of $S 3$. \
$D$ is also a subset of $S 3$ but $C$ and $D$ are disjoint.

Find the number of $A$, $B$, $C$ and $D$ subsets such that
- they all sum to the same number
- the smallest element of $A < "that of" B < "that of" C < "that of" D$

Example: \
$A={5, 19, 23, 37}$ \
$B={6, 14, 26, 38}$ \
$C={8, 12, 28, 36}$ \
$D={16, 18, 20, 30}$ \
$5+19+23+37=6+14+26+38=8+12+28+36=16+18+20+30=84$ \
$5 < 6 < 8 < 16$ \
This counts as one solution.

*[My timing: 21 s]*
]


// Problem #214
#problem-block(number: 214)[
See p211 from Sinan,
#footnote[Actually #link(<p213>)[Problem 213].]
same problem, but for the first $256$ positive integers, so for $S={1,2,dots,256}$.

*[My timing: 3 seconds]* \
(without any trick using roughly 210 MB of Ram, the answer fits in 64 bits.)
]


// Problem #215
#problem-block(number: 215)[
Let $c(n)=n!\/n\#$ be the $n$-th compositorial number, where $n\#$ is the product of primes up to $n$. For example $c(7)=1 times 2 times 3 times 4 times 5 times 6 times 7\/(2 times 3 times 5 times 7)=24$.

$S(p)={n: c(n)+1 "is divisible by" p}$.

$H(p)=|S(p)|$, so the size of $S(p)$.

Example: $H(5)=4$ as $S(5)={4,5,6,7}$.

Find several values of $H(p)$ (where $p$ is prime).

Answer format: `H(6031001),H(6873371),H(9103859),H(6133003),H(7834447)`
]


// Problem #216
#problem-block(number: 216)[
```
3 4 6 8 12 ?
```
]


// Problem #218
#problem-block(number: 218)[
$S$ is a set of $11$ prime numbers such that
- the average is also a prime number
- the biggest element < $75$

How many such $S$ are there and what is the last $S$?

Answer format: `cnt;p1,p2,..,p11` \
($italic("p1") < italic("p2") < dots.h.c < italic("p11")$)
]


// Problem #219
#problem-block(number: 219)[
At school, little boys are mischievous: they pull girls' hair, they kick. Girls don't like boys and prefer to be with girls.

In a classromm a teacher decides to place children in row in such a way that each girl gives the hand to at least one other girl. \
`B G G B` - good \
`B G B G` - not good

How many possibilities are there in a classroom with $40$ children.
]


// Problem #220
#problem-block(number: 220)[
Let $N = 345 + 456 = F 1 dot F 2$ ($F 1 < F 2$).

Find $F 1$ and $F 2$ proper divisors of $N$ that minimise $(F 2 - F 1) \/ N$.

Answer format: `F1,F2` \
where `F1` and `F2` is entered using the following condensed representation: \
`Leading 10 digits[number of digits not shown]trailing 10 digits`

For example, $2^127$ in this representation would be shown as \
`1701411834[19]5884105728`
]


// Problem #221
#problem-block(number: 221)[
There are some coins worth $1,2,5,11,23,47,101,211$ and bills worth $503,1009,2003,5003,10007$.

In how many ways can you pay $12345$, if you are allowed to use *upto 47 coins*?

*[My timing: 15 s]*
]


// Problem #222
#problem-block(number: 222)[
In a city, all the buildings are located in the same district.

This district is a rectangle of size $W$ by $H$, its sides are labelled South, East, North and West.
- Each building occupies a $1$-unit square, there are W*H buildings.
- There height are all integers from $1$ to $W times H$.
- When we look at the buildings facing South face or East face, we can see each building, partly or totally. No building is hidden behind a higher one.

For a $2 times 3$ rectangle, there are five possible arrangements for the buildings.

#align(center)[
  #v(5pt)
  #image("figures/p222.png")
  #v(5pt)
]

How many possible arrangements are there for a $15 times 20$ rectangle?

Answer format: the count in compressed format as in problem 198
#footnote[Actually #link(<p200>)[Problem 200].]

*[My timing: < 100 ms]*
]


// Problem #223
#problem-block(number: 223)[
Fusible numbers are an extraordinary set of rational numbers. You can learn more #link("http://www.mathpuzzle.com/fusible.pdf")[here].

There are defined by the following rules:
- We define the operation $~$ between $2$ reals as $a ~ b = (a + b + 1)\/2$
- $0$ is a fusible number
- $c$ is a fusible number is there exist fusible numbers $a$ and $b$ such as $c = a ~ b$ AND $|a - b| < 1$

Here are some examples: \
$1\/2 = 0~0$ \
$1 = (0~0)~(0~0)$ \
$5\/4 = (0~0)~((0~0)~(0~0))$

It is easy to see that all fusible numbers other than $0$ can be written $p\/2^q$ for some integers $p$ and $q$ where $p$ is odd.

Find all fusible numbers in the interval $]1\/2, 5\/4[$ (bounds excluded) with a denominator $<= 128$.

Answer format: comma separated list in ascending order \
(We represent a fusible number $p\/2^q$ as $p.q$, e.g.: $3\/4 = 3.2$)

Example: `15.4,63.6,1.0,5.1`

*[My timing: < 1 sec]*
]


// Problem #224
#problem-block(number: 224)[
We define a canonical representation of a fusible number as a representation with only $0$.

For instance, the shortest canonical representations of $21\/16$ are:
- $(((0~0)~0)~(0~0))~(0~0)$
- $(((0~0)~0)~0)~((0~0)~0)$
- $(((0~0)~0)~0)~(0~(0~0))$
- $((0~(0~0))~(0~0))~(0~0)$
- $((0~(0~0))~0)~((0~0)~0)$
- $((0~(0~0))~0)~(0~(0~0))$
- $((0~0)~((0~0)~0))~(0~0)$
- $((0~0)~(0~(0~0)))~(0~0)$
- $((0~0)~0)~(((0~0)~0)~0)$
- $((0~0)~0)~((0~(0~0))~0)$
- $((0~0)~0)~(0~((0~0)~0))$
- $((0~0)~0)~(0~(0~(0~0)))$
- $(0~((0~0)~0))~((0~0)~0)$
- $(0~((0~0)~0))~(0~(0~0))$
- $(0~(0~(0~0)))~((0~0)~0)$
- $(0~(0~(0~0)))~(0~(0~0))$
- $(0~(0~0))~(((0~0)~0)~0)$
- $(0~(0~0))~((0~(0~0))~0)$
- $(0~(0~0))~(0~((0~0)~0))$
- $(0~(0~0))~(0~(0~(0~0)))$
- $(0~0)~(((0~0)~0)~(0~0))$
- $(0~0)~((0~(0~0))~(0~0))$
- $(0~0)~((0~0)~((0~0)~0))$
- $(0~0)~((0~0)~(0~(0~0)))$
and the last in alphabetic order is $(0~(0~(0~0)))~(0~(0~0))$.

What is the last (in alphabetic order) shortest canonical representation of $111\/64$?

Hint: The number of $0$s in a representation is $13$.

*[My timing: 4 sec]*
]


// Problem #225
#problem-block(number: 225)[
A fusible number can be written in several ways as $a ~ b$ for some fusible numbers $a$ and $b$ ($a <= b$)

For instance $101\/64 = (3\/4~45\/32)(15\/16~39\/32)(31\/32~19\/16)$.

Find all such representations for 111/64

Answer format: comma separated list of $a~b$ where $a <= b$ and first terms in ascending order \
if $(a i~b i)$ and $(a j~b j)$ are $2$ representations with $i < j$, then $a i < a j$.

A fusible $a = p\/2^q$ is represented as $p.q$ (see problem 220).
#footnote[Actually #link(<p223>)[Problem 223].]

Example: `3.2~45.5,15.4~39.5,31.5~19.4` \
for $101\/64$.

*[My timing: 1 sec]*
]


// Problem #226
#problem-block(number: 226)[
A number is _$p$-automorphic_ if the last digits of its $p$-th power are the number itself.

For instance $68751$ is a $3$-automorphic number: \
`68751^3 = 3249653517`*`68751`*

There are $10$ $10$-digits $6$-automorphic numbers:
- `1787109376^6 = 3257667836465082837499488689492083159409379960`*`1787109376`*
- `2000000001^6 = 6400000019200000024000000016000000006000000001`*`2000000001`*
- `3787109376^6 = 295017031865099125803257534191857287033553911211`*`3787109376`*
- `4000000001^6 = 409600000614400000384000000128000000024000000002`*`4000000001`*
- `5787109376^6 = 3756385396334567059900303436931667803419698442462`*`5787109376`*
- `6000000001^6 = 4665600004665600001944000000432000000054000000003`*`6000000001`*
- `7787109376^6 = 22297575773437133290804199697004923632317842973713`*`7787109376`*
- `8000000001^6 = 26214400019660800006144000001024000000096000000004`*`8000000001`*
- `8212890625^6 = 30688540528708584207567833246343980135861784219741`*`8212890625`*
- `9787109376^6 = 87887406894922437224766508814507624773727987504964`*`9787109376`*

How many $50$-digits $73$-automorphic numbers are there?

Answer format: `count,sum`

Example: `10,57148437509` \
for $10$-digits $6$-automorphic numbers.

*[My timing: 3 sec]*
]


// Problem #227
#problem-block(number: 227)[
Define the following sequence: $a(0)=(sin(2 pi\/n))^2$ and for $k>0$, $a(k)=4 dot a(k-1) dot (1-a(k-1))$. For odd $n$ value this sequence is periodical!

Find the period for $n=314159265358979323846264338327950288419716939937510582097$.
]


// Problem #228
#problem-block(number: 228)[
There are (probably infinitely) many triples of prime numbers $P_1 < P_2 < P_3$ such as $P_i+P_j dot P_k$ is a square number for all combinations $(i,j,k)$ with $i!=j!=k$.

Here is an example: $4049,126001,130051$.

Find the triple with the largest $P_3 < 180000$.

Answer format: comma separated list

Example: `4049,126001,130051`

*[My timing: 95 sec]*
]


// Problem #229
#problem-block(number: 229)[
A ant walks exploring each lattice point in the first quadrant of the plane with the following pattern:

#set table(
  fill: (x, y) => if calc.even(x) and calc.even(y) {silver}
)

#table(
  columns: (16pt,)*13,
  rows: 16pt,
  align: center+horizon,
  stroke: 0.5pt + silver,
  [37], [$->$], [38], [$->$], [39], [$->$], [40], [$->$], [41], [$->$], [42], [$->$], [43],
  [$arrow.t$], [], [], [], [], [], [], [], [], [], [], [], [$arrow.b$],
  [36], [$<-$], [35], [$<-$], [34], [$<-$], [33], [$<-$], [32], [$<-$], [31], [], [44],
  [], [], [], [], [], [], [], [], [], [], [$arrow.t$], [], [$arrow.b$],
  [17], [$->$], [18], [$->$], [19], [$->$], [20], [$->$], [21], [], [30], [], [45],
  [$arrow.t$], [], [], [], [], [], [], [], [$arrow.b$], [], [$arrow.t$], [], [$arrow.b$],
  [16], [$<-$], [15], [$<-$], [14], [$<-$], [13], [], [22], [], [29], [], [46],
  [], [], [], [], [], [], [$arrow.t$], [], [$arrow.b$], [], [$arrow.t$], [], [$arrow.b$],
  [5], [$->$], [6], [$->$], [7], [], [12], [], [23], [], [28], [], [47],
  [$arrow.t$], [], [], [], [$arrow.b$], [], [$arrow.t$], [], [$arrow.b$], [], [$arrow.t$], [], [$arrow.b$],
  [4], [$<-$], [3], [], [8], [], [11], [], [24], [], [27], [], [48],
  [], [], [$arrow.t$], [], [$arrow.b$], [], [$arrow.t$], [], [$arrow.b$], [], [$arrow.t$], [], [$arrow.b$],
  [1], [$->$], [2], [], [9], [$->$], [10], [], [25], [$->$], [26], [], [49],
)

The $1$st point visited (index = $1$) is $(0,0)$ \
The $10$th point is $(3,0)$ \
The $100000$th point is $(143,316)$

What is the $10^17$-th point? \
What is the index of the point $(718281828,141592653)$?

Answer format: `x,y/index`

Example: `143,316/51594074` \
for $10^5$ and $(7182,1415)$.

*[My timing: < 100 ms]*
]


// Problem #230
#problem-block(number: 230)[
The word *anticonstitutionnellement*, meaning unconstitutionally is the longest word in French.

How many subsequences can you find for this word?

For example, the word 'nine' has 14 subsequences: (empty string included) \
'', 'e', 'i', 'n', 'ie', 'in', 'ne', 'ni', 'nn', 'ine', 'nie', 'nin', 'nne', 'nine'

*[My timing: 90 sec]*
]


// Problem #231
#problem-block(number: 231)[
Given two sequences $X[1] dots.h.c X[n]$ and $Y[1] dots.h.c Y[m]$ ($n <= m$), we say that the former is a subsequence of the latter if there if a sequence $1 <= i[1] < i[2] < dots.h.c < i[n] <= m$ such as $X[j] = Y[i[j]]$ for all $1 <= j <= n$.

E.g: 'PAIN' is a subsequence of 'DIOPHANTINE'.

We say a sequence $S[1] dots.h.c S[n]$ is a F-sequence if no sequence $S[i] dots.h.c S[2 dot i]$ ($2 dot i <= n$) is a subsequence of any sequence $S[j] dots.h.c S[2 dot j]$ ($i < j$ and $2 dot j <= n$).

What is the length of longest F-sequence over the alphabet {`A`, `B`}? \
Find the $1$st F-sequence in lexicographic order over the alphabet {`A`, `B`, `C`} with length $80$.

Hint: Here an example of a F-sequence of length $40$: \
`AACBABBBBBABBCCCCCCCCCBBBBBBBBBBBBBBBBBA`

Answer format: `count,sequence`

*[My timing: < 100 ms]*
]


// Problem #232
#problem-block(number: 232)[
How many squarefree numbers are congruent in the range $[10^7, 10^7+1000]$?

Hint: Assume the BSD conjecture.

Answer format: `count,sum modulo 10^7`

*[My timing: 45 sec]*
]


// Problem #233
#problem-block(number: 233)[
Let define a sequence $S$ as follow:
- $S[1] = 1$
- $S[n+1] =$ the first integer not in $S[1 dots n]$ such as the average of $S[1 dots n+1]$ is an integer.

Find $S[2357111317192329]$.

*[My timing: < 100 ms]*
]


// Problem #234
#problem-block(number: 234)[
There are $2$ particles moving on the unit circle ($x^2+y^2=R^2$ and $R=1$).

Particle $A$ moves clockwise at a speed equal to $2+x$ while particle $B$ moves counter-clockwise at a speed equal to $2+x$, where $x$ and $y$ are the coordinate values of the moving particle.

At $T=0$ time, $A$ is located at $(-1,0)$ and $B$ at $(0,-1)$, so the speeds would be $1$ and $2$ for $A$ and $B$ respectively.

Where do they first meet and when?

Answer format: `X,Y,elapsed time` \
$X,Y$ rounded to $3$ digits after decimal point. elapsed time is a decimal number (rounded to 12 digits after decimal point).
]


// Problem #235
#problem-block(number: 235)[
Let $C(N)$ be the number of positive integer $n <= N$ such that
$
n / phi.alt(n) = phi.alt(n) / phi.alt(phi.alt(n)),
$
where $phi.alt(n)$ is the totient function.

You are given that $C(10^5)=342$.

Find $C(10^15)$.

*[My timing: 10.9 sec]*
]


// Problem #236
#problem-block(number: 236)[
Find the sum of $n$ such that $sigma(n)=13!$, where $sigma(n)$ is the sum of divisors function.

Example: $104530$ for $7!$.

*[My timing: 4.6 s]*
]


// Problem #237
#problem-block(number: 237)[
Consider the sequence of fractions: \
$F={23/95,57/23,17/39,130/17,11/14,35/11,19/13,1/19,35/2,13/7,7/1}$

We define the following algorithm (n is an integer):

```c
func(n) {
  i = 0;
  Start:
    j = 0;
    while (F[j]*n not integer) {
      j++;
    }
    i++;
    n = n*F[j]
    if (n has only factors 2 and 3) {
      print(i);
    }
    goto Start;
}
```

The first values `func(6)` yield are: \
- $10, 24, 46, dots$

Find the $100$th value.

You are given the $20$-th element: $185500$.

*[My timing: < 100 ms]*
]


// Problem #238
#problem-block(number: 238)[
$phi.alt = (1 + sqrt(5))/2$ is the golden ratio.

Any positive integer can be represented as a sum of powers of $phi.alt$ with integer exponents:
- $1=phi.alt^0$
- $2=phi.alt^1+phi.alt^(-2)$
- $3=phi.alt^2+phi.alt^(-2)$
- $4=phi.alt^2+phi.alt^0+phi.alt^(-2)$
- $5=phi.alt^3+phi.alt^-1+phi.alt^(-4)$
- $6=phi.alt^3+phi.alt^1+phi.alt^(-4)$
- $7=phi.alt^4+phi.alt^(-4)$
- $8=phi.alt^4+phi.alt^0+phi.alt^(-4)$
- $9=phi.alt^4+phi.alt^1+phi.alt^(-2)+phi.alt^(-4)$
- $10=phi.alt^4+phi.alt^2+phi.alt^(-2)+phi.alt^(-4)$

If we add the constraint that no exponent are consecutive, this representation is unique. This representation is called the phinary representation of an integer.

For an integer $n$, we define $M(n)$ as the sum of all exponents in its phinary representation:
$
M(641) = sum 641_("base-"phi) = sum {13,9,7,5,2,0,-3,-11,-14} = 8
$

In the range $[1,10000000]$, find the minimun for $M$, the first integer which reaches the minimum, the maximum, and the first integer which reaches the maximum.

Answer format: $M_min,n_min,M_max,n_max$ \
$-17,77,8,46$ for the range $[1,100]$.


*[My timing: 10 sec]*

P.S: Thanks to *sinan* for his suggestions which made this problem more interesting.
]


// Problem #239
#problem-block(number: 239)[
The period of a prime $p$ is the period of the fraction $1\/p$.

For example,
$
"Period"(79) = 13 quad (1/79 = 0.underbrace(0126582278481,13) dots.h.c)
$

Find the smallest prime with a period of $798$.
]


// Problem #240
#problem-block(number: 240)[
We have:
$
2^10000000002+1 &= f_1 dot f_2 \
&= underbrace(41776 dots.h.c dots.h.c 01, 1505149979 "digits") dot underbrace(41776 dots.h.c dots.h.c 05, 1505149979 "digits")
$

Find the last $10$ digits of $f_1$ and $f_2$.

Answer format: $f_1 mod 10^10,f_2 mod 10^10$

*Leading zeros are ignored*
]


// Problem #241
#problem-block(number: 241)[
Let's define a smooth factorization of $n!$ as $n!=f_1 times f_2 times dots.h.c times f_n$ with: \
$f_i <= f_(i+1)$ \
$f_n = "the largest prime factor of" n!$

Examples:
$
13! &= 2 times 3 times 3 times 5 times 5 times 6 times 6 times 6 times 7 times 8 times 8 times 11 times 13 \
&= 3 times 4 times 4 times 4 times 5 times 5 times 6 times 6 times 6 times 6 times 7 times 11 times 13 \
14! &= 4 times 4 times 4 times 4 times 4 times 5 times 5 times 6 times 7 times 7 times 9 times 9 times 11 times 13
$

Find the last (in numeric lexicographic order) smooth factorization of $28!$.

Answer format: comma separated list of factors

Example: `5,6,6,6,6,6,6,6,6,7,7,8,8,10,10,11,13,17,19` for $19!$.

*[My timing: 70 sec]*
]


// Problem #242
#problem-block(number: 242)[
Let $F_k (n)$ be a linear recurrence sequence such that
$
F_k (n) &= 1 med (1 <= n <= k), \
F_k (n) &= sum_(i=1)^k F_k (n-i) med (n>k).
$

For example, $F_2(1)=1$, $F_2(2)=1$ and $F_2(3)=2$.

Let $P(k,m)$ be the (minimum) period of $F_k (n)$ modulo $m$.

You are given that $P(2,10)=60$ and $P(2,10^9)=1 thin 500 thin 000 thin 000$.

Find $P(10,10^9)$.

*[My timing: instant]*
]


// Problem #243
#problem-block(number: 243)[
Let $F_k (n)$ be a linear recurrence sequence such that
$
F_k (n) &= 1 med (1 <= n <= k), \
F_k (n) &= sum_(i=1)^k F_k (n-i) med (n>k).
$

For example, $F_2(1)=1$, $F_2(2)=1$ and $F_2(3)=2$.

Let $P(k,m)$ be the (minimum) period of $F_k (n)$ modulo $m$.

You are given that $P(2,10)=60$ and $P(2,10^9)=1 thin 500 thin 000 thin 000$.

Find $P(50,10^9)$.

Note: The answer is a $29$ digit number.

*[My timing: 42 sec (PyPy)]*
]


// Problem #244
#problem-block(number: 244)[
A number is said brazilian if it can be written with the same 'digit' for some base ($0 < "digit" < "base"$).

For instance, the following numbers are brazilian: \
$2222=(2,2,2,2)_10$ \
$1281=(7,7,7)_13$ \
$33500852988=(127,127,127,127)_641$

How many brazilian numbers $<= 100 thin 000 thin 000 thin 000$ are there? (We consider only numbers with at least 3 'digits'.)

You are given: \
$114$ numbers $<= 1 thin 000$ \
$617$ numbers $<= 10 thin 000$ \
$3016$ numbers $<= 100 thin 000$ \
$14387$ numbers $<= 1 thin 000 thin 000$

*[My timing: 4.7 sec]*
]


// Problem #245
#problem-block(number: 245)[
$5$ points are placed on a circle. Consecutive integers $1$ to $6$ are placed on the center of the circle and on each point. Joining each consecutive pair of points with the center, we define $5$ triangles. The sums of integers for each triangle are: $12, 9, 8, 10, 9$. You can guess that the integers are respectively (center first, points clock-wise): $2, 4, 6, 1, 5, 3$.

#align(center)[
  #v(-5pt)
  #image(width: 200pt, "figures/p245.png")
  #v(5pt)
]

Now, we are using $11$ points. \
The sums inside the triangles are respectively: $26,22,26,22,14,16,22,26,22,24$.

Find the values for each point (same order as in the example).
There are more than one solution.

Answer format: comma separated lists between slashs (in lexicographic order)

Example: `1,2,3/3,2,1`
]


// Problem #246
#problem-block(number: 246)[
Let $S$ be a set like ${1,dots,M}$ with cardinality $N$.

Any element but the first can be written as a sum of some two lesser and not necessarily distinct elements.

How many such sets can you find if $M=1881$ and $N=15$?

Input format: `cnt,S_1001` \
(`S_1001` means $1001$st such set)

Example: `cnt,{1,2,3,6,7,13,26,52,104,208,209,418,836,1045,1881}` \
if asked $101$st such set.

Sets are ordered comparing each element from $1$ to $M$: \
$100$: ${1,2,3,6,7,13,26,52,104,208,209,418,627,1254,1881}$ \
$101$: ${1,2,3,6,7,13,26,52,104,208,209,418,836,1045,1881}$ \
Here, there is a difference at $13$th elements.

*[My timing: 2 s]*
]


// Problem #247
#problem-block(number: 247)[
Consider the permutation ${2, 10, 1, 8, 9, 4, 6, 3, 5, 7}$.

It can be decomposed in $4$ "runs" of ascending values: \
- $2, 10$
- $1, 8, 9$
- $4, 6$
- $3, 5, 7$

Let's draw the following graph:
- $10$ nodes ($1$ to $10$)
- we join by an edge each consecutive node in the same run

We get the following graph:

#align(center)[
  #v(-10pt)
  #image(width: 400pt, "figures/p247.png")
  #v(-5pt)
]

We count how many times edges are crossing: $3$ (blue dots)
- $[1,8]$ crosses $[2,10]$
- $[3,5]$ crosses $[4,6]$
- $[4,6]$ crosses $[5,7]$

We count how many egdes are nested below another one: $7$ (green lines)
- $[3,5]$ nested below $[2,10]$
- $[3,5]$ nested below $[1,8]$
- $[4,6]$ nested below $[2,10]$
- $[4,6]$ nested below $[1,8]$
- $[5,7]$ nested below $[2,10]$
- $[5,7]$ nested below $[1,8]$
- $[8,9]$ nested below $[2,10]$

Among all the permutations of ${1,2,dots,10}$ how many have exactly $4$ crossings and $8$ nestings? \
What is the latest in lexicographic order?

Answer format: `count/permutation` \
(as comma separated list)

Example: `99/1,2,3`

*[My timing: 20 sec]*
]


// Problem #248
#problem-block(number: 248)[
See the problem r237 from Philippe!
#footnote[Actually #link(<p241>)[Problem 241].]
Find the answer for $n=450$, as the answer would be quite long, give only $sum_(i=1)^n f[i]^6$.

Example: `80930279` for $n=19$.

*[My timing: 58 sec.]*
]


// Problem #249
#problem-block(number: 249)[
For given two real numbers $alpha$ and $beta$, a positive integer $n$ is called $k$-friend exponent of $alpha$ for $beta$ if $alpha^n$ and $beta$ shares the first $k$-significant digits.

For example, $n=9$ is a $1$-friend exponent of $pi$ for $e$ because $pi^9=29809.099333446 dots.h.c$ and $e=2.71828 dots.h.c$ shares "$2$".

Let $E(alpha,beta,k)$ denote the minimum $k$-friend exponent of $alpha$ for $beta$. It can be verified that $E(pi,e,1)=9$, $E(pi,e,2)=19$, $E(pi,e,5)=430881$ and $E(pi,e,10)=2448322414$.

Find $E(pi,e,50)$.

*[My timing: 0.5 sec. (PyPy)]*
]


// Problem #250
#problem-block(number: 250)[
A polyomino is a geometric figure obtained by joining equal squares edge by edge. We consider that one side of each square is painted: when comparing two polyominoes for symetry, the painted sides must always stay up. Two polyominoes are equal if they differ only by a rotation of a multiple of $pi/2$.

To sort the polyominoes, we define the "canonical value" of a polyomino as follow:
- A polyomino is represented by a matrix of $0$ and $1$.
- We consider all $4$ rotations and keep those where the matrix is such as the number of rows is $<=$ the number of columns.
- We add a column of $0$ at the end, flatten the values and consider them as a binary representation of some integer. The canonical value is *the smallest of these integers*.

For example, consider the polyomino

#[
#set table(fill: (x, y) => if ((y == 0 and x == 2) or (y == 1)) {blue})
#table(
  columns: (20pt,)*3, rows: 20pt, stroke: gray,
  [], [], [], [], [], []
)
]

It can be represented either by $mat(0,0,1;1,1,1)$ or by $mat(1,1,1;1,0,0)$.

The first representation yields the values ${0,0,1,0,1,1,1,0} = 46$. The second representation yields the values ${1,1,1,0,1,0,0,0} = 232$. Thus, the canonical value for this polyomino is $46$.

With $4$ squares, there are $7$ possible polyominoes (sorted by their canonical values):
- $30$
#[
#set table(fill: blue)
#table(
  columns: (20pt,)*4, rows: 20pt, stroke: gray,
  [], [], [], []
)
]
- $46$
#[
#set table(fill: (x, y) => if ((y == 0 and x == 2) or (y == 1)) {blue})
#table(
  columns: (20pt,)*3, rows: 20pt, stroke: gray,
  [], [], [], [], [], []
)
]
- $54$
#[
#set table(fill: blue)
#table(
  columns: (20pt,)*2, rows: 20pt, stroke: gray,
  [], [], [], []
)
]
- $78$
#[
#set table(fill: (x, y) => if ((y == 0 and x == 1) or (y == 1)) {blue})
#table(
  columns: (20pt,)*3, rows: 20pt, stroke: gray,
  [], [], [], [], [], []
)
]
- $108$
#[
#set table(fill: (x, y) => if ((y == 0 and x >= 1) or (y == 1 and x <= 1)) {blue})
#table(
  columns: (20pt,)*3, rows: 20pt, stroke: gray,
  [], [], [], [], [], []
)
]
- $142$
#[
#set table(fill: (x, y) => if ((y == 0 and x == 0) or (y == 1)) {blue})
#table(
  columns: (20pt,)*3, rows: 20pt, stroke: gray,
  [], [], [], [], [], []
)
]
- $198$
#[
#set table(fill: (x, y) => if ((y == 0 and x <= 1) or (y == 1 and x >= 1)) {blue})
#table(
  columns: (20pt,)*3, rows: 20pt, stroke: gray,
  [], [], [], [], [], []
)
]

How many polyominoes with $8$ squares are there? \
What is the canonical value of the $666$-th poylyomino?

Format answer: `Count,Value`

*[My timing: 40 sec]*
]


// Problem #251
#problem-block(number: 251)[
For the definitions, see problem 247.
#footnote[Actually #link(<p250>)[Problem 250].]
Among all the $8$-squares polyominoes, which ones can cover perfectly a $4 times 8$ rectangle? (A polyomino covers perfectly a rectangle if we can tile without hole or overlap, the rectangle with multiple copies of that poylomino.)

Answer format : comma separated list of canonical values (ascending order)

Example: `126,190,222,238,798,2110` \
for covering a $2 times 6$ rectangle with $6$-squares polyominoes.

*[My timing: 6 sec]*
]


// Problem #252
#problem-block(number: 252)[
Consider the following HUGE numbers:
$
a &= "googol"! \
b &= "Skewes' number" = upright(e)^upright(e)^upright(e)^79 \
c &= 2^3^4^5^6 \
d &= 6^5^4^3^2 \
e &= 4!!!! \
f &= p_"googol"\# quad (p_n\# "is the primorial function")
$

Sort these numbers in ascending order.

Answer format: comma separated list

Example: `f,e,d,c,b,a`

For the record, the primorial function $p_n\#$ is the product of the first n prime numbers.
$ p_5\# = 2 times 3 times 5 times 7 times 11 = 2310 $
]


// Problem #253
#problem-block(number: 253)[
$T(n)$ is the $n$-th triangular number.

$T(n)$ coins are arranged in a triangle. We color each coin with $4$ different colors such as no two touching coins have the same color.

For $n=2$, there are $24$ possible configurations:

```
+---+ +---+ +---+ +---+ +---+ +---+
| 1 | | 1 | | 1 | | 1 | | 1 | | 1 |
|2 3| |2 4| |3 2| |3 4| |4 2| |4 3|
+---+ +---+ +---+ +---+ +---+ +---+

+---+ +---+ +---+ +---+ +---+ +---+
| 2 | | 2 | | 2 | | 2 | | 2 | | 2 |
|1 3| |1 4| |3 1| |3 4| |4 1| |4 3|
+---+ +---+ +---+ +---+ +---+ +---+

+---+ +---+ +---+ +---+ +---+ +---+
| 3 | | 3 | | 3 | | 3 | | 3 | | 3 |
|1 2| |1 4| |2 1| |2 4| |4 1| |4 2|
+---+ +---+ +---+ +---+ +---+ +---+

+---+ +---+ +---+ +---+ +---+ +---+
| 4 | | 4 | | 4 | | 4 | | 4 | | 4 |
|1 2| |1 3| |2 1| |2 3| |3 1| |3 2|
+---+ +---+ +---+ +---+ +---+ +---+
```

We represent a configuration:

```
+-----+
|  A  |
| B C |
|D E F|
+-----+
```

as `A,BC,DEF`.

How many configurations are there for $n = 10$ \
What is the $10000000$-th (in lexicographic order)?

Example: `192/1,32,214` \
if we ask the $20$-th configuration for $n=3$.

*[My timing: 7 sec]*
]


// Problem #254
#problem-block(number: 254)[
An integer is semiprime if it is the product of $2$ (not necessarily distinct) prime numbers.

There are $34$ semiprimes below $100$: \
$4,6,9,10,14,15,21,22,25,26,33,34,35,38,39,46,49,51,55,57,58,62,65,69,74,77,82,85,86,87,$$91,93,94,95$

How many semiprimes are there below $30 thin 000 thin 000 thin 000$?

*[My timing: 60 sec]*
]


// Problem #255
#problem-block(number: 255)[
A complex integer is a number $p + q times i$ ($i^2 = -1$) where $p$ and $q$ are integers.

It can be proved that every complex integer has a unique representation in base $i-1$ with 'digits' $0$ or $1$.

For instance, we have:
$
2 &= 0 times (-1+i)^0+0 times (-1+i)^1+1 times (-1+i)^2+1 times (-1+i)^3 quad (1100) \
6 &= 0 times (-1+i)^0+0 times (-1+i)^1+1 times (-1+i)^2+1 times (-1+i)^3+1 times (-1+i)^4 + dots.h.c \
  & + med 0 times (-1+i)^5+1 times (-1+i)^6+1 times (-1+i)^7+1 times (-1+i)^8 quad (111011100)
$

Actually, $6$ is the smallest natural integer whose representation contains $6$ digits to '$1$'.

Let's define the function $R(n)$ for an natural integer $n$ as follow: consider the digits of n in base $i-1$ as the binary representation of an integer. \
Thus: \
$R(2) = 12$ \
$R(6) = 476$

Find the smallest integer $a$, whose representation contains $60$ digits. \
Find the smallest integer $b$, whose representation contains $93$ digits to '$1$'.

Answer format: `a,R(a),b,R(b)`

*[My timing: instant]*
]


// Problem #256
#problem-block(number: 256)[
The definitions are the same as in problem 252.
#footnote[Actually #link(<p255>)[Problem 255].]

Consider the following pseudo-random generator:

```c
static long seed = 641;
static long FastRandom()
{
	  seed = (214013 * seed + 2531011) % 43097251273073;
	  return seed;
}
```

Let $V$ the sequence of the first $100000$ values of FastRandom.

You are given the following values:

#table(
  stroke: none,
  columns: (auto, auto),
  table.hline(),
  [1], [139713344],
  table.hline(stroke: 0.5pt),
  [10],	[34286987424384],
  table.hline(stroke: 0.5pt),
  [100],	[2133420965406],
  table.hline(stroke: 0.5pt),
  [1000],	[31159015095342],
  table.hline(stroke: 0.5pt),
  [10000],	[29256942849607],
  table.hline(stroke: 0.5pt),
  [100000],	[42800860506246],
  table.hline()
)

Find the sum of $R(n)$ for all $n$ in $V$.

*[My timing: 12 sec]*
]


// Problem #257
#problem-block(number: 257)[
Pattern locks are a popular mechanism to secure our cell phones.

Given a grid $3 times 3$, the user define a path by joining some points on that grid:

#grid(
  stroke: 1pt,
  align: center+horizon,
  columns: (20pt,)*3,
  rows: 20pt,
  ..range(1, 10).map(it => [#str(it)])
)

We add the following constraints:
- the path starts with point $1$
- we visit every point exactly once

One possible path is: $1,4,3,5,6,2,7,8,9$.

Actually, there are exactly $5040$ possible paths with the above constraints. There are $2$ paths which reach the maximal length:
- $1,6,7,2,9,4,3,8,5$
- $1,8,3,4,9,2,7,6,5$
The maximal length is $16.652 dots$

A path starting with $1,3,2$ would not be valid, for when joining point $1$ and $3$ we have visited point $2$.

How many possible paths are there on a $3 times 4$ grid? \
Which paths reach the maximal length?

Answer format: `count/(comma separated list of points)`

Example: `5040/1,6,7,2,9,4,3,8,5/1,8,3,4,9,2,7,6,5` \
for a $3 times 3$ grid.

*[My timing: 40 sec]*
]


// Problem #258
#problem-block(number: 258)[
Let $P$ a finite set of prime numbers.

A $P$-set is the set of all numbers whose prime factors are in $P$.

For instance, if $P = {2,3,5}$, the corresponding $P$-set is \
${1,2,3,4,5,6,8,9,10,12,15,16,18,20,24,25,27,30,32,36,dots}$.

The $100000$th number of this $P$-set is $290142196707511001929482240000000000000$.

What is the $100000000$th number in the ${2,3,5,7,11}$-set?

*[My timing: 40 sec]*
]


// Problem #259
#problem-block(number: 259)[
The classical latin alphabet {*a*, b, c, d, *e*, f, g, h, *i*, j, k, l, m, n, *o*, p, q, r, s, t, *u*, v, w, x, *y*, z} contains $20$ consonants and $6$ *vowels*.

What is the probability that in a permutation of this alphabet, there are no consecutive vowels?

Answer format: `P/Q` \
with `P` and `Q` coprime.

*[My timing: < 1 sec]*
]


// Problem #260
#problem-block(number: 260)[
See the following number:

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p260.png")
  #v(5pt)
]

What is the biggest number you can get if you are allowed to move $1$, $2$, $3$ or $4$ matchsticks?

Answer format: `n1,n2,n3,n4`

Notes:
- You should look for the ways to increase the number of digits. For example out of "$8$", you can make "$51$" by moving $2$ sticks.
- Ignore any spacing issues after the move, think all the digits as a part of the one new number.
]


// Problem #261
#problem-block(number: 261)[
$P$ is the set of prime numbers.

Let $S = sum_(p in P) 1/(1+p^2) = 0.3890595553 dots$.

Find the value of $S$ with a precision of $50$ digits after the decimal point (truncated not rounded).

*[My timing: 15 sec]*
]


// Problem #262
#problem-block(number: 262)[
Using $20$ matchsticks, we can write the following prime number:

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p262.png")
  #v(5pt)
]

How may different prime numbers can you write using exactly $20$ matchsticks?

*[My timing: < 200 ms]*

N.B.: Non significative $0$s are not allowed, thus: $0019$ is not valid.
]


// Problem #263
#problem-block(number: 263)[
Let $x_1 = 1$ and $x_i = x_(i-1) + "sum_of_digits"(x_(i-1))$ for $i > 1$.

You are given that $x_10 = 62$, $x_100 = 1205$ and $x_100000 = 2609882$.

Find $x_(10^17)$.

*[My timing: 0.2 sec.]*
]


// Problem #264
#problem-block(number: 264)[
We have
$ 1040^(-2) + 4095^(-2) = 1008^(-2) $

How many solutions are there to the "anti-pythagorean" equation $x^(-2)+y^(-2)=z^(-2)$ with $x,y,z$ coprime and $x<=y$ and $x<=10^12$?

Answer format: `count,`$sum z$

*[My timing: 9 sec]*
]


// Problem #265
#problem-block(number: 265)[
See the problem 261 from Philippe for the description.
#footnote[Actually #link(<p264>)[Problem 264].]

In this problem, find the answer for $x <= 10^18$.

*[My timing: 0.8 sec.]*
]


// Problem #266
#problem-block(number: 266)[
The parallelepipedic box of dimensions $2 times 3 times 6$ has a diagonal of $7$.

A parallelepipedic box with integer sides has a diagonal of $100000$.

Let $x,y,z$ its dimensions with $x<=y<=z$.

Find all the possible triples $x,y,z$.

Answer format: `count,`$sum z$

*[My timing: 10 sec]*
]


// Problem #267
#problem-block(number: 267)[
This conjecture states:
#quote[
Every rational $display(n/d)$ can be written $display((p+1)/(q+1))$ where $p, q$ are prime numbers.
]

For instance: $22/7=(43+1)/(13+1)$, $355/113=(2129+1)/(677+1)$.

Find the representation for $(2^19-1)/2^19$.

Answer format: `p,q` \
give the smallest pair $p,q$.

*[My timing: < 1 sec]*
]


// Problem #268
#problem-block(number: 268)[
There is a grid of roads ($M times N$). Two people, one at $A (0,0)$ and the other at $B (N,M)$, start to walk from $A$ to $B$ and $B$ to $A$ respectively at the same time. They both walk the shortest path to their destination. For instance, if you come from $B$ to $A$, you must always move from East to West (left) or North to South (down).

The man at $B$ walks faster than the one at $A$ by a factor of $k$ ($v_B=k dot v_A$ where $k>1$).

If they walk in any *possible* direction equally likely on a $19 times 23$ grid, what is the probability that they meet each other on their way if $k$ is equal to $4\/3 med (1)$ or $6\/5 med (2)$?

Answer Format: $P_1\/Q_1,P_2\/Q_2$

Example: Answer=`5/14,5/28` for $k=2$ and $k=3\/2$ on $3 times 3$ grid.

The following shows a possible meeting for $k=2$:

#align(center)[
  #v(5pt)
  #image("figures/p268.png")
  #v(5pt)
]
]


// Problem #269
#problem-block(number: 269)[
Consider the integers in range $[111, 122]$ in binary form:

```
1 1 0 1 1 1 1
1 1 1 0 0 0 0
1 1 1 0 0 0 1
1 1 1 0 0 1 0
1 1 1 0 0 1 1
1 1 1 0 1 0 0
1 1 1 0 1 0 1
1 1 1 0 1 1 0
1 1 1 0 1 1 1
1 1 1 1 0 0 0
1 1 1 1 0 0 1
1 1 1 1 0 1 0
```

and count how many times the digit $0$ appears. There are $28$ zeros.

How many times does the digit $0$ appear in the range $[12345678910111213,  31211101987654321]$?

*[My timing: < 100 ms]*
]


// Problem #270
#problem-block(number: 270)[
$V$ is a vector $in {-1,1}^n$.

We define the following $n$ sums:
$
S_j = sum_(i=1)^j V_i  - sum_(i=j+1)^n V_i quad "for" 1 <= j <= n
$

For example if $V=(-1,-1,1,1,1)$ then $S=(-3,-5,-3,-1,1)$.

We define then $T_j=1$ if $S_j>0$ and $0$ otherwise. Thus $T=(0,0,0,0,1)$.

There are $2^n$ possible vectors $V$.

How many different vectors $T$ are there?

Give your answer for $n = 50$.

Hint: there are $2728$ possibilities for $n = 15$.
]


// Problem #271
#problem-block(number: 271)[
For a triangle, there is always at least one line that splits simultaneously the perimeter and the area in two equal parts.

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p271.png")
  #v(5pt)
]

You are given a triangle of sides $7182, 8182, 8459$.

Find how many lines split fairly this triangle and give there length (line $P Q$ on the picture) in ascending order (comma delimited, rounded to $5$ digits after the decimal point).

*Caveat*: If $2$ distinct lines have the same length, they will be counted as $2$ solutions.
]


// Problem #272
#problem-block(number: 272)[
$f$ is a function such as
- $f:[0,∞[ -> bb(R)$
- $f$ is strictly increasing
- $f(x)>-1/x$
- $f(x) dot f(f(x)+1/x)=1$ for all $x>0$

What is $f(1)$?

Give your answer rounded to $10$ digits after the decimal point.
]


// Problem #273
#problem-block(number: 273)[
Solve the diophantine equation (Euler)
$
2^200 = 7 dot x^2 + y^2 "with" x, y "odd" > 0
$

Answer format: `x,y`

*[My timing: < 100 ms]*
]


// Problem #274
#problem-block(number: 274)[
$n$ is an integer $> 2$.

The $n+1$ point of a permutation of $0,1,dots,n$ are placed on a circle.

The permutation is said beautiful if for any $4$ numbers $0 <= a,b,c,d <= n$ with $a+c = b+d$, the chord joining $a$ and $c$ does not intersect the chord joining $b$ and $d$.

For $n=3$, there are $4$ beautiful permutations:

#align(center)[
  #v(5pt)
  #image("figures/p274.png")
  #v(5pt)
]

How many beautiful permutations are there for $n=1000$?

You are given: \
$C = 6$ for $n = 4$ \
$C = 10$ for $n = 5$

*[My timing: < 1 s]*
]


// Problem #275
#problem-block(number: 275)[
How many pairs of positive integers $(a,b)<=10^9$ are there such as
$ (a^2)/(2 a b^2 - b^3 + 1) $
is an integer.

*[My timing: instant]*
]


// Problem #276
#problem-block(number: 276)[
#box(width: 225pt, height: 35pt, inset: 5pt, fill: rgb(0, 1, 59))[
  #text(font: FontSans, size: 10pt, fill: rgb(0, 220, 98))[
    I'm sure you can make something out of this.
  ]
  #text(font: FontSans, size: 12pt, weight: "bold", fill: rgb(255, 0, 0))[
    Pay attention to the title!
  ]
]

#parbreak()
#v(10pt)
#text(fill: ColorSecondary)[
  The background image code for this problem is as follows:
]

```
background-image:url('
data:image/bmp;base64,
Qk1+AQAAAAAAAD4AAAAoAAAAIAAAAAoAAAABAAEAAAAAAEABAAAAAAAAAAAAAAAAAAAAAAAAOwEAADsB
AABQSwMEFAABAAAAOZBWR9XAp3AwAAAAJAAAAAEAAAAypRjqizuI0Jynv8UeROBStDrYee20F7as2tqC
uitUVXHmECq1ycLTsyC6fu8IUP/gUEsDBBQAAQAAADmQVkccxXIuQgAAADYAAAABAAAAM1AP8NKjrG/W
ycRbRewGuIGx5gdK/hgWxaYtlKMKKwy2kXEkS6Koqo/+hUbEDWKtWzzD/Y2nQKkQlYXb/7lZkhPY/VBL
AwQUAAEAAAA5kFZHktMJ32YAAABaAAAAAQAAADUwmjixRkWjMCRwKdPomcAjXe6rPet0Hdz+le67Mh+J
llBPk/xFhOO5j+W2U49yPHeGhmY7aIofM4zfhcBn+1gRwYm3WX6KTnluvWuFDce9qChAxXKHgidEux+r
mhO8H/oul3ZFww9QSwECHgAFBAMCAQ==
')
```
]


// Problem #277
#problem-block(number: 277)[
We have $1233=12^2+33^2$.

In homage to Hendrik Lenstra who first noticed this property let's call such integers Lenstra's numbers.

Find the first $36$-digits Lenstra's number i.e. $n$ such as: \
$n = d_1 d_2 dots.h.c d_36 = (d_1 d_2 dots.h.c d_18)^2 + (d_19 d_20 dots.h.c d_36)^2$.

*[My timing: < 1 sec]*
]


// Problem #278
#problem-block(number: 278)[
A random generator emits letters based on the English letter frequencies as given below: Out of $10000$ letters, it would emit $1203$ E's, $910$ T's, $812$ A's, $768$ O's, $731$ I's $695$ N's, $628$ S's $602$ R's, $592$ H's, $432$ D's, $398$ L's, $288$ U's, $271$ C's, $261$ M's, $230$ F's, $211$ Y's, $209$ W's, $203$ G's, $182$ P's, $149$ B's, $111$ V's, $69$ K's, $17$ X's, $11$ Q's, $10$ J's, and $7$ Z's.

The generated letters are concatenated to a string starting from an empty string.

What is the probability that we would see a *"...THISISTHEEND"* before seeing any *"...THIS..."*, *"...IS..."*, *"...THE..."* or *"...END..."*?

Answer format: `N/D` \
(irreducible fraction)

Check point: \
Answer=`1/245` to see a *"...THEEND"* before seeing any *"...THE..."* or *"...END..."* if it were to emit E,T,N,H,D with equal probabilities.
]


// Problem #279
#problem-block(number: 279)[
Solve the system:
$
(4 x^2) / (1 + 4 x^2) &= y \
(4 y^2) / (1 + 4 y^2) &= z \
(4 z^2) / (1 + 4 z^2) &= x
$
with $x,y,z!=0$.

Answer format: `x,y,z` \
(in form `p/q` as they are rational numbers)
]


// Problem #280
#problem-block(number: 280)[
Given $n$ nonnegative real numbers $a 1 <= a 2 dots.h.c <= a_n$ we have:
$
sum_(i=1)^n a_i = 96 \
sum_(i=1)^n a_i^2 = 144 \
sum_(i=1)^n a_i^3 = 216
$

Find $n$, $a_1$ and $a_n$.

Answer format: $n,a_1,a_n$ \
(in form `p/q` as $a_i$ are rational numbers)
]


// Problem #281
#problem-block(number: 281)[
```
2669036874315126775104877548238488463891833998332712460583098453881000,
0484301744523614366479893134367535543909264822062412679066093167567155,
1354048607368638427346804918325229520841941616290566812653826024545117,
1350648907706272463683405891107264553969125237442323337687390942483673,
2509362553029436312532246910309862404167219972001633567328214012282722
```

You need to make something out of these numbers.
]


// Problem #282
#problem-block(number: 282)[
Given a prime number $p$, we define the Wilson quotient as: \
$W_p = ((p-1)!+1) / p$ \
and its residue modulo p as: \
$w_p = W_p "modulo" p$ in the interval $-p/2 <= w_p < p/2$.

Find $w_200000039$.

*[My timing: 45 sec]*
]


// Problem #283
#problem-block(number: 283)[
Consider the sequence $S(n)$ defined by:
$
S(1) &= 2 \
S(n) &= S(n-1) + "GCD"(S(n-1), n-1+(-1)^n) quad (n > 1)
$

The first values are: \
$2,4,5,6,9,12,13,14,21,22,23,24,25,26,39,40,45,54,55,60,dots$

We calculate the vector of first differences $D(n)=S(n+1)-S(n)$: \
$2,1,1,3,3,1,1,7,1,1,1,1,1,13,1,5,9,1,5,1,1,1,3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,$$43,dots$

Then, we select in this vector each value greater than all the previous ones: \
$2,3,7,13,43,dots$

Find the $32$nd element of this sequence.

You are given:
- $M(1) = 2$
- $M(2) = 3$
- $M(10) = 2659$

*[My timing: 7 min]* \
Some solvers found it under 1 min. \
There is a fascinating conjecture about this sequence of champions: each champion is the larger prime of a twin pair of primes
]


// Problem #284
#problem-block(number: 284)[
Given a vector $A$ of rational numbers, we define the following transformation: \
$B={1 times (A_1-A_2),2 times (A_2-A_3),3 times (A_3-A_4),dots}$

We repeat the process: \
$C={1 times (B_1-B_2),2 times (B_2-B_3),3 times (B_3-B_4),dots}$

And so on ...

Consider now the vector \
$Z={B_1,C_1,D_1,dots}$

If $A={1/1,1/2,1/3,1/4,dots}$ find the first index such as the denominator of $Z_i$ is $>10^50$.

Answer format: `index,denominator`

*[My timing: < 1 sec]*
]


// Problem #285
#problem-block(number: 285)[
You need to decode the following string: \
`yparjcfwnixigfwzt`

Here's the pseudo code to get this encoded string:

```pascal
function encode(string, n=29101923, offset=10^9)
begin
	len=length of string
	let array be an array with offset+len elements
	for i=1 to n
	begin
		array[i]=1
	end
	for i=n+1 to offset+len
	begin
		array[i]=sum of previous n elements
	end
	for i=1 to len
	begin
		encoded_string[i]=string[i] shifted by (array[offset+i] mod 26)
	end
	return encoded_string
end
```

Example: \
`encode("solution", 101, 10^5)` returns `"bvktehbs"`.

*[My timing: < 1 m]*
]


// Problem #286
#problem-block(number: 286)[
Let there be $N$ distinct colors.

Let $a_n = (a_(n-1) + a_(n-2)) mod 9$ with $a_1 = a_2 = 1$.

Consider the ways to paint all the faces of dodecahedron using these $N$ distinct colors. *If selected, you can use up to $a_i+2$ but no less than 2* of $i$-th color where $i$ = $1$ to $N$.

What is the total number of ways to paint a dodecahedron if $N = 1000$?

Answer format: `number`

Example: `652706` if $N = 5$ or `130992447` if $N = 10$.

*[My timing: 2 s]*
]


// Problem #287
#problem-block(number: 287)[
Consider the numbers in base-$12$ that can be written with the decimal digits only ($0$ to $9$).

Of those, find *the smallest* number which, after a ROR $1$ (*RO*tate to *R*ight) operation,  gives a number equal to $8$ times the original number.

Example: $2497$ becomes $7249$ which is $3$ times the original \
$(7249)_12\/(2497)_12=3$

Answer format: the number in base-$12$

See also: #link("https://en.wikipedia.org/wiki/Circular_shift")[Circular shift - Wikipedia, the free encyclopedia]
]


// Problem #288
#problem-block(number: 288)[
*e* and *Pi* are transcendental numbers meaning they cannot be the roots of an algebraic equation with rational coefficients.

So we look for some approximations such that the root of an quadratic equation is as close as possible.

Let the equation be given with the $A,B,C$ triples: $A dot x^2+B dot x+C=0$ where $A$, $|B|$ and $|C|$ are integers $<10^10$ and $>0$.

Find the $(A_upright(e),B_upright(e),C_upright(e))$ and $(A_"Pi",B_"Pi",C_"Pi")$ triples and corresponding roots ($"root"_upright(e)$ and $"root"_"Pi"$), and calculate the following ratios: \
$R_upright(e) = |upright(e) - "root"_upright(e)|\/upright(e)$ \
$R_"Pi" = |"Pi" - "root"_"Pi"|\/"Pi"$

What are the best triples for e and Pi?

Answer format: $A_upright(e),B_upright(e),C_upright(e),A_"Pi",B_"Pi",C_"Pi"$ \
(the triples with the smallest ratio)

See also: \
#link("https://en.wikipedia.org/wiki/Transcendental_number")[*Transcendental number* - Wikipedia, the free encyclopedia] \
#link("https://en.wikipedia.org/wiki/Integer_relation_algorithm")[*Integer relation algorithm* - Wikipedia, the free encyclopedia]
]


// Problem #289
#problem-block(number: 289)[
$x^2 + y^2 - k dot x dot y = 1$ #h(1em) (#text(fill: rgb(255, 0, 0), weight: "bold")[1]) \
where $k$ is an integer $> 1$ and $0 < x < y$.

Let $"pol"(n)$ be a monic polynomial of degree $n$: \
$k^n + a_(n-1) dot k^(n-1) + dots.h.c + a_1 dot k + a_0$

If the first solution to the above equation (#text(fill: rgb(255, 0, 0), weight: "bold")[1]) is $(1,k)$ pair then the solution to $n$-th would be $("pol"(n-1),"pol"(n))$.

What is the $100$-th solution?

Answer format: $italic("sum")_1+italic("sum")_2$ \
where $italic("sum")_1=sum a_i^3$ for $"pol"(99)$ and $italic("sum")_2=sum a_i^3$ for $"pol"(100)$.

Example: `-17402` \
($875-18277$) for $10$-th solution.

*[My timing: < 1 s]*

See also: \
#link("https://en.wikipedia.org/wiki/Monic_polynomial")[*Monic polynomial* - Wikipedia, the free encyclopedia] \
#link("https://en.wikipedia.org/wiki/Diophantine_equation")[*Diophantine equation* - Wikipedia, the free encyclopedia]
]


// Problem #290
#problem-block(number: 290)[
A triangle $A B C$ has the following dimensions:
- $B C = a = 1033$
- $A C = b = 1553$
- $A B = c = 1973$

We choose $3$ points:
- $P$ on $A B$ at a distance $p$ of $A$ ($0 < p < c$)
- $Q$ on $B C$ at a distance $q$ of $B$ ($0 < q < a$)
- $R$ on $A C$ at a distance $r$ of $C$ ($0 < r < b$)
($p,q,r$ are integers)

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p290.png")
  #v(5pt)
]

How many triples $(p,q,r)$ are there such as the lines $A Q$, $B R$ and $C P$ are concurrent?

Answer format: $"Count",sum p,sum q,sum r$

You are given: `4,214,202,206` for the triangle $101,103,107$.

*[My timing: < 20 sec]*
]


// Problem #291
#problem-block(number: 291)[
Using lowercase hex digits `1` to `f`, fill the grid given in the picture in such a way to get the lowest possible hex number when you concatenate the lines starting from top to bottom.

#align(center)[
  #v(5pt)
  #image(width: 200pt, "figures/p291.png")
  #v(5pt)
]

Answer format: last $2$ lines \
(last $30$ digits of the number)

*[My timing: < 10 s]*
]


// Problem #292
#problem-block(number: 292)[
#footnote[Actually #link(<p289>)[Problem 289].]
Consider the following Diophantine equation: \
$x^2+y^2-k dot x dot y=1$ where $k>1$ and $0<=x<y$.

If the first solution is $(0,1)$, what is the kth solution for $k=3^4^5$?

Answer format: $x%M,y%M$ \
where $M=1000000007$

*[My timing: < 1 ms]*
]


// Problem #293
#problem-block(number: 293)[
```
X5dzkDFkg5BnNUEchPVkYb87f7X1QNu0MDR6U1pzQLjCPHUlNPT0KJRsRHZu
iJd0eYTohf5kbLA/bcLmgeWmMGmomEpC
```

Enter the key to decode it.
#align(center)[
Key  = #h(3pt)
#box(width: 10em, baseline: 25%, radius: 3pt, inset: (x: 2pt, y: 4pt), stroke: gray)[
  #align(left)[1]
]
#h(3pt)
#box(baseline: 25%, fill: luma(90%), inset: (x: 2pt, y: 4pt), stroke: gray)[Decode it]
]

#[
#set text(fill: rgb(0, 0, 255))
#show "Key=1": set text(weight: "bold")

```
Key=1



Not a key!
```
]

#parbreak()
#v(10pt)
#text(fill: ColorSecondary)[
  The JavaScript code for this problem is as follows:
]

```js
function func()
{
    var keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    var A=parseInt(myform.myinput.value);
    var K=404;
    var KK=K*K;
    var AA=A*A;
    var encodedText = document.getElementById('encoded_text').innerHTML;
    var outputDiv = document.getElementById("outputDiv");
    outputDiv.innerHTML = "<pre\>";
    if (A<=0) {
        alert("Should be >0");
    } else {
        outputDiv.innerHTML += "<font size=+2 \><b\>Key="+A+"</b\></font\><br\><br\>";
        // K*A^2+K*x-A-x^2=0 : x^2-Kx+A-KA^2=0
        var delta=Math.sqrt(KK+4*(AA-1)*K);
        var x=Math.floor((K+delta)/2);
        for(var ii=-1; ii<2; ++ii){
            var t=x+ii;
            var tt=t*t;
            var z1=K*(AA+t), z2=(tt+A);
            if (z1==z2){
                var arr=new Array();
                var i=0, keylen=0, s=t, cd=0;
                while (s>0) {
                    arr[keylen++]=s%10;
                    s=Math.floor(s/10);
                }
                outputDiv.innerHTML += "Decoded: ";
                var j=keylen, k=0;
                for(i=0; i<encodedText.length; ++i) {
                    var inx=keyStr.indexOf(encodedText.charAt(i));
                    if(inx<0) continue;
                    if(--j<0)
                        j+=keylen;
                    inx-=arr[j];
                    if (inx<0)
                        inx+=64;
                    outputDiv.innerHTML += keyStr.charAt(inx);
                    if(i>0 && (i&63)==0)
                        outputDiv.innerHTML += "<br\>";
                    cd+=k++*keyStr.charCodeAt(inx);
                }
                if (cd==360117)
                    outputDiv.innerHTML += "<br\><br\><font color=\"green\"/>Decoded successfully.</font/><br\>";
                else
                    outputDiv.innerHTML += "<br\><br\><font color=\"red\"/>Decoded something but it doesn't seem to be OK.</font/><br\>";
                break;
            }
        }
        outputDiv.innerHTML += "<br\>";
        if (ii==2)
            outputDiv.innerHTML += "<br\><font color=\"red\"/>Not a key!</font/><br\>";
    }
    outputDiv.innerHTML += "</pre\>";
}
```
]


// Problem #294
#problem-block(number: 294)[
A Heronian triangle $A B C$ has the following dimensions:
- $B C = a = 203$
- $C A = b = 265$
- $A B = c = 372$

We choose $3$ points:
- point $X$ on $B C$ at a distance $p$ of $B$
- point $Y$ on $A C$ at a distance $q$ of $A$
- point $Z$ on $A B$ at a distance $r$ of $C$
($p,q,r$ are integers)

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p294.png")
  #v(5pt)
]

For how many triples $(p,q,r)$ the ratio $"Area"(A B C)\/"Area"(P Q R)$ is an integer?

Answer format: `Count/p,q,r` \
for the smallest ratio

You are given: `6/2,3,2` for the triangle $(3,4,5)$.

*[My timing: 10 sec]*
]


// Problem #295
#problem-block(number: 295)[
The Hurwitz equation is the following diophantine equation. For fixed $n,k>0$:
$
x_1^2+x_2^2+dots.h.c +x_n^2 = k x_1 x_2 dots.h.c x_n quad "for" k,n in bb(N)^*
$

It can be proved that when this equation has solutions, then $k<=n$.

Can you find all the $k$ such as this equation has solution for $n=61$?

Answer format: comma delimited list of $k_s$

You are given: `1,4,5,13,23` for $n = 23$.

*[My timing: 90 sec]*

PS: There are much faster solutions than mine ...
]


// Problem #296
#problem-block(number: 296)[
Consider the #link("https://en.wikipedia.org/wiki/Farey_sequence")[Farey sequence] of order $n$.

For instance $F_4={0/0,0/1,1/4,1/3,1/2,2/3,3/4,1/1}$.

We define $F_n (z)$ by applying a zoom $z$ i.e. multiplying each term by $z$.

We consider each term of the sequence $F_n (z)$ as a point and join these points respecting the order. We obtain the Farey polygon $P_n (z)$ of order $n$ and zoom $z$

#align(center)[
  #v(5pt)
  #image("figures/p296.jpg")
  #v(5pt)
]

$P_4(2)$ contains $5$ points in its interior.

Find the first Farey polygon $P_n (2)$ whose inside contains (strict) more than $2000$ lattice points.

Answer format: `n,count`

*[My timing: 40 sec]*
]


// Problem #297
#problem-block(number: 297)[
What is the area of the Farey polygon (See #link(<p296>)[problem 296]) of order $10000000$ and zoom $1$?

You are given: `1522` for the Farey polygon of order $100$.

*[My timing: 40 sec]*
]


// Problem #298
#problem-block(number: 298)[
```
4pxLgKsp+pVENasG+apWefzl9Ko/RbD7vGgUTbz7wm8UTb3lt5xNiOA3r5hS
NOc0ApxRd+w48FdHefLu`
```

Enter the key to decode it.
#align(center)[
Key  = #h(3pt)
#box(width: 10em, baseline: 25%, radius: 3pt, inset: (x: 2pt, y: 4pt), stroke: gray)[
  #align(left)[12345678]
]
#h(3pt)
#box(baseline: 25%, fill: luma(90%), inset: (x: 2pt, y: 4pt), stroke: gray)[Decode it]
]

#[
#set text(fill: rgb(0, 0, 255))
#show "Key=12345678": set text(weight: "bold")
#show "Not a key!": set text(fill: rgb(255, 0, 0))

```
Key=12345678



Not a key!
```
]

#parbreak()
#v(10pt)
#text(fill: ColorSecondary)[
  The JavaScript code for this problem is as follows:
]

```js
function func()
{
    var keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    var Key=parseInt(myform.myinput.value);
    var encodedText = document.getElementById('encoded_text').innerHTML;
    var outputDiv = document.getElementById("outputDiv");
    outputDiv.innerHTML = "<pre\>";
    if (Key<=0) {
        alert("Should be >0");
    } else {
        var arr=new Array();
        var i=0, keylen=0, s=Key, cd=0;
        while (s>0) {
            arr[keylen++]=s%10;
            s=Math.floor(s/10);
        }
        if(keylen!=8) {
            alert("key should be 8 digits long");
        } else {
            outputDiv.innerHTML += "<font size=+2 \><b\>Key="+Key+"</b\></font\><br\><br\>";
            var inx=keylen;
            while (1) {
                for (i=s=0; i<keylen; ++i) s+=arr[i];
                if (--inx<0) inx+=keylen;
                arr[inx]=s;
                if (s==Key) {
                    outputDiv.innerHTML += "Decoded: ";
                    var j=keylen, k=0;
                    for(i=0; i<encodedText.length; ++i) {
                        var inx=keyStr.indexOf(encodedText.charAt(i));
                        if (inx<0) continue;
                        if(--j<0)
                            j+=keylen;
                        inx+=arr[j]&63;
                        if (inx>=64)
                            inx-=64;
                        outputDiv.innerHTML += keyStr.charAt(inx);
                        if(i>0 && (i&63)==0)
                            outputDiv.innerHTML += "<br\>";
                        cd+=++k*keyStr.charCodeAt(inx);
                    }
                    if (cd==281077)
                        outputDiv.innerHTML += "<br\><br\><font color=\"green\">Decoded successfully.</font><br\>";
                    else
                        outputDiv.innerHTML += "<br\><br\><font color=\"red\">Decoded something but it doesn't seem to be OK.</font><br\>";
                    break;
                } else if (s>Key) {
                    outputDiv.innerHTML += "<br\><br\><font color=\"red\">Not a key!</font><br\>";
                    break;
                }
            }
        }
        outputDiv.innerHTML += "<br\>";
    }
    outputDiv.innerHTML += "</pre\>";
}
```
]


// Problem #299
#problem-block(number: 299)[
```
1,3,6,1,6,21,82,9,81,...,?
```

Note: *This is partly a stegano challenge. And think of the title as a hint.*
]


// Problem #300
#problem-block(number: 300)[
Consider the square with side $= 720$.

We can dissect it in $3$ Pythagorean triangles:
- $(720, 210, 750)$
- $(510, 272, 578)$
- $(448, 720, 848)$

#align(center)[
  #v(5pt)
  #image("figures/p300.jpg")
  #v(5pt)
]

We represent this dissection as: $c_1,c_2,c_3 = 720,210,272$ ($c_2<=c_1/2$)

How many squares with integer sides $<=20000$ can be dissected this way?

Anser format: $"Count",sum c_1,sum c_2,sum c_3$

You are given: `3,2040,1035,569` for a threshold of $1000$.

*[My timing: 24 sec]*
]


// Problem #301
#problem-block(number: 301)[
The following integer triangle with sides $136, 170, 174$ has medians with integer length:
- $A P = 158$
- $B Q = 131$
- $C R = 127$

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p301.jpg")
  #v(5pt)
]

Find all the integer triangles with perimeter $<= 10000$ having integer medians.
(We consider only primitive triangles: if $(a,b,c)$ is a solution so is $(k dot a,k dot b,k dot c)$. We count only $(a,b,c)$).

Anser format: $"Count",sum a,sum b,sum c$ \
($a,b,c$ being the sides of the triangles)

You are given: `2,390,432,490` for a threshold of $1000$.

*[My timing: 80 sec]*
]


// Problem #302
#problem-block(number: 302)[
$
a_(n+1) &= 1 dot a_n - 1 dot b_n +  2 dot c_n -  3 dot d_n + 5 dot e_n -  8 \
b_(n+1) &= 1 dot b_n - 2 dot c_n +  3 dot d_n -  5 dot e_n + 8 dot a_n - 13 \
c_(n+1) &= 2 dot c_n - 3 dot d_n +  5 dot e_n -  8 dot a_n +13 dot b_n - 21 \
d_(n+1) &= 3 dot d_n - 5 dot e_n +  8 dot a_n - 13 dot b_n +21 dot c_n - 34 \
e_(n+1) &= 5 dot e_n - 8 dot a_n + 13 dot b_n - 21 dot c_n +34 dot d_n - 55 \
a_0 &= b_0 = c_0 = d_0 = e_0 = 1
$

What is $n$-th solution for $n=3^4^5$?

Answer format: $a_n%M,b_n%M,c_n%M,d_n%M,e_n%M$ \
where $M=10000019$

Note: *The answer should consist of positive numbers.*
]


// Problem #303
#problem-block(number: 303)[
It is well known that the Pell-Fermat equation $x^2-n dot y^2=1$ (*1*) has always solutions when $n$ is not square. But for the symetrical equation $x^2-n dot y^2=-1$ (*2*), solutions are much rare.

For instance, if $n<=100$, this equation has solutions for only $20$ values.

For how many $n<=5000000$, has the equation (*2*) solutions?

*[My timing: 70 sec]*
]


// Problem #304
#problem-block(number: 304)[
Consider the sequence of characters `ABCD`, each character being taken twice.

It is possible to order this sequence in such a way that:
- There is $1$ character between $2$ `A`s
- There are $2$ characters between $2$ `B`s
- There are $3$ characters between $2$ `C`s
- There are $4$ characters between $2$ `D`s

$mono(B) underbrace(mono(C D), 2) mono(B A) underbrace(med mono(C) med, 1) mono(A D)$ \
$mono(B C) overbrace(mono(D B A), 3) mono(C A D)$ \
$mono(B C D) overbrace(mono(B A C A), 4) mono(D)$

Find the last such order in lexicographic order for the sequence `ABCDEFGHIJKLMNOPQRSTUVWXYZ_` (each character is taken twice).

*[My timing: < 1 sec]*
]


// Problem #305
#problem-block(number: 305)[
$sigma(n)$ is the function sum of divisors of $n$.

Find the digital sum of $sigma(100000!)$.

You are given: digital sum of $sigma(1000!)=11349$.

*[My timing: 15 sec]*
]


// Problem #306
#problem-block(number: 306)[
PerfectStone Co. is an excavation company that is specialized in mining gold nodes. An unusual thing happened as they excavated a golden rod. On top of that, this stunning rod is really a long one! Now, they want to cut the rod in pieces and sell them to companies interested.

The length of the rod is $1000$-units and they have to cut the rod into pieces of integer-sized units and sell all of them. They have given you a #link("https://rosecode.neocities.org/uploads/golden_rod.txt")[log] that has the prices listed for each associated integer-size (prices for $1$-unit to $1000$-units).

All they ask from you is to maximize the revenue and supply here the best revenue attainable.
]


// Problem #307
#problem-block(number: 307)[
The definitions are the same as in #link(<p304>)[problem 304].

Find the *first* such order in lexicographic order for the sequence `ABCDEFGHIJKLMNOPQRST`.

*[My timing: 60 sec]*
]


// Problem #308
#problem-block(number: 308)[
A circular pie of radius $1$ unit is divided in $3$ equal (same area) parts by $2$ lines perpendicular to its diameter.

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p308.jpg")
  #v(5pt)
]

What is the length of segment $A B$?

Give the result rounded to $10$ places after the decimal point.
]


// Problem #309
#problem-block(number: 309)[
Define $f(n) =$ the number of $0$s before the last $1$ in the binary representation of $n$. We have \
$100=11bold(00)100_2 => f(100)=2$ \
$1000=11111bold(0)1000_2 => f(1000)=1$ \
$10000=100111bold(000)10000_2 => f(10000)=3$

Let $gamma=10^100$ (A googol).

Find $n_1=f(10^gamma)$ and $n_2=f(10^(8 times gamma))$.

Answer format: $n_1,n_2$

*[My timing: instant]*
]


// Problem #310
#problem-block(number: 310)[
In mathematics, the nimbers, also called Grundy numbers, are introduced in combinatorial game theory, where they are defined as the values of nim heaps. They arise in a much larger class of games because of the Sprague-Grundy theorem. The nimbers are the ordinal numbers endowed with a new nimber addition and nimber multiplication, which are distinct from ordinal addition and ordinal multiplication. Visit the following page for more info on nimber addition and nimber multiplication: \
#link("https://en.wikipedia.org/wiki/Nimber")[*Nimber* - Wikipedia, the free encyclopedia]

We also define Nimber square root such that it returns a number which, when the nimber multiplication applied to itself, returns the original number: \
$s = "Nim_sqrt"(n)$ such that $n = "Nim_prod"(s,s)$.

Similarly Nimber inverse of a number is the one when the nimber multiplication is applied, returns $1$: \
$1 = "Nim_prod"(n,"Nim_inv"(n))$.

Evaluate the following using the above mentioned operations from $n=$ `0x100000` (hex) to `0x110000` (inclusive) and find the sum of the results.
$ sqrt(n/(n+sqrt(n))) $

Answer format: number \
(in decimal)

*[My timing: 6 s]*
]


// Problem #311
#problem-block(number: 311)[
See #link(<p310>)[problem 310] on Nim operations.

Find the $2$ roots of the following equations where Nim operations are used only:

$1881x^2 + 1923x + 1938 = 0 quad "where roots:" x_1 < 2^13 < x_2$ \
$6273x^2 + 2935220086x + 2831770815 = 0 quad "where roots:" x_3 < 2^16 < x_4$ \
$6273x^2 + 12997147727796204837x + 11460394964710426743 = 0 quad "where roots:" x_5 < 2^24 < x_6$

Answer format: $x_1,x_2,x_3,x_4,x_5,x_6$

*[My timing: < 15 s]*
]


// Problem #312
#problem-block(number: 312)[
A rectangular box made of glass has the following dimensions: $1313 times 1547 times 1729$.

It is filled with transparent cubes of side $1$.

A laser beam enters by the lower corner of the box $(0,0,0)$ and leaves by the upper corner $(1313,1547,1729)$.

How many cubes does the beam cross?
]


// Problem #313
#problem-block(number: 313)[
Two equal sized spheres will be placed inside a unit-cube. What will be the maximum possible radius for spheres assuming that they are rigid bodies?

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p313.png")
  #v(5pt)
]

Round answer to $6$ decimal places.

Note: Visualizing it will be helpful.
]


// Problem #314
#problem-block(number: 314)[
In a cube of side $1$ unit, on one face we draw a circle inscribed in that face. On one adjacent face, we draw the circumscribed circle to that face.

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p314.jpg")
  #v(5pt)
]

Find the minimum distance between these $2$ circles.

The answer is an algebric number.

Answer format: the minimal polynomial for this algebric number $dots,a_3,a_2,a_1,a_0$ \
where $P(x) = dots.h.c+a_3 dot x^3 + a_2 dot x_2 + a_1 dot x + a_0$ is the minimal polynomial

Example: `1,-1,-1` \
if the answer would be the golden ratio $phi.alt$.
]


// Problem #315
#problem-block(number: 315)[
We say that an integer $n$ is an Heronian number if it's the area of some #link("https://en.wikipedia.org/wiki/Heronian_triangle")[Heronian triangle].

For instance, the following numbers are Heronian: \
$10080=Delta(1224,1153,73)$ \
$71064=Delta(925,831,188)$

Find the first $2$ Heronian numbers $>123456789$.

Answer format: `n1,n2`

*[My timing: 29 sec]*
]


// Problem #316
#problem-block(number: 316)[
What is $display(sum_(0 < 1+4 times k <= n) 1/(1+4 times k) - log(n)/4 quad "when" n -> infinity)$

Give your answer with $30$ digits after the decimal point.

*[My timing: instant]*

Hint: there is a closed form.
]


// Problem #317
#problem-block(number: 317)[
How many (not necessarily primitive) Heronian triangles with sides $a$, $b$ and $c$, and area in the range $[10000000,10001000]$ are there?

Answer format: $"count",sum a_i,sum b_i,sum c_i$ \
where $a_i <= b_i <= c_i$

Example: `26,203,431,520` in the range $[0,100]$.

*[My timing: < 1 m]*
]


// Problem #318
#problem-block(number: 318)[
Cut the following square through the grid lines into $4$ pieces in such a way that:
- each piece has one black box
- each piece is of similar shape by some rotation

#align(center)[
  #v(5pt)
  #image(width: 150pt, "figures/p318_1.png")
  #v(5pt)
]

Each piece is to be identified as a bitmap. Bits are numbered from $63$ to $0$ starting from top line to bottom.

```
b63 b62 ... b56
b55 b54 ... b48
...
b7  b6  ... b0
```

After the cut, set the cells of a particular piece to $1$ and others to $0$ and get a $64$-bit number as described above.

For example we would have the following numbers (in uppercase hex) for the following:

#align(center)[
  #v(5pt)
  #image(width: 150pt, "figures/p318_2.png")
  #v(5pt)
]

#[
#show regex("10F7FF$"): set text(fill: rgb(255, 0, 0))

```
FFEF080000000000
0010F7FF00000000
00000000FFEF0800
000000000010F7FF
```
]

A cut like this is identified by *the smallest* number. So it would be #text(fill: rgb(255, 0, 0))[`10F7FF`] (leading zeroes are ignored) for the above example.

Answer format: `N1,N2,...` \
(*the smallest* numbers for the appropriate cuts in uppercase hex and in ascending order)
]


// Problem #319
#problem-block(number: 319)[
We define a needle-like primitive triangle as follows:
- It has $3$ vertices on lattice points
- It has no other lattice points inside or onside

Find such a triangle with the maximum possible perimeter in $x^2 + y^2 = R^2$ circle for $R=123456789$.

Answer format: $a^2+b^2+c^2$ \
where $a,b,c$ are the sides of the triangle

Example: `136` if $R=5$ for instance for the triangle with vertices $(-4,-2),(1,1),(4,3)$.

*[My timing: < 40 s]*
]


// Problem #320
#problem-block(number: 320)[
#footnote[Actually #link(<p319>)[Problem 319].]
We define a needle-like primitive *convex* quadrilateral as follows:
- It has $4$ vertices on lattice points
- It has no other lattice points inside or onside

Find such a quadrilateral with the maximum possible perimeter in $x^2 + y^2 = R^2$ circle for $R=10^8$?

Answer format: $x_1,y_1,x_2,y_2$ \
where $|x_i|$ >= $|y_i|$ and $x_1$ < $x_2$ (See the example below)

Example: `3,2,5,3` if $R = 5$.

There are more than one solutions. Enter the two vectors that identify them. For example $A(-4,-3), B(-1,-1), C(4,2), D(1,0)$ is a solution then the two vectors are
$A B=D C=[3,2]$ and $B C=A D=[5,3]$.

Similarly, for $A(-4,-2), B(-1,0), C(4,3), D(1,1)$, $A B=D C=[3,2]$ and $B C=A D=[5,3]$.

*[My timing: 30 s]*
]


// Problem #321
#problem-block(number: 321)[
If for the real $a, b, c, d$ we have: \
$a^2+4b^2=4$ and $c dot d=4$

what the minimum of $(a-c)^2+(b-d)^2$?

Give your answer rounded to $20$ digits after the decimal point.
]


// Problem #322
#problem-block(number: 322)[
if $i^2=-1$, what is the limit
$ L = i^(i^(i^(i^(i^dots.up)))) $

Answer format: $a,b$ \
where $L=a+b i$, $a$ and $b$ rounded to $20$ digits after the decimal point.
]


// Problem #323
#problem-block(number: 323)[
Consider the squares in $x^2 + y^2 = R^2$ circle with vertices on lattice points. The one with the biggest area would be $(R,0), (0,R), (-R,0), (0,-R)$.

Find the ones with the second biggest if $R = 87654321$.

Answer format: $sum x_i,sum y_i,"area"$ \
where $y_i > x_i > 0$ and are $x,y$ coordinates of the one of the vertices.

#[
#show "2,4": set text(fill: rgb(255, 0, 0))
Example: `2,4,40` if $R = 5$.
]

There are $2$ squares with area = $40$: \
$(#text(fill: rgb(255, 0, 0))[$2,4$]), (-4,2), (-2,-4), (4,-2)$ \
$(4,2), (-2,4), (-4,-2), (2,-4)$
]


// Problem #324
#problem-block(number: 324)[
It can easily be seen that there cannot be more than $3$ consecutive integers such as $mu(n_i)=plus.minus 1$, $mu(n)$ being the #link("https://en.wikipedia.org/wiki/M%C3%B6bius_function")[Möbius function].

However, we can find arbitrary long sequences of consecutive integers with a Möbius value of $0$.

Find $9$ consecutive integers $n+1,n+2,dots,n+9$ such as $mu(n+i)=0$ (Each of them is divisible by a distinct prime square, the primes are the smallest possible).

Answer format: `n`

*[My timing: 10 sec]*
]


// Problem #325
#problem-block(number: 325)[
1. Set $R^2 = 2$.
2. Draw $x^2 + y^2 = R^2$ circle.
3. Next find the smallest square with vertices on lattice points such that it inscribes the circle but doesn't touch it.
4. Set $R^2 = a^2 + b^2$ where $a, b$ are the coordinates of the one of any $4$ vertices.
5. Go to step 2.

At the second iteration we would have $x^2 + y^2 = 5$ ($1^2 + 2^2 = 5$).

At the third iteration we would have $x^2 + y^2 = 13$ ($2^2 + 3^2 = 13$).

#align(center)[
  #v(5pt)
  #image("figures/p325.png")
  #v(5pt)
]

What would $R^2$ be equal to at the $50$-th iteration?

Answer format: `Number`

Example: $13$ for the third iteration.

*[My timing: < 1 s]*
]


// Problem #326
#problem-block(number: 326)[
Let $A, B, C$ be the three lattice points inside $x^2 + y^2 = R^2$ circle such that the ratio $(c-a) \/ (a+b+c)$, where $a = |B C|, b = |A C|, c = |A B|$ and $a <= b <= c$ is minimised.

Solve it for $R = 10^9$.

Answer format: $a^2,b^2,c^2$ \
where $gcd(a^2,b^2,c^2) = 1$

Example: `12544,12545,12545` for $R=100$ with $"ratio"=1.328594679505981331113438939 upright(e)-5$, $A(57,6), B(-40,-50), C(-40,62)$.

*[My timing: 200 ms]*
]


// Problem #327
#problem-block(number: 327)[
Poles are disposed on the lattice plane. A rubber band surrounds them.

For instance, consider poles placed at the following points:
- $(1, 1)$
- $(1, 4)$
- $(2, 3)$
- $(3, 5)$
- $(3, 3)$
- $(4, 2)$
- $(5, 1)$
- $(5, 4)$
- $(6, 6)$

If we place a rubber band around these points, we obtain a polygon of area $18$.

#align(center)[
  #v(5pt)
  #image("figures/p327.jpg")
  #v(5pt)
]

Now consider the following $1000$ points:
- $P_1 = (141, 592)$
- $P_2 = (653, 589)$
- $P_3 = (793, 238)$
- $P_4 = (462, 643)$
- $dots$
- $P_999 = (845, 68)$
- $P_1000 = (772, 460)$
The coordinates are made of the digits of the decimal part of PI by group of $3$.

What is the area of the corresponding polygon?

You are given: `830303` for first $100$ points.

*[My timing: < 1 sec]*
]


// Problem #328
#problem-block(number: 328)[
A group of lumberjacks are gathered in a camp.

Each day, in turn, one of the lumberjacks stays in the camp to cook, while the others go to work in $2$ teams.
- The sum of the ages of the $1$st team equals the sum of the ages of the $2$nd team.
- The ages of the lumberjacks are all different and are prime numbers.

What is the smallest possible number of lumberjacks and their ages (First solution in lexicographic order).

Answer format: `a1,a2,...,an` \
in ascending order

*[My timing: 2 sec]*
]


// Problem #329
#problem-block(number: 329)[
A manufacturer has decided to produce an energy potion, to be named as Getafix. They are thinking about choosing a conical shaped can, for Getafix to be distinguishable from other products. Simply, they will cut the top of a regular cone.

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p329.png")
  #v(5pt)
]

So, they seek some advice on how to manufacture this product. Here is the list of requirements:
- They will create $1$ liter beverages.
- The radius of bottom will be twice the top.
- Amount of material used for can will be as least as possible.

They want you to submit optimal height (`h`), bottom radius (`rb`), top radius (`rt`) all in centimeters and rounded to $3$ decimal places.

Answer format: `h,rb,rt`
]


// Problem #330
#problem-block(number: 330)[
Let's define $a thin arrow.t [n] thin a = a underbrace(arrow.t arrow.t dots.h.c arrow.t, n "arrows") a$ where $arrow.t$ represents the #link("https://en.wikipedia.org/wiki/Knuth%27s_up-arrow_notation")[Knuth's arrow notation].

We define:
- $g_0=4$
- $g_1=3 arrow.t thin [g_0] thin 3$
- $dots$
- $g_64=3 arrow.t thin [g_63] thin 3$
$g_64$ is the notorious Graham's number.

The last digits of this humongous number are known: \
$dots.h.c 03222348723967018485186439059104575627262464195387$

We define $G(3)=g_64$ and the generalized Graham's number $G(p)$ where we replace all $3$s with $p$.

What is the smallest prime number $p$ such as G($p$) contains the string '$1415$' in its last $100$ digits.

Answer format: $p$,the last digits starting with '$1415$'

Example: `3,8485186439059104575627262464195387` \
if we ask for the smallest $p$ such as $G(p)$ contains '$8485$'.

*[My timing: 4 sec]*
]


// Problem #331
#problem-block(number: 331)[
Let $x^2 - D dot y^2 = 4$ where $D$ is not a square number and $x, y$ are positive integers.

Find the minimal solution (the one with the smallest positive $x,y$ pair) with *the biggest* odd $y$ value for $D < 1000$.

Answer format: `x^2-D*y^2`

Example: `1523^2-61*195^2` for $D < 100$.

*[My timing: 4 s]*
]


// Problem #332
#problem-block(number: 332)[
Consider the following triple of consecutive integers: $2701, 2702, 2703$.

It's the sides of an #link("https://en.wikipedia.org/wiki/Heronian_triangle")[Heronian triangle].

$triangle.t(2701,2702,2703)=3161340$

Let'call it an Heronian triple.

Find the $100$th Heronian triple.

Answer format: the $1$st element of the triple

You are given: `524173` for the $10$th element.

*[My timing: tiny]*
]


// Problem #333
#problem-block(number: 333)[
Consider the couple of integers $(m,n) = (14, 224)$.

We have:
- $14 = 2^1 times 7^1$
- $224 = 2^5 times 7^1$
- $14+1 = 3^1 times 5^1$
- $224+1 = 3^2 times 5^2$
$n, m$ have the same prime factors ${2,7}$ and so have $n+1, m+1$ ${3,5}$.

Let's call these pairs buddy numbers.

If $(14,224)$ is the $3$rd pair of buddy numbers, what is the $30$th?

*[My timing: < 1 sec]*

Note: Assume there exists only one pair of odd buddy numbers.
]


// Problem #334
#problem-block(number: 334)[
In an *isosceles* triangle $A B C$, we draw the circumscribed circle $C_1$ with center $O_1$ and the inscribed circle $C_2$ with centre $O_2$.

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p334.jpg")
  #v(5pt)
]

If $A B = 520$, $A C = 520$ and $B C = 624$, the distance $O_1 O_2$ is the integer $65$.

How many *isosceles* integer triangles with perimeter $<=10^8$ are there such as the distance $O_1 O_2$ is an integer.

Answer format: the count

Hint: you are given $469$ for a perimeter of $10^4$.

*[My timing: < 90 sec]*
]


// Problem #335
#problem-block(number: 335)[
Given an integer $n$, we apply the following process:
- search the largest proper divisor of $n$
- subtract this number from $n$
- repeat until we reach $1$

Let $f(n)$ the number of steps before reaching $1$.

Example with $n = 30$
- $n = 30 - 15$ ($15 =$ Largest proper divisor of $30$)
- $n = 15 - 5$ ($5 =$ Largest proper divisor of $15$)
- $n = 10 - 5$ ($5 =$ Largest proper divisor of $10$)
- $n = 5 - 1$ ($1 =$ Largest proper divisor of $5$)
- $n = 4 - 2$ ($2 =$ Largest proper divisor of $4$)
- $n = 2 - 1$ ($1 =$ Largest proper divisor of $2$)
- $n = 1$ Stop $=> f(30) = 6$

Find $f(1000000!)$ ($1000000!$ i.e. $"Factorial"(1000000)$).

*[My timing: 6 sec]*
]


// Problem #336
#problem-block(number: 336)[
Let $F(N) = sum N\/"GCD"(N,i) "for" i = 1 "to" N$.

Find $F(12345678!) mod 10000004400000259$.

You are given $F(100!) mod 1000003 = 571693$.

*[My timing: < 1 s]*
]


// Problem #337
#problem-block(number: 337)[
You certainly know of this nice proof of the equipotence between the set of integers and the set of rational numbers.

We consider an infinite grid numbered horizontally and vertically with integers:

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p337.jpg")
  #v(5pt)
]

We run through this grid according the above pattern and count each pair $(i,j)$ where $i$ and $j$ are coprime.

#par(leading: 11pt)[
$1$ - $1/1=1$ \
$2$ - $1/2$ \
$3$ - $2/1=2$ \
$4$ - $3/1=3$ \
$5$ - $1/3$ \
$6$ - $1/4$ \
$7$ - $2/3$ \
$8$ - $3/2$ \
$9$ - $4/3$ \
$10$ - $5/1=5$ \
$11$ - $1/5$ \
$12$ - $1/6$ \
$13$ - $2/5$ \
$14$ - $3/4$ \
$15$ - $4/1=4$ \
$16$ - $5/2$ \
$17$ - $6/1=6$
]

If we run through the upper diagonal matrix of a $6 times 6$ grid, we get $17$ rationals.

How many rationals can we count in the upper diagonal matrix of a $10^9 times 10^9$ grid?

You are given: `303964542391` for a $10^6 times 10^6$ grid.

*[My timing: < 90 sec]*
]


// Problem #338
#problem-block(number: 338)[
Among the divisors of $400$, exactly $6$ are perfect squares:
- $1, 4, 16, 25, 100, 400$

How many divisors of $10^9 !$ are perfect squares?

Answer format: the *20* last digits of this huge number before the trailing $0$s

You are given: `54158086206534975488` for $1000$!.

*[My timing: 20 sec]*

Beware of leading zeros
]


// Problem #339
#problem-block(number: 339)[
The multiplicative order $o(g,p)$ of a number $g$ modulo $p$, ($g$ and $p$ coprime), is the smallest integer $k$ such as $g^k=1 "modulo" p$.

For instance, $o(10,73)=8$.

For how many prime numbers $p < 4 times 10^8$ the multiplicative order $o(10,p)<100$?

Answer format: `count,sum`

Example: `55,11573` for a limit of $1000$.

*[My timing: 70 sec]*
]


// Problem #340
#problem-block(number: 340)[
A number for which every pair of consecutive digits has a difference of one is called a step number. For example $234321$ is a step number.

A pandigital number in a base $B$ contains every digit from $0$ to $B-1$ at least once.

Let $F(B,italic("ND"))$ denote the number of pandigital step numbers in base $B$ *with _ND_ or less digits*.

You are given: \
$F(7, 100) mod 10^20 = 1717291099033442979$ \
$F(10, 1000) mod 10^20 = 45956531342004698861$

What is $F(19, 1919^19) mod 10^20$?

*[My timing: < 10 s]*
]


// Problem #341
#problem-block(number: 341)[
Find the digits in the following  multiplication:

```
      * * * * * * * * * * * *
                        * * *
      -----------------------
    * * * * * * * * * * * * *
  * * * * * * * * * * * * *
* * * * * * * * * * * * *
-----------------------------
* * * * * * * * * * * * * * *
```

Each star represents a prime number. There is only one solution.

Answer format: `999999999999*999=999999999999999`

*[My timing: < 1 m]*
]


// Problem #342
#problem-block(number: 342)[
How many different values can the expression $1 plus.minus 2 plus.minus 3 plus.minus  dots.h.c plus.minus n$ take?

Give your answer for $n=1000000$.

*[My timing: instant]*
]


// Problem #343
#problem-block(number: 343)[
We define $"DS"(n)=n+"SOD"(n)$ where $"SOD"(n)$ is the sum of the digits of $n$ (See #link(<p263>)[problem 263]).

It can be proved that $10^13+1$ is the smallest integer such as the equation $"DS"(x)=n$ has $3$ solutions:
$
10^13+1 = cases(
		"DS"(9999999999892),
		"DS"(9999999999901),
		"DS"(10000000000000)
)
$

It can be proved too that $n=10^2222222222224+10000000000002$ is the smallest integer with $6$ solutions.

Obviously, if x is a solution we must have $x<n$. Thus, we can write a solution as $n-x_i$.

Find these solutions.

Answer format: `x1,x2,x3,x4,x5,x6` \
$x_i$ in ascending order

Example: `1,100,109` for $10^13+1$.


*[My timing: < 1 sec]*

Thanks to *sinan* who helped me to improve this problem.
]


// Problem #344
#problem-block(number: 344)[
Using four numbers $4$ and the $4$ operations $+$, $-$, $*$, $\/$ we can build all numbers up to $9$.
- $1 = ((4 + 4) - 4) \/ 4$
- $2 = (4 \/ (4 + 4)) * 4$
- $3 = ((4 + 4) + 4) \/ 4$
- $4 = ((4 - 4) * 4) + 4$
- $5 = ((4 * 4) + 4) \/ 4$
- $6 = ((4 + 4) \/ 4) + 4$
- $7 = (4 - (4 \/ 4)) + 4$
- $8 = ((4 + 4) + 4) - 4$
- $9 = ((4 \/ 4) + 4) + 4$
- $12 = (4 - (4 \/ 4)) * 4$
$=>$ $10$ is the first not reachable.

With four numbers $5$
- $1 = ((5 + 5) - 5) \/ 5$
- $2 = (5 \/ 5) + (5 \/ 5)$
- $3 = ((5 + 5) + 5) \/ 5$
- $4 = ((5 * 5) - 5) \/ 5$
- $5 = ((5 - 5) * 5) + 5$
- $6 = ((5 * 5) + 5) \/ 5$
- $7 = ((5 + 5) \/ 5) + 5$
- $9 = (5 - (5 \/ 5)) + 5$
$=>$ $8$ is the first not reachable.

What are the first unreachable numbers when we use eight $4$ and eight $5$?

Answer format: `u4,u5`

Example: `10,8`

*[My timing: 40 sec]*
]


// Problem #345
#problem-block(number: 345)[
There is a smallest $n$ for which there exists a set of distinct integers $S={s_1,s_2,dots,s_n}$ such as \
$17/670 = (1-1/s_1) times (1-1/s_2) times dots.h.c times (1-1/s_n)$

Actually, for this least $n$ the set $S$ is unique.

You are given that $S$ is composed of the union of no more than $4$ subsets of consecutive integers.

Find $S$.

Answer format: 'the smallest element'-'the largest element' comma separated for each subset

For instance, if $S={2,3,4,5,11,12,13}={2,3,4,5}union{11,12,13}$, the answer would be: `2-5,11-13`.

*[My timing: 2 sec]*
]


// Problem #346
#problem-block(number: 346)[
Find the smallest integer with $720$ divisors and the longest sequence of consecutive divisors.

#let seq = $1,2,3,4,5,6$
For instance, for $24$ divisors, the answer is $360=underbrace(#seq),8,dots$

Answer format: `number,first divisor of the sequence,last divisor of the sequence`

Example: `360,1,6`

*[My timing: 8 sec]*
]


// Problem #347
#problem-block(number: 347)[
#link("https://en.wikipedia.org/wiki/Huffman_coding")[Huffman Coding] is a lossless data compression method that is based on the entropy of bit patterns in the data.

Usually for strings, conventional $8$-bit ($0$-$255$) hashing is used for frequencies preceding actual coding. So, these $8$-bit chunks directly correspond to well-know characters (such as a, b, c, etc., more specifically ASCII encoding). So, for this problem assume ASCII encoding for characters.

This problem asks to use Huffman coding scheme on this #link("https://rosecode.neocities.org/uploads/lip.txt")[text file], but using $9$-bit chunks for frequencies and then actual coding. Also, for this problem you do not need to account for additional information to ensure decompression.

File is currently $68337$ bytes. Submit the compressed file size below in bytes (where file *does not* include any information for decompression).
]


// Problem #348
#problem-block(number: 348)[
Consider the field $bb(F)_d$ of numbers $a+b times sqrt(-d)$ where $a,b,d$ are integers and $d$ is a squarefree positive number.

For some $d$, it can be proved that the factorization of the elements of $bb(F)_d$ is unique.

The surprising fact about these special values is that there are only $9$ of them: \
${1,2,3,7,11,19,43,67,163}$

They are called the #link("https://en.wikipedia.org/wiki/Heegner_number")[Heegner numbers].

Can you find the smallest prime number $p>10^50$ such as $p$ can be written $p=x^2+h dot y^2$ for each Heegner number $h$.

Answer format: $p mod 10^50,sum x,sum y$

Example: `2372241,606424,233349` for $p>10^10$
$
10002372241 &= 23220^2 + 1 times 97279^2 \
10002372241 &= 90979^2 + 2 times 29370^2 \
10002372241 &= 79729^2 + 3 times 34860^2 \
10002372241 &= 95703^2 + 7 times 10976^2 \
10002372241 &= 82865^2 + 11 times 16884^2 \
10002372241 &= 52279^2 + 19 times 19560^2 \
10002372241 &= 90313^2 + 43 times 6552^2 \
10002372241 &= 44273^2 + 67 times 10956^2 \
10002372241 &= 47063^2 + 163 times 6912^2
$

For the equation $x^2+y^2=p$, we assume $x<y$.

*[My timing: < 15 sec]*
]


// Problem #349
#problem-block(number: 349)[
It can be proved that a prime number of form $5n+1$ has a unique representation by the binary quadratic form $x^2+3 x y+y^2$.

For instance $10000000711=14365^2+3 times 14365 times 79734+79734^2$.

Find this representation for the first $100$ prime numbers $equiv 1 "modulo" 5$ and $>10^50$.

Answer format: $sum x,sum y$ \
where $x<y$

*[My timing: 7 sec]*
]


// Problem #350
#problem-block(number: 350)[
Consider the number $420$.

It can be decomposed in product of $2$ squarefree factors in $4$ different ways: \
$2 times 210$ \
$6 times 70$ \
$10 times 42$ \
$14 times 30$

Let $d(n)=$ number of pairs $(x,y)$ such as $x,y$ squarefree, $x dot y=n$ and $x<=y$.

Find $sum_(k=1)^20000000 d(k)$.

*[My timing: 45 sec]*
]


// Problem #351
#problem-block(number: 351)[
Given a positive integer, we multiply all its digits; we obtain a new number. We repeat the process until a fixed point.

Example: \
Starting with $n=277777788888899$, we have the following sequence: \
$277777788888899 => 4996238671872 => 438939648 => 4478976 => 338688 => 27648 => 2688 => 768 => 336 => 54 => 20 => 0$ \
In this case, we have a chain of length $11$.

This value is called the multiplicative persistence of $n$ \
$P(277777788888899)=11$

$277777788888899$ is actually the smallest integer with a multiplicative persistence of $11$.

There are $5$ $15$-digits numbers with a multiplicative persistenceof $11$: \
$277777788888899$ \
$367777778888889$ \
$447777778888899$ \
$466777777888889$ \
$666677777788888$

We only consider number in their canonical representation: digits in ascending order (as any permutation of a given number has the same multiplicative persistence as the original).

#block(fill: ColorSecondary.lighten(85%), inset: 5pt)[
It's an open problem to prove or disprove that no integer has a multiplicative persistence greater than $11$. This conjecture has been checked until $10^500$.
]

How many $25$-digits numbers with a multiplicative persistence of $11$ are there?

Answer format: `count,sum`

Example: `5,2226788902344464` for $15$-digits numbers.

*[My timing: 60 sec]*
]


// Problem #352
#problem-block(number: 352)[
A $n$-digits #link("https://en.wikipedia.org/wiki/Kaprekar_number")[Kaprekar number], in base $10$, is an integer such as its square can be split in $2$ parts that add up to this number.

For instance:
$
324324324324^2 = underbrace(105186267348) thin underbrace(219138056976) \
"and" 105186267348+219138056976 = 324324324324
$

We say that a string $S$ is periodic if there is a substring $T$ of $S$ such as $S=T dots.h.c T$ where the number of repetitions of $T$ is $>=2$.

How many $68$-digits periodic Kaprekar numbers are there?

Answer format: `count,sum`

Example: `8,41153193346` \
for $10$-digits Kaprekar numbers $(1111111111,2020202020,3888938889,4132841328,5000050000,$$5243952439,9756097560,9999999999)$

*[My timing: < 1 sec]*
]


// Problem #353
#problem-block(number: 353)[
Euler found that $635318657=59^4+158^4=133^4+134^4$.

And it was proved in 2004 that it's actually the smallest integer that can be expressed in two different ways as a sum of two $4$th powers.

What is the smallest integer that can be written in $2$ different ways as a sum of a $4$th and a $5$th power? $n=a_1^4+b_1^5=a_2^4+b_2^5$ where $a_i$ and $b_i$ are not perfect powers.

Answer format: $n,a_1,b_1,a_2,b_2$ \
with $a_1<a_2$.

*[My timing: 45 sec]*
]


// Problem #354
#problem-block(number: 354)[
Let the following pseudo-random generator:

```c
static long seed = 641;
static long FastRandom()
{
	  seed = (214013 * seed + 2531011) % 2147483647;
	  return seed;
}
```

We consider the first $60000$ values of this generator modulo $1000$ as the coordinates of $10000$ triangles: \
$T_1=(344,302)(678,941)(488,674)$ \
$T_2=(107,545)(964,568)(808,239)$ \
$dots$ \
$T_10000=(862,679)(571,263)(391,426)$

How many times is the point $(499,499)$ inside one of these triangles?

*[My timing: < 1 sec]*
]


// Problem #355
#problem-block(number: 355)[
Let
$ xi = root(16, 4870847 - 1/(4870847 - 1/(4870847 - 1/(4870847 - dots.h.c)))) $

$xi$ can be written $(a+sqrt(b))/c$ for some coprime integers $a,b,c$.

Can you find them?

Answer format: `a,b,c`
]


// Problem #356
#problem-block(number: 356)[
Consider the #link("https://en.wikipedia.org/wiki/Gaussian_integer")[Gaussian integer] $gamma = 14159 + 71828 i$.

$gamma = (0+i)times(1+2i)times(2+3i)times(5-8i)times(283-920i)$ \
Each factor is a Gaussian prime number.

Can you find the Gaussian factorization of \
$1415926535897932384626433+7182818284590452353602874i$.

Answer format: $a_1,b_1\/a_2,b_2\/dots\/a_n,b_n$ \
where $a_i>=0$ and $a_i$ in ascending order. To normalize the factors, we must have $|a_i|<|b_i|$.

Example: `0,1/1,2/2,3/5,-8/283,-920` for $gamma$.

*[My timing: instant]*
]


// Problem #357
#problem-block(number: 357)[
Since Euler, we know that Diophantine equation $x^3+y^3=z^3$ has no solution.

However, Ramanujan found an infinite set of solutions for equation $x^3+y^3=z^3 plus.minus 1$.

Here is his stunning solution. Let: \
$X_1=[9,10,12]$ \
$X_2=[791,812,1010]$ \
$X_3=[65601,67402,83802]$

And define $X_(n+3) = 82 dot X_(n+2) + 82 dot X_(n+1) - X_n$.

Let $x_n=X_n [1],y_n=X_n [2],z_n=X_n [3]$.

We have $x_n^3 + y_n^3 = z_n^3 + (-1)^(n+1)$.

For instance, $X_4=[5444135,5593538,6954572]$ and indeed $5444135^3+5593538^3=6954572^3-1$.

Find solution for index $123456789101112$.

Format answer: $x,y,z "modulo" 10^15$

*[My timing: instant]*
]


// Problem #358
#problem-block(number: 358)[
10000 people attend a programming contest. The contest has $4$ problems. The contestants who pass at least two out of four problems will be awarded.

Here are the statistics: \
Problem 1: $5101$ people pass \
Problem 2: $4499$ people pass \
Problem 3: $1312$ people pass \
Problem 4: $148$ people pass

Participation fee is $20$. Those who pass two problems out of four are awarded with $30$, those who pass three with $50$ and those who pass all four with $100$. The cost of organising this contest is $1000$.

What is the minimum (`X`) and maximum (`Y`) profit that may be earned from this contest?

Answer format: `X,Y`

Thanks to *Philippe* for his helps in developing this problem.
]


// Problem #359
#problem-block(number: 359)[
There are two squares with sides equal to $a$ and $b$ as seen below. The sides $a, b$ and the area of the painted triangle are equal to integers. What is the smallest possible area if $sqrt(23) < b\/a < sqrt(24)$?

#align(center)[
  #v(5pt)
  #image("figures/p359.png")
  #v(5pt)
]

Answer format: `a,b,area`

*[My timing: 5 s]*
]


// Problem #360
#problem-block(number: 360)[
```
A <=> QQAA
Z <=> WgAA
```

Can you decode this?

```
VGgA ZWEA bnMA d2UA cmkA c2IA YXMA ZTYA NAAA
```
]


// Problem #361
#problem-block(number: 361)[
Let $f(x) = x^3 + a dot x^2 + b dot x + 18811938$ where $a$ and $b$ are integers.

If $a, b$ can be selected in such a way that $f(x) = 0$ has only integer roots, what is the sum of $f(-1)$ for all the possibilities (i.e. all the distinct polynomials that meet the conditions).

Answer format: sum of $f_(a,b)(-1)$ for $a$ and $b$ that makes $f_(a,b)(x) = 0$
]


// Problem #362
#problem-block(number: 362)[
An equilateral triangle contains a point in its interior whose distances to the vertices are $3,4,5$.

What is the side of the triangle?

Give the answer rounded to $10$ digits after the decimal part.
]


// Problem #363
#problem-block(number: 363)[
$20!$ possesses $41040$ divisors.

Its largest divisor $<10^10$ is $9999498600$.

Find the largest divisor of $75!$ which is $<10^30$.

*[My timing: < 40 sec]*
]


// Problem #364
#problem-block(number: 364)[
Find integers $n_1,n_2$ such as:
- $n_1 dot n_2=75!$
- $n_1<n_2$
- $n_2-n_1$ is the smallest possible

Answer format: $n_2-n_1$

*[My timing: < 50 sec]*
]


// Problem #365
#problem-block(number: 365)[
The equation $1/x+1/y=1/n$ with $0<x<=y$ has $14$ solutions for $n=12345$:
#par(leading: 11pt)[
- $1/12346+1/152411370=1/12345$
- $1/12348+1/50812020=1/12345$
- $1/12350+1/30492150=1/12345$
- $1/12354+1/16945570=1/12345$
- $1/12360+1/10172280=1/12345$
- $1/12370+1/6108306=1/12345$
- $1/12390+1/3398990=1/12345$
- $1/12420+1/2044332=1/12345$
- $1/12570+1/689674=1/12345$
- $1/13168+1/197520=1/12345$
- $1/14814+1/74070=1/12345$
- $1/16460+1/49380=1/12345$
- $1/19752+1/32920=1/12345$
- $1/24690+1/24690=1/12345$
]

How many solutions are there for $n=2091129587$?

Answer format: $"count",sum x,sum y$

Example: `14,200392,273453272` for $n = 12345$.

*[My timing: 12 sec]*
]


// Problem #366
#problem-block(number: 366)[
The equation $x dot y+y dot z+z dot x=n$ with $0<x<=y<=z$ has $11$ solutions for $n=1234$:
- $1 times 4+4 times 246+246 times 1=1234$
- $1 times 12+12 times 94+94 times 1=1234$
- $1 times 18+18 times 64+64 times 1=1234$
- $3 times 8+8 times 110+110 times 3=1234$
- $4 times 6+6 times 121+121 times 4=1234$
- $4 times 21+21 times 46+46 times 4=1234$
- $8 times 14+14 times 51+51 times 8=1234$
- $10 times 13+13 times 48+48 times 10=1234$
- $10 times 19+19 times 36+36 times 10=1234$
- $12 times 14+14 times 41+41 times 12=1234$
- $18 times 20+20 times 23+23 times 18=1234$

How many solutions are there for $n=3000000$?

Answer format: $"count", sum x, sum y, sum z$

Example: `11,72,149,880` for $n = 1234$.

*[My timing: 65 sec]*
]


// Problem #367
#problem-block(number: 367)[
Let the diophantine equation $1/x+1/y=1/n$ with $x<=y$.

How many solutions are there for $n=1000000!$?

As the answer is a BIG number, use the following condensed representation: \
`(First 10 digits)[(number of remaining digits)](Last 10 digits)`

Example: `8583170787[2]5400804688` for $n=100!$.

*[My timing: < 1 sec]*
]


// Problem #368
#problem-block(number: 368)[
Let $p_i$ be the $i$-th prime.

Let $P(n)$ be the canonical product of the first $n$ primes this way: \
$product p_i^i "for" i=1 "to" n$.

Let $\#f(n)$ be the number of *unique* reduced fractions (of the form $p\/q$) $> 1$ that can be constructed using the divisors of $P(n)$.

For example $\#f(2) = 2$ because \
$P(2) = 2^1 times 3^2 = 18$ \
The $2$ fractions are $3\/2$ and $9\/2$.

What is $\#f(10^10)$?

Answer format: rightmost $20$ digits

*[My timing: < 1 s]*
]


// Problem #369
#problem-block(number: 369)[
$n$ runners are on a circular track of length $1$.

At $t$ = 0, they are all in the same position and start to run in the same direction.

A runner $R_i$ is said *lonely* at time $t$ if he is at a distance of at least $1\/n$ of every other runners.

There are $10$ runners with the following speed: $13,163,353,389,487,491,563,797,857,881$. A speed $V_i$ means that the runner $R_i$ completes the track in $V_i$ unit of time.

At which time all runners have been lonely at least once? (The time $t$ is discrete and should always be an integer)
]


// Problem #370
#problem-block(number: 370)[
Given two sequences of nucleic acid, we try to align them the best way possible. We can insert any number of gaps in both sequences.

We use the following rules:
- if at a given position the acids are the same, we count $+2$
- if at a given position the acids are different, we count $-1$
- if there is a gap in one string, we count $-2$

For example, consider the two following sequences:
- `GAATTCAGTTA`
- `GGATCGA`

The best possible alignment (the one with the greater score) is: \
`GAATTCAGTTA` \
`GGA-TC-G--A`

which gives a score of $3$ \
- `G G` : $+2$
- `A G` : $-1$
- `A A` : $+2$
- `T -` : $-2$
- `T T` : $+2$
- `C C` : $+2$
- `A -` : $-2$
- `G G` : $+2$
- `T -` : $-2$
- `T -` : $-2$
- `A A` : $+2$

You are given the 2 following sequences:

```
'GTAATAGACTCGGAAACGCAACCGTCAGCAAAACGCGTTCGGTCGATCGT
AATATGTAAGATCCAATTAGGGCGACCTCTTGTGCGGTCAGTAGGAGTCT'

'ATAACTCTGAATCCCCCGACGTGTCGTGATGGGCGACGGACGGCACCCTT
AACGTGATCCTGAACTCCCGTGGGGACCGTTGTCGGTAATGCAGGGTGTG'
```

What is the score for the best alignment and the number of acids identical in both aligned sequences?

Answer format: comma separated

Example: `3,6` for the sequences `GAATTCAGTTA` and `GGATCGA`.

*[My timing: < 1 sec]*
]


// Problem #371
#problem-block(number: 371)[
In the movie #link("http://www.imdb.com/title/tt0112864/?ref_=fn_tt_tt_1")[Die Hard 3], Officer John McLane has to stop a bomb to explode by using a conterweight of $4$ gallons.

For this, he can only use $2$ jugs of $5$ and $3$ gallons. He can do it in $6$ moves:

```c
[5] [0] // Pour 5 gallons in the 1st jug
[2] [3] // Fill the 2nd jug with the 1st
[2] [0] // Empty the 2nd jug
[0] [2] // Pour the 2 gallons from the 1st jug to the 2nd
[5] [2] // Pour 5 gallons the 1st jug
[4] [3] // Fill the 2nd jug with the 1st => We are done: 4 gallons remain in the 1st jug
```

- How many moves ($M_1$) would Officer McLane need to weight $641$ gallons with $2$ jugs of $19937$ and $23209$ gallons?
- Which capacity ($C_2$) between $1$ and $19936$ requieres the largest number of moves ($M_2$)?

Answer format: $M_1,C_2,M_2$

*[My timing: 4 sec]*
]


// Problem #372
#problem-block(number: 372)[
See the #link(<p371>)[problem 371] by *Philippe*. This time we have $3$ jugs with capacities $7$, $31$ and $1048575$. What are the gallons that require the most number of moves?

Answer format: $"moves",g_1,g_2,dots$ \
where $g_(i-1) < g_i$

Example: `20,54,57,58,62,66,67,70` if we have $3$, $7$ and $127$ gallon jugs.

*[My timing < 1 m and my memory requirement < 100 M]*
]


// Problem #373
#problem-block(number: 373)[
There is a special kind of #link("http://en.wikipedia.org/wiki/Turing_machine")[Turing machines] called the *Busy Beavers*.

A Busy Beaver is a machine defined for $P$ symbols and $Q$ states. Its purpose is to write as many symbols as possible on the tape.

Let's take an example with a $2$ symbols and $2$ states Busy Beaver.

It is described by a $P times Q$ matrix.

```
 Symbol |      State-1    |      State-2
        | Write Move Next | Write Move Next
--------------------------------------------
  0     |  1     R    2   |  1     L    1
  1     |  1     L    2   |  1     R    0
```

Each row corresponds to a symbol read on the tape. Each column corresponds to a state and contains a triple:
- Which symbol to write on the tape
- In which direction to move (Left or Right) on the tape
- Next state (State $0$ means the Beaver halts)

Example: if we read a '$0$' on the tape, and we are is state $2$, we write a '$1$' on the tape, the the Left and go to state $1$.

We always starts with an empty tape (filled with '$0$'), and in state $1$.

If we run this Busy Beaver, we get the following execution trace:

```
Step Curr Tape            Move Write Next
 0   1    00000{0}000000  R    1     2
 1   2    000001{0}00000  L    1     1
 2   1    00000{1}100000  L    1     2
 3   2    0000{0}1100000  L    1     1
 4   1    000{0}11100000  R    1     2
 5   2    0001{1}1100000  R    1     0
```

The beaver stops after $6$ steps and in the end the tape contains $4$ '$1$'.

This is actually the "best" $2 times 2$ Busy Beaver (the one which writes the more '$1$' on a tape).

Let's take a $2 times 6$ Busy Beaver, defined with the following matrix:

#[
#set text(size: 9pt)

```
Symb |     State-1   |     State-2   |   State-3     |   State-4     |   State-5     |   State-6
     |Write Move Next|Write Move Next|Write Move Next|Write Move Next|Write Move Next|Write Move Next
------------------------------------------------------------------------------------------------------
 0   |   1   L     2 |  1    R     3 |  0    R     6 |  1    L     1 |  0    L     1 |  1    L     5
 1   |   1   L     1 |  1    R     2 |  1    R     4 |  0    R     5 |  1    R     3 |  1    L     0
```
]

You can verify that this beaver halts after $13 thin 122 thin 572 thin 797$ steps (took me $400$ sec).

How many steps does it need to write $100000$ '$1$'.

You are given:
- $3726$ steps for $100$ '$1$'
- $315587$ steps for $1000$ '$1$'

*[My timing: 84 sec]*
]


// Problem #374
#problem-block(number: 374)[
Professor Beklemishev defines a worm as follow:

We start with a list of non-negative integers $W_1=[w_0,w_1,dots,w_n]$ at step $m=1$.

At step $m$
- If $w_n=0$, then $W_m=[w_0,w_1,dots,w_(n-1)]$ (We chop its head)
- Otherwise, let $k = "argmax"_(i<n) (w_i<w_n)$

If $k$ exists let $G=[w_0,dots,w_k],B=[w_(k+1),dots,w_(n-1)]$. \
If k does not exist let $G=[]$ (an empty list), $B=[w_0,dots,w_(n-1)]$. \
Then $W_m=G+B+dots.h.c+B$ ($m+1$) copies of $B$.

Here is the evolution of the worm [1,1] \
$1$ - $[1,1]$ \
$2$ - $[1,0,1,0,1,0]$ \
$3$ - $[1,0,1,0,1]$ \
$4$ - $[1,0,1,0,0,0,0,0,0]$ \
$5$ - $[1,0,1,0,0,0,0,0]$ \
$6$ - $[1,0,1,0,0,0,0]$ \
$7$ - $[1,0,1,0,0,0]$ \
$8$ - $[1,0,1,0,0]$ \
$9$ - $[1,0,1,0]$ \
$10$ - $[1,0,1]$ \
$11$ - $[1,0,0,0,0,0,0,0,0,0,0,0,0,0]$ \
$dots$ \
$24$ - $[1]$ \
$25$ - $[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]$ \
$dots$ \
$50$ - $[0]$ \
$51$ - $[]$

He proved that every worm evolves eventually to an empty list. This cannot be proved in Peano. The number of steps to reach an empty list is not calculable.

At which step does the worm $W_1=[1,1,1]$ turns into $[1,1]$? (It's a VERY VERY LARGE number)

*[My timing: < 1 sec]*
]


// Problem #375
#problem-block(number: 375)[
An hydra is a rooted tree.

Hercules' task is to slay the hydra by choping all its heads. But the hydra's heads grow again with the following rules. At the step $n$:
- if Hercules cuts a head growing from the root, the hydra doesn't grow any head.
- if Hercules cuts a head attached to a given node, this head is deleted.

The node at which the head was attached is copied $n$ times on the node just below.

#align(center)[
  #v(5pt)
  #image(width: 400pt, "figures/p375_1.jpg")
  #v(5pt)
]

Here is the evolution of a small hydra:

#align(center)[
  #v(5pt)
  #image(width: 400pt, "figures/p375_2.png")
  #image(width: 400pt, "figures/p375_3.png")
  #v(5pt)
]

We define the size of an hydra as the number of its heads and nodes. The hydra in the above picture as a size of $4$ at step $1$.

We can represent an hydra as a string as follow:
- `n` A leaf
- `n(..)` A node, inside the parenthesis its children

For instance, in the above picture the first $3$ hydras are: \
`n(n(nn))` \
`n(n(n)n(n))` \
`n(nnnn(n))`

We always cut the left most heads.

If we consider all the hydras of size $5$, after $100$ steps, the maximum sizes reached are the following:
- `n(n(n(n(n))))` - $5686$
- `n(n(n(nn)))` - $341$
- `n(n(n(n)n))` - $288$
- `n(n(n(n))n)` - $21$
- `n(n(nn(n)))` - $70$
- `n(n(nnn))` - $156$
- `n(n(nn)n)` - $9$
- `n(n(n)n(n))` - $6$
- `n(n(n)nn)` - $5$
- `n(nn(n(n)))` - $67$
- `n(nn(nn))` - $20$
- `n(nn(n)n)` - $5$
- `n(nnn(n))` - $5$
- `n(nnnn)` - $4$
(The initial size before steps is not counted)

The $5$ largest sizes are (in descending order): $5686,341,288,156,70$.

What are the $5$ largest sizes reached among all the $6$-size hydras after $100$ steps?

Answer format: comma delimited list in descending order

*[My timing: 55 sec]*

#link("http://math.andrej.com/2008/02/02/the-hydra-game/")[Credit to Andrej Bauer for the images]
]


// Problem #376
#problem-block(number: 376)[
Consider *integer sided* Pythagorean triangles with their hypotenus and shorter leg equal to *twin primes* (#link(<note376>)[\*]). Using four of such triangles and a rectangle with sides also equal to *twin primes* (#link(<note376>)[\*]), we draw a parallelogram as seen below.

#align(center)[
  #v(5pt)
  #image("figures/p376.png")
  #v(5pt)
]

Find such parallelograms with their area less than $10^19$?

Answer format: count,sum_of_areas $mod 264$

Example: `1,169` (for area < $10^3$).

*[My timing: < 1 m]*

#text(fill: ColorSecondary)[\*]<note376> Note that *twin primes* here does NOT mean a pair of primes with a difference of 2, rather any twin primes pair where a twin prime means *a prime number that is either 2 less or 2 more than another prime number*. For example for the triple $(5,12,13)$, we have $5$ and $13$ which are two twin primes.
]


// Problem #377
#problem-block(number: 377)[
Consider the number $100020$. If you change one of its digits, you never get a prime number:

$bold(1)00020 = 2^2 times 3 times 5 times 1667$ \
$bold(2)00020 = 2^2 times 5 times 73 times 137$ \
$bold(3)00020 = 2^2 times 5 times 7 times 2143$ \
$bold(4)00020 = 2^2 times 3 times 5 times 59 times 113$ \
$bold(5)00020 = 2^2 times 5 times 23 times 1087$ \
$bold(6)00020 = 2^2 times 5 times 19 times 1579$ \
$bold(7)00020 = 2^2 times 3^2 times 5 times 3889$ \
$bold(8)00020 = 2^2 times 5 times 13 times 17 times 181$ \
$bold(9)00020 = 2^2 times 5 times 11 times 4091$

$1bold(0)0020 = 2^2 times 3 times 5 times 1667$ \
$1bold(1)0020 = 2^2 times 5 times 5501$ \
$1bold(2)0020 = 2^2 times 5 times 17 times 353$ \
$1bold(3)0020 = 2^2 times 3 times 5 times 11 times 197$ \
$1bold(4)0020 = 2^2 times 5 times 7001$ \
$1bold(5)0020 = 2^2 times 5 times 13 times 577$ \
$1bold(6)0020 = 2^2 times 3^2 times 5 times 7 times 127$ \
$1bold(7)0020 = 2^2 times 5 times 8501$ \
$1bold(8)0020 = 2^2 times 5 times 9001$ \
$1bold(9)0020 = 2^2 times 3 times 5 times 3167$

$10bold(0)020 = 2^2 times 3 times 5 times 1667$ \
$10bold(1)020 = 2^2 times 5 times 5051$ \
$10bold(2)020 = 2^2 times 5 times 5101$ \
$10bold(3)020 = 2^2 times 3 times 5 times 17 times 101$ \
$10bold(4)020 = 2^2 times 5 times 7 times 743$ \
$10bold(5)020 = 2^2 times 5 times 59 times 89$ \
$10bold(6)020 = 2^2 times 3^2 times 5 times 19 times 31$ \
$10bold(7)020 = 2^2 times 5 times 5351$ \
$10bold(8)020 = 2^2 times 5 times 11 times 491$ \
$10bold(9)020 = 2^2 times 3 times 5 times 23 times 79$

$100bold(0)20 = 2^2 times 3 times 5 times 1667$ \
$100bold(1)20 = 2^3 times 5 times 2503$ \
$100bold(2)20 = 2^2 times 5 times 5011$ \
$100bold(3)20 = 2^5 times 3 times 5 times 11 times 19$ \
$100bold(4)20 = 2^2 times 5 times 5021$ \
$100bold(5)20 = 2^3 times 5 times 7 times 359$ \
$100bold(6)20 = 2^2 times 3^2 times 5 times 13 times 43$ \
$100bold(7)20 = 2^4 times 5 times 1259$ \
$100bold(8)20 = 2^2 times 5 times 71^2$ \
$100bold(9)20 = 2^3 times 3 times 5 times 29^2$

$1000bold(0)0 = 2^5 times 5^5$ \
$1000bold(1)0 = 2 times 5 times 73 times 137$ \
$1000bold(2)0 = 2^2 times 3 times 5 times 1667$ \
$1000bold(3)0 = 2 times 5 times 7 times 1429$ \
$1000bold(4)0 = 2^3 times 5 times 41 times 61$ \
$1000bold(5)0 = 2 times 3 times 5^2 times 23 times 29$ \
$1000bold(6)0 = 2^2 times 5 times 5003$ \
$1000bold(7)0 = 2 times 5 times 10007$ \
$1000bold(8)0 = 2^4 times 3^2 times 5 times 139$ \
$1000bold(9)0 = 2 times 5 times 10009$

$10002bold(0) = 2^2 times 3 times 5 times 1667$ \
$10002bold(1) = 29 times 3449$ \
$10002bold(2) = 2 times 13 times 3847$ \
$10002bold(3) = 3 times 7 times 11 times 433$ \
$10002bold(4) = 2^3 times 12503$ \
$10002bold(5) = 5^2 times 4001$ \
$10002bold(6) = 2 times 3^2 times 5557$ \
$10002bold(7) = 23 times 4349$ \
$10002bold(8) = 2^2 times 17 times 1471$ \
$10002bold(9) = 3 times 33343$

What is the smallest #link("https://en.wikipedia.org/wiki/Pandigital_number")[pandigital number] (in base $10$) with that property? #link(<note377>)[\*]

#text(fill: ColorSecondary)[\*]<note377> All the numbers you get when changing one digit must be pandigital too.

*[My timing: < 1 sec]*
]


// Problem #378
#problem-block(number: 378)[
See the #link(<p374>)[problem 374] by *Philippe*. We slightly modify the evolution code in that it creates $m$ copies instead of ($m+1$) at $m$-th step. So the evolution of $[1,1]$ now becomes like the following: \
$1: [1, 1]$ \
$2: [1, 0, 1, 0]$ \
$3: [1, 0, 1]$ \
$4: [1, 0, 0, 0, 0, 0]$ \
$5: [1, 0, 0, 0, 0]$ \
$6: [1, 0, 0, 0]$ \
$7: [1, 0, 0]$ \
$8: [1, 0]$ \
$9: [1]$ \
$10: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]$ \
$11: [0, 0, 0, 0, 0, 0, 0, 0, 0]$ \
$12: [0, 0, 0, 0, 0, 0, 0, 0]$ \
$13: [0, 0, 0, 0, 0, 0, 0]$ \
$14: [0, 0, 0, 0, 0, 0]$ \
$15: [0, 0, 0, 0, 0]$ \
$16: [0, 0, 0, 0]$ \
$17: [0, 0, 0]$ \
$18: [0, 0]$ \
$19: [0]$ \
$20: []$

At which step does the worm $W_1 = [1,2]$ turn into $[]$?

Answer format: rightmost $20$ digits

*[My timing < 1 s]*
]


// Problem #379
#problem-block(number: 379)[
#text(fill: ColorSecondary)[
Unfortunately the picture "https://rosecode.neocities.org/uploads/Turkish_flag.png" was lost.
]

#table(
  stroke: none,
  columns: (40pt, auto, auto),
  inset: 5pt,
  table.hline(),
  table.header([*Letter*], [*Measure*], [*Length*]),
  table.hline(stroke: 0.5pt),
  [G], [Width], [],
  table.hline(stroke: 0.5pt),
  [A], [Distance between the centre of the outer crescent and the seam of the white band], [1/2 G],
  table.hline(stroke: 0.5pt),
  [B], [Diameter of the outer circle of the crescent], [1/2 G],
  table.hline(stroke: 0.5pt),
  [C], [Distance between the centres of the inner and outer circles of the crescent],	[1/16 G],
  table.hline(stroke: 0.5pt),
  [D], [Diameter of the inner circle of the crescent], [2/5 G],
  table.hline(stroke: 0.5pt),
  [E], [Distance between the inner circle of the crescent and the circle around the star], [1/3 G],
  table.hline(stroke: 0.5pt),
  [F], [diameter of the circle around the star], [1/4 G],
  table.hline(stroke: 0.5pt),
  [L], [Length], [3/2 G],
  table.hline(stroke: 0.5pt),
  [M], [Width of the white hem at the hoist], [1/30 G],
  table.hline()
)

If the total area of the flag is equal to $1$ (that means $G dot (L+M)=1$) what is the area of red part rounded to $10$ digits after the decimal point?

Note that the dotted circle around the star is drawn for illustration purpose and actually is a part of the red area.
]


// Problem #380
#problem-block(number: 380)[
The #link("https://en.wikipedia.org/wiki/Hilbert_curve")[Hilbert curve] is a space-filling curve described by the great German mathematician David Hilbert in 1891.

It is defined as the limit of the following process: \
We start with a square of side $1$ that we divide in $4$ parts. \
We join the center of each sub-square as shown in the picture. \
We repeat the process by dividing the square in $16$ parts. \
The Hilbert curve is the curve obtained when continuing this process infinitely.

#align(center)[
  #v(5pt)
  #image(width: 400pt, "figures/p380.png")
  #v(5pt)
]

As this curve encounters every point in the square, we can establish a bijection between the square and the segment $[0,1]$, as shown in the picture.

What is the point $(x,y)$ which corresponds to the value $upright(pi)-3$ in the interval $[0,1]$? \
What point $z$ in the interval $[0,1]$ corresponds to the point $(upright(e)-2,upright(gamma))$ in the quare? ($upright(gamma)$ is the Euler Mascheroni constant)

Answer format: `x,y,z` \
truncate the values at $10$ digits after the decimal point

Hint: \
You are given the point in the square corresponding to $sqrt(2)-1$ in the interval $[0,1]$: \
$(0.4472924291,0.9498609981)$

*[My timing: < 1 sec]*

#link("http://www.americanscientist.org/libraries/documents/2013416124139665-2013-05Hayes.pdf")[Credit to Brian Hayes for the pictures]
]


// Problem #381
#problem-block(number: 381)[
A solid cube has its $6$ faces painted in black. It is cut into $1000$ smaller cubes (each face evenly divided in $10$). These little cubes are placed in a bag and one is selected randomly. This selected cube is then rolled like a die.

What is the probability that it lands with a black face up?

Answer format: `P/Q` \
an irreductible fraction
]


// Problem #382
#problem-block(number: 382)[
Let $S_N$ be the set of positive numbers less or equal to $N$, $S_N={1,2,dots,N}$.

Consider the subsets with the following properties:
- none of the elements is a prime number
- none of the elements contains any prime digit(s)
- none of any $2$ elements' difference is a prime number
- none of any $2$ elements' difference contains any prime digit(s)

Find the subset of $S_100000$ with the maximal sum.

Answer format: `sum`

Example: `20` for $S_10$ subsets: \
${1}, {1,9}, {bold(1),bold(9),bold(10)}, {1,10}, {4}, {4,8}, {4,10}, {6}, {6,10}, {8}, {8,9}, {9}, {9,10}, {10}$

*[My timing: < 1 m]*
]


// Problem #383
#problem-block(number: 383)[
$P<Q$ are two prime numbers.

You are given:
$
P times Q &= 2502128003544190562737219821476557238262836801164\\ \
& #h(12pt) 2948611923288271186128054172457672472582525510063 \
P times.circle Q &= 10896394514466713067376536898727387282419639480038
$
($times.circle$ is the XOR operation)

Can you find $P$ and $Q$ ?

Answer format: `P,Q`

*[My timing: 75 sec]*
]


// Problem #384
#problem-block(number: 384)[
Denesting is the process of simplifying an expression with embedded $$n-th roots to obtain an equivalent expression with a lesser level of roots.

Ramanujan was a master in this matter and provided some amazing examples:
$
root(3,root(3,2)-1) &= (root(3,1/9) - root(3,2/9) + root(3,4/9)) times 1/3 \
sqrt(root(3,5) - root(3,4)) &= (root(3,2) + root(3,20) - root(3,25)) times 1/3 \
root(4, (3+2 root(4,5))/(3-2 root(4,5))) &= (3 + root(4,5) + sqrt(5) + root(4,125)) times 1/2
$

Can you denest the following expression: $sqrt(root(3,1404) - root(3,875))$?

The solution has the form $(root(3,a) + root(3,b) + root(3,c)) times p/q$ with $a<b<c$ and $p,q$ coprime.

Answer format: `a,b,c,p,q`

*[My timing: 35 sec]*
]


// Problem #385
#problem-block(number: 385)[
*Conjecture* \
For any positive rational $r$ there is a finite set of prime numbers $P_r^+$ such that $sum_(p in P_r^+) 1/(p+1) = r$.

For instance $3/14=1/(5+1)+1/(23+1)+1/(167+1)$.

Can you verify this conjecture for $25/61$?

Answer format: $p_1,p_2,dots,p_n$ \
if $25/61=1/(p_1+1)+1/(p_2+1)+dots.h.c+1/(p_n+1)$

As there are generally more than one solution, give the $1$st one in lexicographic order.

Limit your search to prime numbers < $100000$.

*[My timing: 35 sec]*
]


// Problem #386
#problem-block(number: 386)[
Let's $n$ an integer with the following factorisation: $n = a_1^(e_1) times a_2^(e_2) times dots times a_p^(e_p)$, where $a_i$ are squarefree and $forall i in {1,dots,p-1}$, $a_i$ divides $a_(i+1)$.

For instance: \
$56=2^2 times 14^1$ \
$5040=2^2 times 6^1 times 210^1$ \
$526773121875=3^2 times 15^3 times 1155^1 times 15015^1$

It can be proved that this factorisation is unique.

For such a factorisation, let's consider all the divisors of $n$: $a_1^(f_1) times a_2^(f_2) times dots a_p^(f_p)$ where $0 <= f_i <= e_i$.

Define $sigma'(n)=sum_d (d)$ where $d$ runs over the divisors of $n$ as defined above. \
$sigma'(5040)=1+2+4+6+12+24+210+420+840+1260+2520+5040=10339$.

We say that $n$ is a champion if the ratio $(sigma'(n))/n$ is greater than any ratio $(sigma'(m))/m$ with $m<n$.

Here are the first $10$ champions:
1. $1 => 2$
2. $24 => 2.04166666666667$
3. $48 => 2.1875$
4. $96 => 2.26041666666667$
5. $192 => 2.296875$
6. $384 => 2.31510416666667$
7. $768 => 2.32421875$
8. $1152 => 2.3515625$
9. $2304 => 2.37022569444444$
10. $4608 => 2.37955729166667$

What is the $66$-th champion?

*[My timing: 5 sec]*
]


// Problem #387
#problem-block(number: 387)[
Consider the number $35490$. It can be written as: \
$2,21,2,1$ in base $23$ \
$1,2,21,2$ in base $32$

Find the smallest number that can be written as: \
$d_1,d_2,dots,d_9$ in base $b_1 b_2$ \
$d_9,d_8,dots,d_1$ in base $b_2 b_1$ \
($b_1,b_2 in {1,dots,9}$)

Answer format: `number,base1` \
where `base1` $<$ `base2`

Example: `35490,23`

*[My timing: 4 sec]*
]


// Problem #388
#problem-block(number: 388)[
Given a string representing a positive integer, the machine outputs another string using the following rules:

*Rule 1*: If the input is $2X$, the output will be $X$. \
e.g.: $M(234) = 34$

*Rule 2*: If the input is $3X$ and $M(X) = Y$ the output will be $Y 2 Y$. \
e.g.: $M(327) = 727$

Find $X$ such as $M(X) = X$ \
Find $Y$ such as $M(Y) = Y 2 Y$ \
Find $Z$ such as $M(Z) = 7 Z$

Answer format: `X,Y,Z`

*[My timing: pencil and paper]*
]


// Problem #389
#problem-block(number: 389)[
The number $10! = 3628800$ has a set $D$ of $270$ divisors.

We can find $2$ sets $D_1$ and $D_2$ such as
- the product of each element of $D_1$ with each element of $D_2$ generates $D$
- the cardinals of the sets $D_1$ and $D_2$ are the closest possible

$D_1={1,3,5,9,15,25,27,45,75,81,135,225,405,675,2025}$ and $|D_1|=15$ \
$D_2={1,2,4,7,8,14,16,28,32,56,64,112,128,224,256,448,896,1792}$ and $|D_2|=18$

Find a fair partition for $100!$.

Answer format: $|D_1|,|D_2|$ \
(in ascending order)

Example: `15,18`

*[My timing: 54 sec]*
]


// Problem #390
#problem-block(number: 390)[
For positive integers $a,b,c$ ($a <= b <= c$), let $T(N)$ denote the number of triangles with sides $sqrt(a)$, $sqrt(b)$, and $sqrt(c)$ for $c <= N$.

What is $T(100000)$?

Example: `145048` for $N=100$.

*[My timing: < 1 m]*
]


// Problem #391
#problem-block(number: 391)[
It is known since #link("https://en.wikipedia.org/wiki/Lagrange's_four-square_theorem")[Lagrange] that every positive integer can be represented as the sum of integer squares, $4$ integers being enough.

But, if we add the constraint that all squares must be distinct, some integers are not representable as such a sum. This set is finite.

How many positive integers can not be represented by a sum of distinct squares, and what is their sum? (You are given that the largest one if less than $5000$)

Answer format: `Count,Sum`

*[My timing: 15 s]*
]


// Problem #392
#problem-block(number: 392)[
There is a beautiful theorem by #link("https://en.wikipedia.org/wiki/Beatty_sequence")[Samuel Beatty] which states:

#show math.equation: set text(features: ("cv01",))

If $alpha$ and $beta$ are positive irrational numbers such as $1/alpha+1/beta=1$ then $A={a in bb(N),floor(n dot alpha)}$ and $B={n in bb(N),floor(n dot beta)}$ are a partition of $N$: $N=A union B$ and $A sect B=emptyset$.

Let's $A$ the vector contained in this file #link("https://rosecode.neocities.org/uploads/data389.txt")[data389.txt].

If $A$ is a Beatty sequence, can you find the corresponding value $alpha$.

Answer format: $alpha$ \
truncated at $6$ positions after the decimal point.

*[My timing: instant]*
]


// Problem #393
#problem-block(number: 393)[
We know the the $10^9$-th prime number is $22801763489$.

What is the $10^200$-th prime number?

Answer format: The first $30$ digits of that number

*[My timing: 6 sec]*
]


// Problem #394
#problem-block(number: 394)[
In the equilateral triangle lattice plan, let's point $O$ be the origin.

A self avoiding path is built as follow:
- We start from $O$.
- At each step we choose one of the $6$ neighbour points which has not been visited yet.

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p394_1.jpg")
  #v(5pt)
]

We set a value on the $6$ vectors starting from a given point as follow:

#align(center)[
  #v(5pt)
  #image(width: 200pt, "figures/p394_2.jpg")
  #v(5pt)
]

We can thus associate a number to each path: the concatenation of the values of the vectors in that path.

For instance, the path given in the $1$st figure has the value: $2134$.

How many self avoiding paths with $12$ points are there? \
How many of these paths correspond to a palindromic value?

Answer format: `Count-paths,Count-palindromic`

You are given `618,30` for $5$ points.

*[My timing: 30 sec]*
]


// Problem #395
#problem-block(number: 395)[
Let $2^k <= p < q <= 2^(k+1)-1$.

We are looking for pairs $(p,q)$ such as
- $p times.circle q$ is maximal ($times.circle$ is the XOR operator)
- $p,q$ are both either a prime or a square number

How many such pairs are there for $k = 26$?

Answer format: `count,first p,first q`

Example: `3,1307,1764` for $k = 10$.

*[My timing: 42 sec]*
]


// Problem #396
#problem-block(number: 396)[
Consider the amazing Tupper's formula:
$ 1/2 < floor(mod(floor(y/17) 2^(-17 floor(x) - mod(floor(y),17)),2)) $

Plot the set of points $(x,y)$ where $0<=x<=105$ and $k<=y<=k+16$.

```
k =
18103678631912000062470282381747441976757893373198
86435384963567843211312931211913675581074713889534
00578937967544149947045057575532393376026086675639
79479602976376683335698251880808911605667287509150
04068115678628489149512637203885271143388014539045
70710336898701369407801663926977881040872681066426
17283868280916627888347962832772249277391186206061
40236546487592898274058357130776778346128459449558
45786918834227702457154420543255799489565393910464
89136316751596075567372059735592342126648150418628
790330350241623669114319450430013312
```

Answer format: the text hidden in the plot
]


// Problem #397
#problem-block(number: 397)[
A step number is a number whose digits are in ascending order \
For example: $1223455567$ is a step number

A pandigital step number is a step number which contains all digits (except $0$) at least once \
For example: $1122345556777899$ is a pandigital step number

Find the smallest ($S$) and largest ($L$) $30$-digits prime pandigital step numbers.

Answer format: `S,L`

Example: `111111111111223456789,123456777788888888899` for $21$ digts.

*[My timing: 65 sec]*
]


// Problem #398
#problem-block(number: 398)[
We define the hereditary base-$n$ representation of a number as follow: \
For instance, if $n=266$, and base $=2$, its hereditary base-$2$ representation is:
$
266&=2^1+2^3+2^8 \
&=2^1+2^(1+2)+2^2^3 \
&=2^1+2^(1+2)+2^2^(1+2)
$
We express $n$ in base $2$ and recursively every exponent in base $2$.

Let's define the $G_k$ sequence as follow: \
$G_1(n)=n$ \
$G_2(n)=$ Take the hereditary base-$2$ representation of $n$, replace each $2$s with $3$s and substract $1$ \
$G_k(n)=$ Take the hereditary base-k representation of $G_(k-1)(n)$, replace each $k$s with $(k+1)$s and substract $1$

Here the first values for $G_k (6)$ \
$G_1(6)=6$ \
$G_2(6)=29$ \
$G_3(6)=257$ \
$G_4(6)=3125$ \
$G_5(6)=46655$ \
$G_6(6)=98039$ \
$G_7(6)=187243$ \
$G_8(6)=332147$

Find $G_50(13)$.

*[My timing: < 1 sec]*
]


// Problem #399
#problem-block(number: 399)[
Let $S(n)$ be the smallest integer such as $n$ divides $S(n)!$.

For instance $S(9)=6$ for $6! equiv 0 mod 9$.

Consider the set $A$ of numbers of form $2^e_1 times 3^e_2 times 5^e_3 times 7^e_4 times 11^e_5 times 13^e_6 times 17^e_7 times 19^e_8$.

What is $sum_(n in A') S(n)$ where $A'$ contains the first $10^8$ elements of $A$.

You are given: `45499522` when $A'$ contains the first $10^6$ elements of $A$.

*[My timing: 120 sec]*

PS 1: We consider $S(1) = 0$. \
PS 2: There is a solution in less than $15$ sec.
]


// Problem #400
#problem-block(number: 400)[
Using only prime numbers less than $30$, the closest (less than) we can get from $10^10-1$ is: \
$9999928224 = 2^5 times 3^5 times 11 times 13 times 17 times 23^2$

Using only prime numbers less than $50$, how close can you get from $10^15-1$?

*[My timing: 60 sec]*
]


// Problem #401
#problem-block(number: 401)[
Let $S(n) = sum_(i <= n) floor(i dot sqrt(2))$ where $floor(x) = $ integer part of $x$.

For instance $S(100)=7092$.

What is $S(10^20)$?

*[My timing: instant]*

Thanks to *czp001* who gave me the idea!
]


// Problem #402
#problem-block(number: 402)[
Georg Cantor made many brillant discoveries, but the ones I find the most fascinating are in the realm of infinite sets, especially the #link("https://en.wikipedia.org/wiki/Ordinal_number")[Ordinal Numbers].

They are a new kind of numbers with some strange arithmetic rules: \
$(omega+1)+(omega^2+omega dot 2+1)=omega^2+omega dot 2+1$ \
$(omega^2+omega dot 2+1)+(omega+1)=omega^2+omega dot 3+1$

Let the following ordinal numbers: \
$sigma_1=omega^2$ \
$sigma_2=omega+1$ \
$sigma_3=omega dot 2+2$ \
$sigma_4=omega dot 4+3$ \
$sigma_5=omega dot 8+4$

If we add the five $sigma_i$ ordinal numbers using all possible $120$ permutations and sort them (using the ordinal number order)
- how many different sums can we obtain
- what is the $1$st (lowest) value
- what is the $17$-th value

Answer format: comma delimited

The ordinal numbers are represented using the #link("https://en.wikipedia.org/wiki/Ordinal_arithmetic#Cantor_normal_form")[Cantor Normal Form]
- the symbol $omega$ is represented with a `w`
- exponentiation is represented with a `^`
- the symbol $dot$ is represented with a `.`
- all spaces are removed
$omega^2+omega dot 3+1 ->$ `w^2+w.3+1`

*[My timing: < 1 s]*
]


// Problem #403
#problem-block(number: 403)[
For definitions, See #link(<p402>)[problem 402].

What is $(omega^2+omega+1)^(omega^3+omega^2+omega+2)$.

*[My timing: < 1 sec]*
]


// Problem #404
#problem-block(number: 404)[
A number is said #link("https://en.wikipedia.org/wiki/Powerful_number")[powerful] if all its prime factors appear with an exponent greater than $1$.

A *pure powerful number* is a powerful number that is not a perfect square.

Two pure powerful numbers can be consecutive: \
$12167 med (23^3),12168 med (2^3 times 3^2 times 13^2)$

Find the $11$-th pair $(m,m+1)$ of consecutive pure powerful number --- $(12167, 12168)$ being the $1$st.

Answer format: `m`

*[My timing: < 30 sec]*
]


// Problem #405
#problem-block(number: 405)[
A #link("https://en.wikipedia.org/wiki/Square-free_integer")[squarefree number] is a number not divisible by a perfect square (other than $1$).

How many squarefree numbers $<=123456789123456789$ are there?

Answer format: `count`

*[My timing: 55 sec]*
]


// Problem #406
#problem-block(number: 406)[
Find all powerful numbers $<=10^25$.

Answer Format: `count,sum`

Example: `214122,716436326576527` (for $<=10^10$)

*[My timing: 0.5 sec]*
]


// Problem #407
#problem-block(number: 407)[
A #link("https://en.wikipedia.org/wiki/Carmichael_number")[Carmichael number] is a chain if when we remove repeatedly its largest factor, we still obtain a Carmicheal number.

$174470590282430768272287350512321$ is a Carmichael chain of length $10$ (it has $10$ factors).

$174470590282430768272287350512321=7 times 13 times 31 times 61 times 181 times 541 times 2161 times 187921 times 3570481 times 7140961$ \
$24432368456070656074481761=7 times 13 times 31 times 61 times 181 times 541 times 2161 times 187921 times 3570481$ \
$6842878720281848881=7 times 13 times 31 times 61 times 181 times 541 times 2161 times 187921$ \
$36413592521761=7 times 13 times 31 times 61 times 181 times 541 times 2161$ \
$16850343601=7 times 13 times 31 times 61 times 181 times 541$ \
$31146661=7 times 13 times 31 times 61 times 181$ \
$172081=7 times 13 times 31 times 61$ \
$2821=7 times 13 times 31$ \
All these numbers are Carmichael numbers.

Of course, we stop at $3$ factors, as a Carmichael number can't have less than $3$ factors.

Find the next Carmichael chain of length $10$. We assume that no factor is greater than $10^7$.

*[My timing: 60 sec]*
]


// Problem #408
#problem-block(number: 408)[
The #link("https://en.wikipedia.org/wiki/Mertens_function")[Mertens function] is the summatory function of the #link("https://en.wikipedia.org/wiki/M%C3%B6bius_function")[Möbius function].

$display(M(n) = sum_(k<=n) mu(k))$

Find the first $i$ such as $M(i)=-9876$ and the first $j$ such as $M(j)=+9876$.

Answer format: `i,j`

You are given: `12855874,10193871` for $plus.minus 1234$.

*[My timing: 60 sec]*
]


// Problem #409
#problem-block(number: 409)[
Let $s_0$ be the string "$01$" and $s_i=s_(i-1)+s_(i-1)[0:i]$ for $i>=1$, where $s[0:i]$ means the first $i$ characters of $s$.

For example, $s_1=$ "$010$", $s_2=$ "$01001$" and $s_3=$ "$01001010$".

Let $C(i)$ be the number of "$1$" in the $s_i [0:i]$.

You are given that $C(10)=4$, $C(10^4)=3576$ and $C(10^8)=35807401$.

Find $C(10^18)$.

*[My Timing: instant]*
]


// Problem #410
#problem-block(number: 410)[
It is conjectured that all positive integers, not of the form $9 times k plus.minus 4$ can be written as a sum of $3$ cubes, probably in infinitely many ways.

Some decompositions are hard to discover.

For instance, the smallest decomposition of $74$ was only discovered in 2016: \
$74=-284650292555885^3+66229832190556^3+283450105697727^3$

Decompositions for all integers up to $100$ are known, except for $33$ and $42$.

Find all the decompositions of $1026$ where the absolute value of each cube is $<10^5$.

Answer format: `Count,X,Y,Z` \
where $X<Y<Z$ is the triple with the largest absolute values for $X$

You are given: `6,-14900,10849,12664` for $993$ and a threshold of $20000$. \
$993=-14900^3+10849^3+12664^3$ \
$993=-11450^3-4127^3+11626^3$ \
$993=-8339^3+6121^3+7051^3$ \
$993=-2528^3+673^3+2512^3$ \
$993=-1007^3-842^3+1174^3$ \
$993=-2^3+1^3+10^3$

*[My timing: 60 sec]*
]


// Problem #411
#problem-block(number: 411)[
What is the digital sum of $1500000!$.

You are given: $1938780$ for $100000!$.

*[My timing: 120 sec]*
]


// Problem #412
#problem-block(number: 412)[
It is a open problem to know whether a $3 times 3$ magic square containing only squares exists or not.

We say a square is *almost magic* if all the sums are equal except for the anti-diagonal.

The following square is almost magic:
#set math.mat(gap: 8pt)
$
mat(delim: "[",
  174^2, 381^2, #text(fill: rgb(255, 0, 0))[$138^2$] ;
  291^2, #text(fill: rgb(255, 0, 0))[$222^2$], 246^2;
  #text(fill: rgb(255, 0, 0))[$282^2$], 6^2, 339^2
)
$

What is the first (lexicographic order) almost magic square with all elements squares of numbers $<=200$.

Answer format: comma separated list of the square root of each element \
(All values must be distinct)

Exemple: `174,381,138,291,222,246,282,6,339` for the above example.

*[My timing: 25 sec]*
]


// Problem #413
#problem-block(number: 413)[
Let $C(n,k)$ be the number of integer solutions $(x_1,dots,x_k)$ such that $xor.big_(i=1)^k x_i=0$ and $0<=x_i<n$ for each $i$. Here, $x xor y$ means $x$ xor $y$.

Let $F(n)$ be the $n$-th Fibonacci number: $F(0)=0$, $F(1)=1$, and $F(i)=F(i-1)+F(i-2)$ for $i>=2$.

Let
$ S(n) := sum_(i=1)^n sum_(j=1)^n C(F(i), F(j)). $

You are given $S(6)=2153296$ and $S(7)=18998620089329$.

Find $S(92)$ modulo $10^9+7$.

*[My timing: 0.3 seconds]*
]


// Problem #414
#problem-block(number: 414)[
Here is the smallest known solution in positive integers for the Diophantine equation
$ x/(y+z) + y/(z+x) + z/(x+y) = 4 $

$x=43736[dots.h.c]772036$ \
$y=368751[dots.h.c]055579$ \
$z=1544768[dots.h.c]277999$ \
(The $dots.h.c$ represent $70$ digits!)

If we allow one variable to be negative, we can find smaller solutions.

For example, $(x,y,z) = {-1,4,11}$ and ${-5,9,11}$ are solutions of the above equation.

Find the first solution to $x/(y+z) + y/(z+x) + z/(x+y) = 38$ with $x<0<y<z$ (coprime integers).

Answer format: `x,y,z`

*[My timing: 15 sec]*
]


// Problem #415
#problem-block(number: 415)[
See #link(<p414>)[problem 414].

Find the first solution to $x/(y+z) + y/(z+x) + z/(x+y) = 466$ with $x<0<y<z$ (coprime integers).

Answer format: `x,y,z`

*[My timing: less than 1 sec]*
]


// Problem #416
#problem-block(number: 416)[
Take the number $134431001$ as an example. We can make pairs using the $2$ digits following one another: \
$[(1, 3), (3, 4), (4, 4), (4, 3), (3, 1), (1, 0), (0, 0), (0, 1)]$

#align(center)[
  #v(5pt)
  #image(width: 150pt, "figures/p416_1.png")
  #v(5pt)
]

In general for a $k$-digit number like $d_1 d_2 dots.h.c d_k$ we can have a $(k-1)$-gon: \
$[(d_1,d_2), (d_2,d_3), dots, (d_(k-1),d_k)]$

If the drawn polygon is a convex one then we will call this kind of number as *convex number*.

How many *positive* convex numbers are there?

Answer format: `count,sum`

*[My timing: < 1 m]*

Notes:
- Any two neighbouring line segments cannot be collinear.
- All the generated pairs must be distinct.
- Some polygons can be generated by more than one number.

For example: $112321, 123211, 232112, 321123, 211232$. Since the numbers are different, they are all counted.

#align(center)[
  #v(5pt)
  #image(width: 100pt, "figures/p416_2.png")
  #v(5pt)
]
]


// Problem #417
#problem-block(number: 417)[
Let $D$ be a positive integer.

Suppose that we would like to find all nonnegative integer solutions $(x,y,z)$ of
$ x^2 + D = y dot z. $

Let's assume that $(x,y,z)$ is a solution of the above equation. Then, it can be verified that $(x+y,y,2x+y+z)$ and $(x+z,2x+y+z,z)$ are also solutions of the equation. Let's define this generating process as the _evolution_ of $(x,y,z)$.

Surprisingly, we can find all solutions uniquely by choosing some seeds $S_D={(x_1,y_1,z_1),dots,(x_k,y_k,z_k)}$ and _evolving_ them repeatedly (a _seed_ is a solution of the equation).

For example, when $D=2$, we can choose $S_2$ as $S_2={(0,1,2),(0,2,1)}$.

Let $C(D)$ be the minimum number of seeds needed to enumerate all nonnegative integer solutions of the equation.

It can be verified that $C(2)=2$, $C(3)=3$ and $C(100)=18$.

Let $S(n):=sum_(D=1)^n C(D)$. You are given $S(10)=40$ and $S(100)=1714$.

Find $S(3 times 10^7)$.

*[My Timing: 14.8 seconds (PyPy)]*
]


// Problem #418
#problem-block(number: 418)[
Let $p_(4,3) (n)$ be the smallest prime $p$ such that $p>n$ and $p equiv 3 med (mod 4)$ and let
$
p_(4,3)^k (n) :=  cases(
    p_(4,3)^(k-1)(p_(4,3) (n)) quad & "if" k > 1,
    p_(4,3) (n) quad & "if" k = 1
).
$

Let $F(n) := (n-1)/2 ! mod n$.

For example, $F(3)=1$ and $F(47)=46$.

Let $S(n,m) := sum_(k=1)^m F(p_(4,3)^k (n))$.

You are given $S(1,32)=1856$, $S(10^7,32)=150008239$ and $S(10^12,32)=18000000012930$.

Find $S(10^18,32)$.

*[My timing: 1.8 seconds (PyPy)]*

Note: It would be hard without *PARI/GP*.
]


// Problem #419
#problem-block(number: 419)[
Let $r_3(n) = \# {(x, y, z) in bb(Z)^3 | x^2 + y^2 + z^2 = n}$.

For example, $r_3(0)=1$, $r_3(1)=6$ and $r_3(100)=30$.

Let $display(S(n,m)=sum_(k=0)^(m-1) r_3(n+k))$.

It can be verified that $S(1,100)=4168$ and $S(10^8,100)=6410310$.

Find $S(10^17,100)$.

*[My timing: 2.6 seconds (PyPy)]*

Note: It would be hard without *PARI/GP* and some *papers*.
]


// Problem #420
#problem-block(number: 420)[
Consider a sphere whose square of its radius is $n$ and centered at $(0,0,0,0)$ in the $4$th dimension space. For a given $n$, the sphere touches a certain number of integer lattice points.

For instance, if $n=7$, it touches the point $(1,2,1,1)$.

Let $t(n)$ the number of integer lattice points touched by the sphere with square of radius $n$.

Find $sum_(k=0)^100 t(10^17+k)$.

You are given $sum_(k=0)^100 t(1000+k)=1042664$.

*[My timing: 9 sec]*
]


// Problem #421
#problem-block(number: 421)[
A magic cube is the $3$-D equivalent of a magic square.

Here is an exemple of a $3 times 3 times 3$ magic cube with all integers from $1$ to $27$:

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p421.jpg")
  #v(5pt)
]

- The sum of all rows and columns in the $3$ directions are equals
$4+26+12=42$ \
$4+18+20=42$ \
$4+17+21=42$

- The sum of the $4$ main diagonals are equals
$4+14+24=42$ \
$21+14+7=42$ \
$16+14+12=42$ \
$20+14+8=42$

How many $3 times 3 times 3$ magic cubes with integers in ${1,dots,27}$ are there?

Answer format: `Count:comma separated list of values for the cube of rank 123`

Example: `999:4,17,21,18,19,5,20,6,16,26,3,13,1,14,27,15,25,2,12,22,8,23,9,10,7,11,24` \
(Corresponds to the cube in the above picture)

*[My timing: 2 min]*

PS: We ignore symmetries: facing the $6$ faces of this example, we get $6$ distinct solutions. To rank the cubes, represent them as a $27$ elements vectors (as in the above example), then sort the vectors in lexicographic order.
]


// Problem #422
#problem-block(number: 422)[
Initially the Universe does not exist. The God (or whatever you name it) sits idle within nothingness. Luckily the God has a little friend that keeps asking questions every day but just one for each day.

The little asker has $3$ questions of the form: \
*(1)* Will you say YES to my next question? \
*(2)* Will you say NO to my next question? \
*(3)* Does the Universe exist now?

*(a)* God can only answer as YES or NO. God always answers immediately within the same day. \
*(b)* The answer to (3) is always deterministic, namely there is only one choice always, in default case being always NO, but can only be forced to YES through a sequence of (1)s and (2)s. \
*(c)* If (1) or (2) asked right after (3) or at start, the answer is nondeterministic, namely God can answer at will as YES or NO. This is the only case for God to be nondeterministic. \
*(d)* A sequence of (1)s and (2)s which goes on after the preceeding (1) or (2) is deterministic, and God has to answer possible successive (1)s and (2)s accordingly and never cheat. \
*(e)* If a (3) appears at the end of a sequence of (1)s and (2)s, the answer is obviously deterministic. But as noted in (c), a (1) or (2) appearing after a (3) or (3)s, will again cause a nondeterministic answer from God. \
*(f)* These rules go on until the God is forced to answer as YES to Universe existence question, and the Universe finally emerges. \

Here is a sample run to get familiarized with the concept: \
*A*: Does the Universe exist now? \
*G*: NO (initially it does not exist!) \
*A*: Will you say YES to my next question? \
*G*: NO (nondeterministic, can say either ...) \
*A*: Will you say YES to my next question? \
*G*: NO (deterministic, has to say NO) \
*A*: Will you say NO to my next question? \
*G*: NO (deterministic) \
*A*: Will you say NO to my next question? \
*G*: YES (deterministic) \
*A*: Does the Universe exist now? \
*G*: NO (deterministic!) \
*A*: Will you say YES to my next question? \
*G*: YES (nondeterministic as form (3) breaks determinism) \
*A*: Does the Universe exist now? \
*G*: YES (finally!)

So the asker's choices are uniformly random, and also the God's will (when possible) is uniformly random. With these final assumptions, what is the expected number of days needed for the Universe to emerge? Round your answer to $3$ decimal places.
]


// Problem #423
#problem-block(number: 423)[
Initially the Universe does not exist. However, each day either a matter or anti-matter emerges uniformly randomly. The Universe is born when matter count exceeds that of anti-matter for the first time. In this case, what is the probability that the Universe emerges within *365* days?

Give the result as an exact fraction in lowest terms.
]


// Problem #424
#problem-block(number: 424)[
A Friedman number is a number which can be written using *all its digits exactly once* and a combination of the following operations: \
`+` (addition) \
`-` (subtraction) \
`*` (multiplication) \
`/` (division) \
`^` (exponentiation) \
`,` (concatenation) (#link(<note424>)[\*])

Examples: \
`5776 = 76^(7-5) = 76 7 5 - ^` \
`8092 = (90^2)-8 = 90 2 ^ 8 -` \
`11943 = (11^3-4)*9 = 11 3 ^ 4 - 9 *` \
`16225 = ((52^2)*6)+1 = 52 2 ^ 6 * 1 +` \
Expressions are represented in #link("https://en.wikipedia.org/wiki/Reverse_Polish_notation")[postfix notation].

Let's call the set of terms used in a decomposition, the *primitive factors*.

The Friedman number 1395 has two sets of primitive factors: \
${15,93}$ \
${5,9,31}$ \
For we have the following decompositions: \
$1395=15 times 93$ \
$1395=5 times 9 times 31$

In the range $[13800,13900]$, find the Friedman number with the most primitive factors
For each primitive factors of this number, find the corresponding decompositions and give the first one in alphabetic order (in postfix notation). (The primitive factors are sorted in lexicographic order: first by length, then by values)

Answer format: `comma separated list for primitive factors 1:decomposition 1|...`

Example: `2,9,16:16 9 2 ^ *|1,2,6,9:6 9 1 - 2 / ^` \
in the range $[1200,1400]$

*[My timing: 100 sec]*

#text(fill: ColorSecondary)[\*]<note424> Concatenation can only be used to build the integers used in expressions, but not in expressions.
]


// Problem #425
#problem-block(number: 425)[
#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p425.jpg")
  #v(5pt)
]

$A=$ area of the large square \
$a=$ area of the small square

What is $A/a$?
]


// Problem #426
#problem-block(number: 426)[
A vampire number is a $2k$-digits number $n$ such as there exist two $k$-digits numbers $a$ and $b$ such as:
- $n=a times b$
- the digits of $a$ and $b$ are exactly the digits of $n$

Example: $1001295697=19001 times 52697$.

The two factors $a$ and $b$ are called, quite logically, the fangs.

Find the first and last $10$-digits vampire numbers *not containing the digit 0* with prime fangs.

Anwer format: `first,last`

Example: `11722657,79168819` (for $8$ digits) \
$11722657=2267 times 5171, quad 79168819=8171 times 9689$


*[My timing: 82 sec]*

Hint: The first digits of last are $945 dots.h.c$
]


// Problem #427
#problem-block(number: 427)[
You need to force your brain to solve this one `:)`
]


// Problem #428
#problem-block(number: 428)[
An audio signal is intercepted. It is known that the signal includes double-side band suppressed carrier modulation. It is known that the target channel uses carrier frequency as $4000$ Hz with a bandwidth of $1500$ Hz.

More mathematically, a bandpass signal is formulated as: \
$s(t) = m(t) cos(2 pi f_c t)$

In such a case there is a single channel broadcasting the message $m(t)$ at carrier frequency $f_c$.

In case of multiple channels broadcasting it becomes: \
$s(t) = m_1(t) cos(2 pi f_1 t) + m_2(t) cos(2 pi f_2 t) + dots.h.c$

So, given $s(t)$ as this #link("https://rosecode.neocities.org/uploads/radio_signal.wav")[audio signal], can you recover $m(t)$ within the bandwidth $[2500 "Hz", 5500 "Hz"]$?

Please provide the keyword you hear in lower case.
]


// Problem #429
#problem-block(number: 429)[
A point $O$ is choosen inside an equilateral triangle $A B C$

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p429.jpg")
  #v(5pt)
]

The angle $hat(A O C)$ is $105 degree$. \
The angle $hat(B O C)$ is $115 degree$.

We use the segments $O A$, $O B$, $O C$ to build a new triangle.

What are the angles of this triangle?

Answer format: the sorted (ascending order) angles in degree, comma separated
]


// Problem #430
#problem-block(number: 430)[
Let $"fib"(n)$ be $n$-th Fibonacci number. $"fib"(1)=1$, $"fib"(2)=1$ and
$"fib"(n) = "fib"(n-1) + "fib"(n-2)$ for $n>2$.

Let $f(n)=1+("fib"(n) mod 5)$.

Let $v_N$ be the vector of $f(i)$ values for $i=1$ to $N$. For example $v_3=[2, 2, 3]$.

Let $T_N$ be the sum of the elements of $V_N$. For example $T_3=7$.

Consider an $A B C$ triangle and a $D$ point that bisects $B C$ side: $|B D|=|C D|$.

Draw the $A D$ segment and assume $N-1$ points on it that further creates $N$ segments such that the lengths of these subsegments are proportional to the elements of $v_N$ starting from $A$ to $D$. \
$s_i = v_N [i]\/T_N dot |A D| "for" i=1 "to" N$

Now draw the line segments from $C$ to $A B$ that cross these $N-1$ points on $A D$ segment. So now we have $N$ subsegments on $A B$ side as well.

Let the lengths of these subsegments on the $A B$ side be given as $t_i$ for $i=1$ to $N$ starting from $A$ to $B$.

Find the sum of ratios $|A B|\/t_i$ for $i=1$ to $N$ where $N = 1919$.

Answer format: `p/q` \
(reduced fraction)

You are given that the answer = `251/21` for $N = 3$.

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p430.png")
  #v(5pt)
]
]


// Problem #431
#problem-block(number: 431)[
Let $P_n (k)$ the $k$-th prime number.

For instance, $P_n (1000000)=15485863$.

Find $P_n (3141592653589793)$.

*[My timing: 40 sec]*
]


// Problem #432
#problem-block(number: 432)[
Let $"fib"(n)$ be $n$-th Fibonacci number. $"fib"(1)=1$, $"fib"(2)=1$ and
$"fib"(n) = "fib"(n-1) + "fib"(n-2)$ for $n>2$.

Let $f(n)=1+("fib"(n) mod 5)$.

Let $v_(M+N)$ be the vector of $f(i)$ values for $i=1$ to $M+N$. For example $v_(2+2)=[2, 2, 3, 4]$.

Let $T_M$ be the sum of the first $M$ elements of $V_(M+N)$ and $T_N$ be the sum of the last $N$. For example $T_M=4$ and $T_N=7$ for $M=2$ and $N=2$.

Consider an $A B C$ triangle with $M-1$ points on $A B$ side and $N-1$ points on $B_C$ side.

Draw $M-1$ line segments from $C$ to the $M-1$ points on the $A_B$ side thereby creating $M$ line segments on the $A_B$ side proportional to the first $M$ values of $V_(M+N)$ starting from $A$ to $B$. \
$|A B|_j = v_(M+N) [j] dot |A B|\/T_M "for" j=1 "to" M$

Similarly draw $N-1$ line segments from $A$ to the $N-1$ points on the $B C$ side thereby creating $N$ line segments on the $B C$ side proportional to the last $N$ values of $V_(M+N)$ starting from $B$ to $C$. \
$|B C|_i = v_(M+N) [M+i] dot |B C|\/T_N "for" i=1 "to" N$

So now we have $M dot N$ subareas named $a_(i j)$ where $1 <= i <= N$ and $1 <= j <= M$.

Let's assume that the area of $A B C$ triangle is equal to $1$.

Find the values of these $M dot N$ subareas for $M=19$ and $N=23$, sort them in ascending order and submit the answer as per the format given below.

Answer format: $"area"_"first","aream"_"edian","area"_"last"$ \
where areas are in the form of `p/q` (reduced fraction)

You are given that the answer = `3/22,1/4,4/11` for $M=2$ and $N=2$. \
Areas: $a_11=3\/22$, $a_12=45\/154$; $a_21=4\/11$, $a_22=16\/77$.

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p432.png")
  #v(5pt)
]
]


// Problem #433
#problem-block(number: 433)[
#align(center)[
  #v(-20pt)
  #image(width: 300pt, "figures/p433.png")
  #v(-10pt)
]

$A B C$ is an equilateral triangle. $D E F$ is another equilateral triangle with its two vertices $(E, F)$ on the circumcircle of $A B C$ and its third vertex ($D$) on the $A B$ segment. $O$ is the circumcenter of $A B C$.

What is the ratio $"area"(A B C)\/"area"(D E F)$?

Answer format: number rounded to $5$ digits after the decimal point
]


// Problem #434
#problem-block(number: 434)[
$10$ farmers $(A,B,dots,J)$ are plowing a field.

$A$ and $B$ working together can plow the field in $2$ days. \
$B$ and $C$ working together can plow the field in $3$ days. \
$C$ and $D$ working together can plow the field in $5$ days. \
$D$ and $E$ working together can plow the field in $7$ days. \
$E$ and $F$ working together can plow the field in $11$ days. \
$F$ and $G$ working together can plow the field in $13$ days. \
$G$ and $H$ working together can plow the field in $17$ days. \
$H$ and $I$ working together can plow the field in $19$ days. \
$I$ and $J$ working together can plow the field in $23$ days. \
$J$ working alone can plow the field in $29$ days.

How many days does it take if all the farmers are working together?

Answer format: `P/Q` \
(irreductible fraction)
]


// Problem #435
#problem-block(number: 435)[
The following equations are given:
- $x^2 + y^2 + x dot y = a$
- $y^2 + z^2 + y dot z = b$
- $z^2 + x^2 + z dot x = c$

Find *positive* $(x,y,z)$ triples when $a=sqrt(i+1), b=sqrt(i+2), c=sqrt(i+3)$ for $i=1$ to $N$ where $N = 1923$.

Answer format: $sum x,sum y,sum z$ \
where each sum is a number rounded to $10$ digits after the decimal point

Example: `2.4103394172,2.1120641648,2.7525737652` for $N = 3$.
]


// Problem #436
#problem-block(number: 436)[
What is the least positive integer $a$ such as $a^4+2^1002$ is #link("https://en.wikipedia.org/wiki/Semiprime")[semiprime]?

*[My timing: < 1 sec]*
]


// Problem #437
#problem-block(number: 437)[
It is well known that the Harmonic serie $sum_(n>=1) 1/n$ is divergent.

A more surprising result is that if we remove all numbers containing at least one digit $9$ the corresponding serie is convergent.

What is $sum_(n in S_(1,2,1,4)) 1/n$. \
Where $S_(1,2,1,4)$ is the set of all numbers with exactly one digit $2$ and one digit $4$ in their base-$10$ representation. \
$S_(1,2,1,4)={24,42,124,142,204,214,234,240,241,243,245,dots}$

Answer format: give the result with the first $20$ digits after the decimal point

*[My timing: < 1 sec]*
]


// Problem #438
#problem-block(number: 438)[
Let said the cost for the product of $2$ matrices of size $(p,q)$ and $(q,r)$ is $p times q times r$.

Let's take $4$ matrices with respective sizes: \
$A : (50, 20)$ \
$B : (20, 1)$ \
$C : (1, 10)$ \
$D : (10, 100)$

We have $5$ different ways to multiply these matrices with very different costs: \
$A times (B times (C times D))=103000$ \
$A times ((B times C) times D)=120200$ \
$(A times B) times (C times D)=7000$ \
$(A times (B times C)) times D=60200$ \
$((A times B) times C) times D=51500$ \
The smallest cost is $7000$.

We take 50 matrices with respective sizes:

```
(8737, 1458) (1458, 1629) (1629, 5104) (5104, 8634) (8634, 9493)
(9493, 1380) (1380,  898) ( 898, 3036) (3036, 5012) (5012, 2405)
(2405, 5697) (5697, 6520) (6520, 4777) (4777, 4031) (4031, 3752)
(3752, 7848) (7848, 7540) (7540, 2624) (2624, 2436) (2436, 4598)
(4598, 1020) (1020, 9050) (9050, 7031) (7031, 8692) (8692,   48)
(  48,  396) ( 396, 2747) (2747, 4224) (4224, 9760) (9760, 8525)
(8525,  391) ( 391,  714) ( 714, 4590) (4590, 1455) (1455, 5437)
(5437, 4039) (4039, 6210) (6210, 7036) (7036, 5152) (5152, 4300)
(4300, 3511) (3511, 2484) (2484,  449) ( 449, 5683) (5683, 9809)
(9809, 4691) (4691, 3968) (3968, 3950) (3950, 5605) (5605, 1983)
```

What is the smallest cost for multiplying these matrices?

Answer format: `cost`

*[My timing: < 1 sec]*
]


// Problem #439
#problem-block(number: 439)[
Assume a point $D$ *inside* an equilateral triangle $A B C$ of side length $t$ and with $A D=x$, $B D=y$, $C D=z$, $0<x<=y<=z$, which is represented as quadruple $(x,y,z,t)$.

If $x,y,z,t$ are all integers and they are coprime, the quadruple $(x,y,z,t)$ is called primitive integer solution. For example, $(57,65,73,112)$ is such a solution. And it's known that there are infinitely many solutions of primitive integer quadruple $(x,y,z,t)$.

Find all such solutions for $t<=5000$.

Answer format: [number of solutions],[sum of $x+y+z+t$ of all solutions]

Example: `3,1237` for $t<=200$ \
(explanation: there are total $3$ solutions $(57,65,73,112), (73,88,95,147), (43,147,152,185)$)
]


// Problem #440
#problem-block(number: 440)[
A #link("https://en.wikipedia.org/wiki/Square-free_integer")[squarefree number] is called special if it can be expressed as the sum of two positive squares. For example, $65 med (=1^2+8^2)$ is a special squarefree number while $15$ is not.

Let $S(N)$ be the sum of all special squarefree numbers from $1$ to $N$. You are given that $S(10)=17$, $S(1000)=81665$, $S(10^6)=61081126084$.

Find $S(10^12)$.
]


// Problem #441
#problem-block(number: 441)[
A #link("https://en.wikipedia.org/wiki/Perfect_power")[perfect power] $n$ is called enhanced if there exists two integers $m>0$ and $k>2$ such that $n=m^k$. The enhanced perfect powers no more than $100$ are $1,8,16,27,32,64,81$.

Let $S(N)$ be the sum of all enhanced perfect powers no more than $N$. You are given $S(100)=229$, $S(10000)=99352$ and $S(10^8)mod 1000000007=553225565$.

Find $S(10^100)mod 1000000007$.
]


// Problem #442
#problem-block(number: 442)[
Consider a $10$-digit #link("https://en.wikipedia.org/wiki/Pandigital_number")[pandigital number] $n$ in base $10$. If we take first and last half of $n$, two $5$-digit numbers $x$ and $y$ are got. Specially, square of $x$ and square of $y$ are also both $10$-digit pandigital.

Find all pandigital numbers $n$ satisfying above properties. Note: leading zero is not allowed in any numbers.

Answer format: [count],[sum] \
(sample input: `1,1023456789`)
]


// Problem #443
#problem-block(number: 443)[
$A B C D$ is a parallelogram.

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p443.jpg")
  #v(5pt)
]

From each vertex, we join the middle of the $2$ opposites sides \
$F$ is the middle of $B C$ \
$E$ is the middle of $C D$ \
We draw the lines $A F$ and $A E$

We draw thus $8$ lines which define an octogon.

What is $"Area"("Octogon")/"Area"("Parallelogram")$.

Give your answer rounded to $10$ digits after the decimal point.
]


// Problem #444
#problem-block(number: 444)[
Let $K(a,b)$ be the infinite sequence such that:
- The first element is $a$,
- It consists of $a$ and $b$, and
- Its run length sequence is equal to $K(a,b)$.

Here, for example, we assume that the run length sequence of $[1,1,1,2,3,4,4,5]$ is $[3,1,1,2,1]$.

We can verify that
- $K(2,3)=[2,2,3,3,2,2,2,3,3,3,2,dots]$, and
- $K(2,4)=[2,2,4,4,2,2,2,2,4,4,4,4,2,dots]$.

Let $C_(a,b)(N)$ be the number of $a$ in the first $N$ elements of $K(a,b)$.

For example, $C_(2,4)(4)=2$ and $C_(2,4)(5) = 3$.

Let $S(M,N) := sum_(a=2)^(M-1) sum_(b=a+1)^M C_(a,b)(N)$.

You are given $S(5,100)=300$ and $S(10,10^6)=17856847$.

Find $S(100,10^15)$.
]


// Problem #445
#problem-block(number: 445)[
The binomial coefficients can be arranged in triangular form like this:

#[
#show "              1": set text(weight: "bold", fill: rgb(255, 0, 0))
#show "   2   ": set text(weight: "bold", fill: rgb(255, 0, 0))
#show "   6   ": set text(weight: "bold", fill: rgb(255, 0, 0))
```
              1
            1   1
          1   2   1
        1   3   3   1
      1   4   6   4   1
    1   5   10  10  5   1
```
]
#v(-15pt)
#[
#show "  20  ": set text(weight: "bold", fill: rgb(255, 0, 0))
```
  1   6   15  20  15  6   1
1   7   21  35  35  21  7   1
            ......
```
]

It is known as Pascal's triangle.

The middle coefficients of the even-numbered rows (row numbering starts from zero) form a sequence $a_n (n>=0): 1, 2, 6, 20, 70, 252, 924, 3432, 12870, 48620, 184756, dots$. It has been proven that no number $a_n$ with $n>4$ is squarefree.

Let $f(n)$ be $n$ divided by largest squarefree divisor of $n$. For example, $24=2^3 times 3$ and its largest squarefree divisor is $6$, so $f(24)=24\/6=4$.

Let $S(N)$ be the sum of all $f(a_n)$ for $n$ from $1$ to $N$. You are given $S(10)=1+1+2+1+6+2+4+3+2+2=24$, $S(100)=429083$ and $S(10^3) mod 1000000007=258384246$.

Find $S(10^6) mod 1000000007$.
]


// Problem #446
#problem-block(number: 446)[
Let
$ S(m,n) = sum_(k=1)^m sum_(x=1)^n (x^k dot floor((pi x)/k)^k) $
where $floor(x)$ is the largest integer less than or equal to $x$.

You are given $S(1,10)=1182$, $S(3,100)=16716537706541$ and $S(10,10^4) mod 1000000007=211872856$.

Find $S(20,10^20) mod 1000000007$.

Hint: solve #link(<p401>)[Problem 401 - A Big Sum] first and there are some clues in the secret forum.
]


// Problem #447
#problem-block(number: 447)[
Find $display((sum_(i=1)^(10^1000) i^100) "modulo" 1000000007)$.

*[My timing: < 3 sec]*
]


// Problem #448
#problem-block(number: 448)[
It is known that a circle is a curve in a plane that the distance from a given point is constant for every point on the curve. And an ellipse is a curve in a plane surrounding two focal points such that the sum of the distances to the two focal points is constant for every point on the curve.

We can generalize the definition of ellipse to #link("https://en.wikipedia.org/wiki/N-ellipse")[$n$-ellipse]. Given $n$ points (called foci) in a plane, an $n$-ellipse is the locus of all points of the plane whose sum of distances to the $n$ foci is a constant.

There is an equilateral triangle $A B C$ of side length $1$ in a plane. A $3$-ellipse curve is the set of all points of the same plane whose sum of distances to the three points $A$, $B$ and $C$ is $3$ (see the thick curve line in the picture). And the curve can be put inside the circle with a radius of $1$.

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p448.png")
  #v(5pt)
]

Find the enclosed area and circumference of the closed curve above. Give your answer rounded to $6$ digits after the decimal point.

Answer format: [area],[circumference]

Example: `3.141593,6.283185` for a circle with a radius of $1$.
]


// Problem #449
#problem-block(number: 449)[
The definition of #link("https://en.wikipedia.org/wiki/N-ellipse")[$n$-ellipse] is as below: given n points (called foci) in a plane, an $n$-ellipse is the locus of all points of the plane whose sum of distances to the $n$ foci is a constant. We can generalize the definition from plain to space, and the set of all points satisfying the constraint become a surface.

There is a #link("https://en.wikipedia.org/wiki/Tetrahedron")[tetrahedron] $A B C D$ of edge length $1$ in a space. A $4$-ellipse surface is the set of all points of the same space whose sum of distances to the $4$ points $A$, $B$, $C$ and $D$ is $4$ (see the blue solid in the picture).

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p449.png")
  #v(5pt)
]

Find the enclosed volume and surface area of the closed surface above. Give your answer rounded to $6$ digits after the decimal point.

Answer format: [volume],[surface area]

Example: `4.188790,12.566371` for a sphere of radius $1$.
]


// Problem #450
#problem-block(number: 450)[
Let $A$ be an infinite sequence of matrices $A:=(A_1,A_2,dots)$.

$A_i$ has $x_i$ rows and $x_(i+1)$ columns, where
$ x_n = 5000 + (r_n mod 1000) $
and
$ r_1 = 2, quad r_n = r_(n-1)^2 mod 98765431 med (n >= 2). $

Let $C(n)$ be the minimum cost of matrix multiplication of $A_1,dots,A_n$. (see #link(<p438>)[Problem 438] for the cost.)

For example, $x_1=5002$, $x_11=5053$, $C(3)=257423728320$ and $C(10)=1290936750576$.

Find $C(6543)$.
]


// Problem #451
#problem-block(number: 451)[
One of the most famous formulae for computing $pi$ is $pi\/4 = 4 dot arctan(1\/5) - arctan(1\/239)$ due to John Machin (1706) who used it to compute $100$ decimal places.

We can rewrite it as $arctan(1\/239)=-arctan(1\/1)+4 dot arctan(1\/5)$.

It turns out that many integers like $239$ have an inverse which can be decomposed as a linear combination of Arctan of inverses.

A few examples:
#par(leading: 11pt)[
$arctan(1/3) = arctan(1) - arctan(1/2)$ \
$arctan(1/7) = -arctan(1) + 2 dot arctan(1/2)$ \
$arctan(1/8) = arctan(1)-arctan(1/2)-arctan(1/5)$ \
$arctan(1/13) = arctan(1)-arctan(1/2)-arctan(1/4)$ \
$arctan(1/17) = -arctan(1)+2 dot arctan(1/2)-arctan(1/12)$ \
$arctan(1/18) = arctan(1)-2 dot arctan(1/2)+arctan(1/5)$ \
$arctan(1/21) = arctan(1/4)-arctan(1/5)$ \
$arctan(1/30) = arctan(1)-arctan(1/2)-arctan(1/4)-arctan(1/23)$ \
$arctan(1/31) = arctan(1/5)-arctan(1/6)$ \
$arctan(1/32) = -arctan(1)+2 dot arctan(1/2)-arctan(1/9)$
]

The irreductible numbers, those which cannot be decomposed this way are called Størmer numbers. Thus, the inverse of every number which is not a Størmer number can be expressed as a linear combinaison of Arctan of inverse of smaller irreductible integers.

What makes John Machin's formula particularily efficient is the fact that it contains few terms and the numbers involved are not too small: the convergence of the Arctan serie is then quite fast.

Let's define the cost of a formula as the sum of the inverse of the distinct integers without $1$. \
$C(32)=1/2+1/9+1/32=0.642361$

Numbers like $21$ or $31$ are not suitable for a computation of $pi$ as they do not include the number $1$ in their decomposition, their cost will be infinity.

What are the $10$ most efficient numbers less than $20000$?

Answer format: comma separated list in ascending order of cost

Example: `41,46,75,17,32,7,68,93,43,57` (for numbers less than $100$).
#par(leading: 11pt)[
$C(41)=0.6077235772 -> arctan(1/41)=arctan(1)-2 dot arctan(1/2)+2 dot arctan(1/12)$ \
$C(46)=0.6421095008 -> arctan(1/46)=-arctan(1)+2 dot arctan(1/2)-arctan(1/12)-arctan(1/27)$ \
$C(75)=0.6421212121 -> arctan(1/75)=-arctan(1)+2 dot arctan(1/2)-arctan(1/12)-arctan(1/22)$ \
$C(17)=0.6421568627 -> arctan(1/17)=-arctan(1)+2 dot arctan(1/2)-arctan(1/12)$ \
$C(32)=0.6423611111 -> arctan(1/32)=-arctan(1)+2 dot arctan(1/2)-arctan(1/9)$ \
$C(7)=0.6428571429 -> arctan(1/7)=-arctan(1)+2 dot arctan(1/2)$ \
$C(68)=0.6813725490 -> arctan(1/68)=2 dot arctan(1)-3 dot arctan(1/2)-arctan(1/6)$ \
$C(93)=0.6899193548 -> arctan(1/93)=arctan(1)-2 dot arctan(1/2)+arctan(16)-arctan(1/80)$ \
$C(43)=0.6899224806 -> arctan(1/43)=arctan(1)-2 dot arctan(1/2)+arctan(1/6)$ \
$C(57)=0.7175438596 -> arctan(1/57)=-2 dot arctan(1)+3 dot arctan(1/2)+arctan(1/5)$
]

*[My timing: < 10 sec]*
]


// Problem #452
#problem-block(number: 452)[
Let the following sequence:
- $c_1=2$
- $c_n=c_(n-1) dot (c_(n-1)+n+140) \/ n$

What is the first index $n$ such as $c_n$ is not an integer? \
How many digits does the integer part of $c_n$ have?

Answer format: `n,number of digits`

*[My timing: < 1 sec]*
]


// Problem #453
#problem-block(number: 453)[
There are two random vectors $bold(a)=[a_1,a_2]$ and $bold(b)=[b_1,b_2]$. Let $s$ be the dot product of these two vectors, that is $s=bold(a) dot bold(b)=a_1 b_1+a_2 b_2$.

Assume $a_1, a_2, b_1, b_2$ are mutually independent random variables of the uniform distribution on the interval $[0, 2]$. Find the probability of value $s$ less than $5$ and the expected value of $s$. Give your answer rounded to $8$ digits after the decimal point.

Answer format: [probability],[expected value] \
(sample input: `0.12345678,1.23456789`)

Thanks to *baihacker* for the idea.
]


// Problem #454
#problem-block(number: 454)[
Assume a point $D$ *inside* an equilateral triangle $A B C$ of side length $sqrt(3)$. Then we can use the three segments $A D$, $B D$ and $C D$ to build a new triangle $P Q R$.

When point $D$ is in the center of triangle $A B C$, the area of triangle $P Q R$ is $sqrt(3)\/4$, which is the maximum value for all possible positions of $D$; and the circumference of $P Q R$ is $3$, which is the minimum value. Moreover, when point $D$ is close to the vertex of triangle $A B C$, the area of triangle $P Q R$ is close to zero; and the circumference of $P Q R$ is close to its maximum value $2 sqrt(3)$.

Assuming that point $D$ is chosen randomly (with *uniform distribution*) within triangle $A B C$, find the expected area and circumference of triangle $P Q R$. Give your answers rounded to $8$ digits after the decimal point.

Answer format: [expectation of area],[expectation of circumference] \
(sample input: `0.43301270,3.46410162`)
]


// Problem #455
#problem-block(number: 455)[
Let $D(x,y,z) = x^3 + y^3 + z^3 - 3 dot x dot y dot z$.

It can be proven that for any integers $x_1,y_1,z_1,x_2,y_2,z_2$ there exist integers $x_3,y_3,z_3$ such that: \
$D(x_1,y_1,z_1) dot D(x_2,y_2,z_2) = D(x_3,y_3,z_3)$

Let $N$ be the number of $(x_3,y_3,z_3)$ triples of the form $x_3<=y_3<=z_3$ for $D(x_1,y_1,z_1) dot D(x_2,y_2,z_2) = D(x_3,y_3,z_3)$.

Find the $N$ and the sum of all $z_3$ values for $D(34040,34238,35404) dot D(34551,34564,34567)$.

Answer format: `N,sum`

Example: `12,548` for $D(1,2,3) dot D(11,12,13)$

*[My timing: < 1 m]*
]


// Problem #456
#problem-block(number: 456)[
An automatic typewriter can generate a random digit string by generating a sequence of random digits and concatenating them together. Each digit is chosen independently from $0$ to $9$ with probability $1\/55$, $2\/55$, $3\/55$, $4\/55$, $5\/55$, $6\/55$, $7\/55$, $8\/55$, $9\/55$ and $10\/55$, respectively. The generation is stopped as soon as a specific pattern occurs in the random string.

$D(n)$ is a string consisting of first $n$ digits of $pi$. For example, $D(3)=314$, $D(10)=3141592653$.

Let $E(n)$ be the expected length of the generated random string for the string pattern $D(n)$. For example, $E(3)=4159.375$, $E(10)=104702034619.87625 dots.h.c$. Usually $E(n)$ is a decimal number.

Let $S(n)$ be $E(n)$ rounded to the nearest integer. You are given $S(3)=4159$, $S(10)=104702034620$ and $S(50)=1812330404172820790558529569081392090013172561045583$.

Find $S(10000)$.

As the answer is a very big number, use the following condensed representation: \
(First 10 digits)[(number of remaining digits)](Last 10 digits) \
For instance, the representation of $2^127$ is: `1701411834[19]5884105728`.

Answer format: [condensed representation of $S(10000)$]

Example: `1812330404[32]2561045583` for $S(50)$.
]


// Problem #457
#problem-block(number: 457)[
A DNA molecule is made of $2$ strands of nitrogenous bases: `A`, `C`, `G` or `T`.

Each base in the $1$st strand is associated with one in the 2nd according the following pairing rules:
- `A` with `T`
- `C` with `G`

Example:

```
T G C T A A C C G G
| | | | | | | | | |
A C G A T T G G C C
```

The $2$ strands are separated and broken into fragments of random length: \
`TGCTAACCGG => TGCT,AACC,GG` \
`ACGATTGGCC => ACGAT,TGG,CC`

Then all the fragments are shuffled. For instance: `CC,TGG,GG,TGCT,ACGAT,AACC`.

You are given the following 65 fragments:

```
CCGTCCGTTGCCC, TGTCTTGAGCTTCGTGCTGAGCACATGTAATCATAC, TTATT
TGTACAAGCGCGTTTAATGTTATACCAGCATTAATCTACTC
GTGAGTGAATGGGTTATAAACCGGCTGTACGGCTGTTGGGTGTACTGGAGCTACTGCCA
AGATGGTCAACCCTGCCACATCTCCTCAACATC, ACCTCTTCTCGCCTTCACCAGCAAGCATGATT
CGAAGCATTGAACAATTT, ACCGAACGACTGACATACGCTTTTAAATTCTACCAGTTGGGACGGTGTAGAG
ACGTAGGGTATACATTAAACAACCGTTATAGATAT
TTTACACTTCTTGTCTTTCCACCGCAATGTCTGTATTCTAAGACGCA
GGCCGGCTCTAACCTCGAGACCTATAAATCCAAATTGTAGCTTCAAG, CACACT
ACATCTGACAGTGTGGAAAAAGACGTTATGTTAGCGGGGT, GTGAGTAC
ATTTGGATCGCCTGTCGCGTGATTATTAAATCGGGCATAGCTG
CACATTCTTCCAACGCCACAAAATGCTGACTTCTAA, GCCATTTCGCGCCCGGCCGAGATTGGAGCTCTGGATATTT
CGACTCGTGTA, CAATCGCGGATATCTTGAGTATACG, ATTAAGCACCCTCGCTAAGGGCGGAAC
TAACTCGGTGCTTCGTAACTTGTTAAATGGCTTGCTGACTGTATGCGAAAATTTA, CATTAGTATGTGGAGAAGAGC
ATACAGATTTAATAATACGTAGCTAGGGAGCCACTCATGGTGTAAGAAGGTTGCG
AGTTCGCTGCAACTCCGGGCAGAA, GTGTTTTACGACTGAAGATTTGTAGACTGTCACACCTTTTTCTGCAA
AAAGGTGGCGTTACAGACATAAGATTCTGCGTGCAGCAAACAGTAAGTGGAGACTGAG, ATTACGTTAATC, CGCC
CCGACTGGCAGGCAACGGGAAATGTGAAGAACAG, AATAATTTAGCCCGTATCGACCACAGGT, ATCCCTCG
CGCGTGCCTATGCCGACCATATTGCATCCCATATGTAATTTGTTGGCAATATCTATAT
GGGCCTAAACGAGTTCTGTCAAAGGCTCAT, AGGTTTAACATCGA
CACTTACCCAATATTTGGCCGACATGCCGACAACCCACATGACCTCGATG, CCCCGGCGTACAGCTAAAAATAGGCA
CAGGTGTTAGCGCCTATAGAACTCATATGCATTCAAGGAG, GGCT
CGCTTAATCGCCCGGCAGTTATCTTCCGCAGC
CAAGGTCCCGCGAGTAGGCCCGGATTTGCTCAAGACAGTTTCCGAGTAGCAGC, GATAACTCGGTGGCACCA
ACGGTATC, TGGTAACAATGCTGCCAAGAG
GCATCCACTATTCATTGCGGATTAGTGGGTTCCAGGGCGCTCATCC, AGGGCATGTG
CGTCGAATAAACATGTTCGCGCAAATTACAATATGGTCGTAATTAGATGAGATTGAGCCA
GGAAGTGGTCGTTCGTACTAACTATTGAGCCACCGTGGTGCGCACGGATACGGCTGGTATA
CAAAAGAAGTCCTGCACACCGTGTTAAACCTAGCGGACAGCGCACT, AATACCGGGGGAGCCTACGTCT
TAAGTTCCT, GAGTTGTAGTATGTCTAAATTATTATGCATCG
TACAATCGCCCCAGCGAATTAGCGGGCCGTCAATAGAAGGCGTCGGGCTGA
GACTCGTTTTCTTCAGGACGTGTGGCACA
CGACGTTGAGGCCCGTCTTTTATGGCCCCCTCGGATGCAGATAATGCAATTAGGT, GTGTCCACCGA, TAGTC
CGTCGTTTGTCATTCACCTCT, AAATTTTCCCCATCGCGCGTCTGCGTAGGTGATAAGTAACGCCTAATCACC
TTAAAAGGGGTAGCGCGCAGAC, CCGGTAAAGCGCG, ATGTCCA, TTGACCATTGTTACGACGGTTCTCTA
TAATTCGTGGGAGCGATTCC, CCGTACACGGGGCCGCATGTCGATTTTTATCCGTACAGAACTCGAAGCA
```

Your task is to reconstruct the original DNA molecule from the fragments.

Answer format: the MD5 hash (lowercase hexa) of the comma separated fragments for the $1$st strand in alphabetic order (The solution is unique)

Example: `cfe6feb5eb9e4d176ac4bdc81b722ede` (MD5 for `ACGAT,TGG,CC`).

*[My timing: instant]*
]


// Problem #458
#problem-block(number: 458)[
Let
$ S(n) = sum_(i = 1)^n sum_(j = 1)^n phi (i dot j) $
where $phi(x)$ is #link("https://en.wikipedia.org/wiki/Euler%27s_totient_function")[Euler's totient function].

You are given $S(2)=phi(1 times 1)+phi(1 times 2)+phi(2 times 1)+phi(2 times 2)=5$, $S(50)=696335$ and $S(5000) mod 1000000007=397838656$.

Find $S(50000000) mod 1000000007$.
]


// Problem #459
#problem-block(number: 459)[
Three circles $C_2$, $C_3$ and $C_4$ are placed inside a larger circle $C_1$ such that each pair of circles is tangent to one another and the inner circles do not overlap.

#align(center)[
  #v(5pt)
  #image(width: 200pt, "figures/p459_1.png")
  #v(5pt)
]

We can repeatedly fill the interstices between mutually tangent circles with further tangent circles and generate a circle packing. Denote the curvature of a circle be the reciprocal of its radius. Interestingly, every circle in such a packing would have integer curvature if the curvatures of four mutually tangent circles $C_1$, $C_2$, $C_3$ and $C_4$ are integers, and we call such a packing an integral circle packing.

The figure below shows an integral circle packing with curvatures of four circles $-6$, $11$, $14$ and $15$ (each circle is labeled with its curvature and only part of circles are shown).

#align(center)[
  #v(5pt)
  #image(width: 250pt, "figures/p459_2.png")
  #v(5pt)
]

Define an integer quadruple $(a, b, c, d)$ with $a<0<b<=c<=d$ representing the curvatures of initial four mutually tangent circles $C_1$, $C_2$, $C_3$ and $C_4$, which determines the integral circle packing. The negative value here represents the negative curvature of the bounding circle. For example, the above integral circle packing can be represented as $(-6, 11, 14, 15)$.

If greatest common divisor of $a, b, c, d$ is $1$, the quadruple $(a, b, c, d)$ is called *primitive* quadruple. A quadruple $(a, b, c, d)$ is a *root* quadruple if the curvature of any circle other than initial four circles in the circle packing is not less than $d$. For example, $(-6, 11, 14, 15)$ is a root quadruple but $(-6, 11, 14, 23)$ not, because there exists curvature value $15$ in the circle packing which is less than $23$.

All curvatures (negative signs are omitted) of an integral circle packing form an infinite integer set. Especially there are infinite primes in the set if the quadruple for packing is primitive. For example, for primitive quadruple $(-3, 4, 12, 13)$, the primes in the set are $3, 13, 37, 61, 109, 157, 181, 229$ and so on. Let $"SP"(a,b,c,d,n)$ be sum of distinct primes no more than $n$ in the set with quadruple $(a, b, c, d)$. For instance, $"SP"(-3, 4, 12, 13, 100) = 114$. Let $S(t,n)$ be sum of all $"SP"(a,b,c,d,n)$ with *primitive root* quadruple $(a, b, c, d)$ satisfying $d<=t$.

You are given $S(10, 100) = "SP"(-1, 2, 2, 3, 100) + "SP"(-2, 3, 6, 7, 100) + "SP"(-3, 5, 8, 8, 100) + "SP"(-4, 8, 9, 9, 100) = 299 + 251 + 90 + 147 = 787$.

Find $S(50,10^7)$.
]


// Problem #460
#problem-block(number: 460)[
See #link(<p459>)[Problem 459 --- Integral circle packings 1] for the concept of integral circle packing and quadruple.

According to the circles generated sequence in a circle packing, define the generation as below: the $4$ mutually tangent circles are the first generation; fill the $4$ interstices between them with $4$ tangent circles forming the second generation; and repeatedly fill the interstices between mutually tangent circles of previous generation with further tangent circles forming the new generation. The circles of the first $4$ generations are shown below. Actually the number of new generated circles in the $n$-th ($n>=2$) generation is $4 times 3^(n-2)$.

#align(center)[
  #v(5pt)
  #image(width: 350pt, "figures/p460_1.png")
  #v(5pt)
]

For a certain generation in a circle packing, a convex hull can be formed from the set of center points of all circles. The figures below show the convex hull (blue polygon) of the $2$nd and $3$rd generation for integral circle packing with quadruple $(-6, 11, 14, 15)$, respectively.

#align(center)[
  #v(5pt)
  #image(width: 350pt, "figures/p460_2.png")
  #v(5pt)
]

It can be calculated that the area of convex hull of the $2$nd generation is $670\/23023$, and that of the $3$rd generation is $45650065\/866875849$. In fact, the area of convex hull of any generation for any integral circle packing is a rational number.

Define $R(a,b,c,d,n)$ be the ratio of the area of convex hull of the $n$-th generation to the area of the bounding circle with quadruple $(a,b,c,d)$. For example, $R(-6, 11, 14, 15, 2) = (670\/23023)\/(pi\/62) = 0.3334767170$, and $R
(-6, 11, 14, 15, 3) = (45650065\/866875849)\/(pi\/62) = 0.6034442099$. Obviously the area ratio tends to 1 when $n$ tends to infinity. Let $S(t,n)$ be sum of all $R(a,b,c,d,n)$ with *primitive root* quadruple $(a,b,c,d)$ satisfying $d<=t$.

You are given $S(10, 3) = R(-1, 2, 2, 3, 3) + R(-2, 3, 6, 7, 3) + R(-3, 5, 8, 8, 3) + R(-4, 8, 9, 9, 3)$$ = 2.2572820988$ (rounded to $10$ digits after the decimal point).

Find $S(50,10)$. Give your answer rounded to $8$ digits after the decimal point.
]


// Problem #461
#problem-block(number: 461)[
Define a sequence $b_n$ as below: $b_0=c, b_n=b_(n-1)^2-2 med (n>=1)$, where $c$ is a positive integer greater than or equal to $3$.

Let infinite sum $s$ be
$
s = sum_(n = 0)^infinity 1/(product_(k = 0)^n b_k) = 1/b_0 + 1/(b_0 b_1) + 1/(b_0 b_1 b_2) + 1/(b_0 b_1 b_2 b_3) + dots.h.c
$
It can be proved that the infinite sum is convergent and is an irrational number for all possible values of $c$.

$s$ can be represented as an infinite continued fraction and corresponding convergents are denoted by $p_n\/q_n$ ($n>=0$, $p_n$ and $q_n$ are coprime). For example, for $c = 6$, $s = 0.1715728752 dots.h.c$, and the first several convergents are $p_0\/q_0 = 0\/1, p_1\/q_1 = 1\/5, p_2\/q_2 = 1\/6, p_3\/q_3 = 5\/29$ and so on.

Let $P(c,n)$ and $Q(c,n)$ be numerator and denominator of the $n$-th convergents $p_n\/q_n$ of $s$ with value $c$, respectively. For instance, $P(6,3) = 5$, $Q(6,3) = 29$. Given Fibonacci sequence $f_n$ defined as $f_1=1$, $f_2=1$, $f_n=f_(n-1)+f_(n-2) (n>=3)$. The value of this sequence is no less than $3$ from the $4$-th item.

Let the sum $"SP"(m,n)=sum_(i=4)^m P(f_i,n)$ and $"SQ"(m,n)=sum_(i=4)^m Q(f_i,n)$. You are given $"SP"(5,10) = 606$, $"SQ"(5,10) = 2784$, $"SP"(10,100) mod 1000000007 = 774200907$, $"SQ"(10,100) mod$$ 1000000007 = 830200702$.

Find $"SP"(10^5,10^18)$ and $"SQ"(10^5,10^18)$, both modulo $1000000007$.

Answer format: [$"SP"(10^5,10^18)$],[$"SQ"(10^5,10^18)$]

Example: `774200907,830200702` for $"SP"(10,100)$ and $"SQ"(10,100)$.

Thanks to *czp* for the idea.
]


// Problem #462
#problem-block(number: 462)[
Given a *regular* $n$-sided polygon ($n>=3$) billiard table and its vertices are labeled $A_1, A_2, dots, A_n$ in anticlockwise direction. A billiard ball is placed in the middle of the edge $A_1 A_2$. When it is launched at a certain angle, it keeps moving and reflects off the sides of the table. Suppose the table and the ball are ideal, and reflection and incidence angles are the same when bouncing off the edge.

Let's take an equilateral triangle table ($n = 3$) as an example.

#align(center)[
  #v(5pt)
  #image(width: 250pt, "figures/p462.png")
  #v(5pt)
]

When the ball is launched at angle $60$ degrees, it hits the edge $A_2 A_3$ and $A_3 A_1$, and just returns to start point. For the $n$-sided polygon, there exists a continuous launch angle range such that the ball hits edge $A_2 A_3, A_3 A_4, dots, A_(n-1) A_n$ in turn and return to edge $A_1 A_2$ at last. For the equilateral triangle table, the minimum launch angle is $40.893394649131$ degrees, and the maximum one is $73.897886248014$ degrees. See blue arrows in above figure.

Let $D(n)$ be the length of launch angle range satisfying above rule for a regular $n$-sided polygon, in degrees. You are given $D(3)=33.004491598883$, $D(10)=1.866152295275$ and $D(50)=0.072102098755$.

Find $sum_(n=3)^2018 D(n)$. Give your answer rounded to $10$ digits after the decimal point.
]


// Problem #463
#problem-block(number: 463)[
A river forming a bend has the following shape:
- bank $b_1$ passes at points $(0,0)$ and $(9,9)$
- bank $b_2$ passes at point $(0,2)$ and is parallel to $b_1$
- bank $b_4$ passes at points $(0,13)$ and $(9,9)$
- bank $b_3$ passes at point $(0,12)$ and is parallel to $b_4$

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p463.png")
  #v(5pt)
]

We want to build a road between points $A (2,15)$ and $B (7,2)$. The constraint is that bridges over the river must be perpendicular to the banks. What is the shortest possible distance $(A,B)$?

Give your answer rounded to $10$ digits after the decimal point.
]


// Problem #464
#problem-block(number: 464)[
An integer equilateral triangle is decomposable if it can be split in $2$ integer triangles.

For instance, the triangle $(8,8,8)$ can be decomposed as $(8,3,7) + (8,5,7)$.

#align(center)[
  #v(-5pt)
  #image(width: 400pt, "figures/p464.png")
  #v(-20pt)
]

How many triangles (`T`) with side $<=10^7$ are decomposable? \
Which triangle (`L`) has the largest number of decompositions? (if multiple possibilities, give the largest one) \
How many decompositions (`D`) does it possess?

For instance, the triangle $(2592,2592,2592)$ has $3$ decompositions:
- $(2592, 2457, 297) + (2592, 2457, 2295)$
- $(2592, 2322, 702) + (2592, 2322, 1890)$
- $(2592, 2268, 972) + (2592, 2268, 1620)$

Answer format: `T,L,D`

You are given: `364,960,8` for triangles with side $<=1000$.

*[My timing: 20 sec]*
]


// Problem #465
#problem-block(number: 465)[
$A B C$ is a right triangle with sides $3$, $4$ and $5$. There are $3$ random points ($D$, $E$ and $F$) on the three sides assumed to be uniformly distributed: $D$ on $A B$, $E$ on $B C$ and $F$ on $A C$.

Draw the three lines segments from vertices to these random points: $A E$, $B F$ and $C D$. The intersection of $A E$ and $B F$ is the point $P$. The intersection of $A E$ and $C D$ is the point $Q$. The intersection of $C D$ and $B F$ is the point $R$.

What is expected area of the $P Q R$ triangle?

Answer format: decimal number rounded to $10$ digits after the decimal point.
]


// Problem #466
#problem-block(number: 466)[
Two segments $A B$ and $C D$ of length $a$ are joined by a perpendicular $B C$ of length $b$. The segment $A D$ is the diagonal of a square of side $c$.

#align(center)[
  #v(-25pt)
  #image(width: 350pt, "figures/p466.jpg")
  #v(-25pt)
]

For instance, is $a=23$ and $b=94$, then $c$ is an integer $c=74$.

In the picture, points $B$ and $C$ fall inside the square, but it is not necessarily the case in general.

How many coprime pairs $(a,b)$ produce an integer side square where the side $c<=10^7$?

Answer format: $"count",sum a,sum b$

You are given: `161,36737,73474` for a threshold of $1000$.

*[My timing: 1 sec]*
]


// Problem #467
#problem-block(number: 467)[
Jack has $10$ magical beans.

On day $0$, he plants his beans in his garden.

Each day, each bean has a probability $1\/2$ to grow into a beanstalk.

What is the expected number of days required for all the beans turn into beanstalks?

Answer format: `P/Q` where $P$ and $Q$ are coprime
]


// Problem #468
#problem-block(number: 468)[
Let $p$ be a permutation of the set ${1,2,3,dots,n}$. We call the sum $D_k(p)=sum_(i=1)^n |p_i-i|^k$ the total displacement with $k$-th power of $p$. For example, if $p = (4,2,1,3)$, $D_1(p)=|4-1|+|2-2|+|1-3|+|3-4|=6$, $D_2(p)=|4-1|^2+|2-2|^2+|1-3|^2+|3-4|^2=14$, $D_3(p)=|4-1|^3+|2-2|^3+|1-3|^3+|3-4|^3=36$.

For any positive integer $n$, assume every possible permutation $p$ of the set ${1,2,3,dots,n}$ is uniformly distributed. Let $E(n)$ be the expected value of $D_1(p)+D_2(p)+D_3(p)$. You are given $E(2)=3$, $E(3)=40\/3$, $E(5)=432\/5$, and all $E(n)$ are rational number. Let $F(n)$ be the numerator of $E(n)$ with $E(n)$ be fraction in lowest terms. So, $F(2)=3$, $F(3)=40$, $F(5)=432$ and so on.

Let $S(n)=sum_(i=1)^n F(i)$. Find $S(12345678987654321) mod 1000000007$.

Thanks to *baihacker* for the idea.
]


// Problem #469
#problem-block(number: 469)[
Let $frak(S)(n)$ be the set of all permutations of $[1..n]$.

The order of a permutation $p$ is the smallest integer $e$ such as $p^e="Id"$. We apply the permutation $e$ times to itself and get the identity permutation ${1,2,dots,n}$.

For $frak(S)(4)$: \
$"Order"(1 med 2 med 3 med 4) = 1$ \
$"Order"(1 med 2 med 4 med 3) = 2$ \
$"Order"(1 med 3 med 2 med 4) = 2$ \
$"Order"(1 med 3 med 4 med 2) = 3$ \
$"Order"(1 med 4 med 2 med 3) = 3$ \
$"Order"(1 med 4 med 3 med 2) = 2$ \
$"Order"(2 med 1 med 3 med 4) = 2$ \
$"Order"(2 med 1 med 4 med 3) = 2$ \
$"Order"(2 med 3 med 1 med 4) = 3$ \
$"Order"(2 med 3 med 4 med 1) = 4$ \
$"Order"(2 med 4 med 1 med 3) = 4$ \
$"Order"(2 med 4 med 3 med 1) = 3$ \
$"Order"(3 med 1 med 2 med 4) = 3$ \
$"Order"(3 med 1 med 4 med 2) = 4$ \
$"Order"(3 med 2 med 1 med 4) = 2$ \
$"Order"(3 med 2 med 4 med 1) = 3$ \
$"Order"(3 med 4 med 1 med 2) = 2$ \
$"Order"(3 med 4 med 2 med 1) = 4$ \
$"Order"(4 med 1 med 2 med 3) = 4$ \
$"Order"(4 med 1 med 3 med 2) = 3$ \
$"Order"(4 med 2 med 1 med 3) = 3$ \
$"Order"(4 med 2 med 3 med 1) = 2$ \
$"Order"(4 med 3 med 1 med 2) = 4$ \
$"Order"(4 med 3 med 2 med 1) = 2$

What is the largest order for the elements of $frak(S)(85)$? \
For which permutation do we get this order? Give the index in lexicographic order ($0$-origin) of the 1st one.

Answer format: Maximal order,Index modulo $10^9$

Example: `420,257453673` for $frak(S)(20)$.

*[My timing: 40 sec]*
]


// Problem #470
#problem-block(number: 470)[
See #link(<p469>)[Problem 469 - Permutation Order I] for definitions.

Let $frak(A)(n,p)$ be the number of permutations of $[1..n]$ with order $p$.

We have: \
$frak(A)(7,1)=1$ \
$frak(A)(7,2)=231$ \
$frak(A)(7,3)=350$ \
$frak(A)(7,4)=840$ \
$frak(A)(7,5)=504$ \
$frak(A)(7,6)=1470$ \
$frak(A)(7,7)=720$ \
$frak(A)(7,10)=504$ \
$frak(A)(7,12)=420$

Find the last $10$ significant (before trailing $0$s) digits of $frak(A)(1000,641)$.

*[My timing: < 100 ms]*
]


// Problem #471
#problem-block(number: 471)[
The Kimberling sequence is defined as follow.

We start with $S_0={1,2,3,4,5,6,7,8,9,10,dots}$. We build $S_(k+1)$ from $S_k$: for $i$ in $[1..k]$, we take $S_k [k+i]$ and $S_k [k-i]$, ignoring $S_k [k]$, then we take the rest of the sequence.

The first iterations are: \
$0 quad (bold(1)) med 2 med 3 med 4 med 5 med 6 med 7 med 8 med 9 med 10 med 11 med 12 med 13 med 14 med 15 med 16 med 17 med 18 med 19 med 20 med 21 med 22 med 23 med 24 med 25 med 26 med 27 med 28 med 29 med 30 dots$ \
$1 quad 2 med (bold(3)) med 4 med 5 med 6 med 7 med 8 med 9 med 10 med 11 med 12 med 13 med 14 med 15 med 16 med 17 med 18 med 19 med 20 med 21 med 22 med 23 med 24 med 25 med 26 med 27 med 28 med 29 med 30  dots$ \
$2 quad 4 med 2 med (bold(5)) med 6 med 7 med 8 med 9 med 10 med 11 med 12 med 13 med 14 med 15 med 16 med 17 med 18 med 19 med 20 med 21 med 22 med 23 med 24 med 25 med 26 med 27 med 28 med 29 med 30 dots$ \
$3 quad 6 med 2 med 7 med (4) med 8 med 9 med 10 med 11 med 12 med 13 med 14 med 15 med 16 med 17 med 18 med 19 med 20 med 21 med 22 med 23 med 24 med 25 med 26 med 27 med 28 med 29 med 30 dots$ \
$4 quad 8 med 7 med 9 med 2 med (bold(10)) med 6 med 11 med 12 med 13 med 14 med 15 med 16 med 17 med 18 med 19 med 20 med 21 med 22 med 23 med 24 med 25 med 26 med 27 med 28 med 29 med 30 dots$ \
$5 quad 6 med 2 med 11 med 9 med 12 med (bold(7)) med 13 med 8 med 14 med 15 med 16 med 17 med 18 med 19 med 20 med 21 med 22 med 23 med 24 med 25 med 26 med 27 med 28 med 29 med 30 dots$ \
$6 quad 13 med 12 med 8 med 9 14 med 11 med (bold(15)) med 2 med 16 med 6 med 17 med 18 med 19 med 20 med 21 med 22 med 23 med 24 med 25 med 26 med 27 med 28 med 29 med 30 dots$ \
$7 quad 2 med 11 med 16 med 14 med 6 med 9 17 (bold(8)) med 18 med 12 med 19 med 13 med 20 med 21 med 22 med 23 med 24 med 25 med 26 med 27 med 28 med 29 med 30 dots$ \
$8 quad 18 med 17 med 12 med 9 med 19 med 6 med 13 med 14 med (bold(20)) med 16 med 21 med 11 med 22 med 2 med 23 med 24 med 25 med 26 med 27 med 28 med 29 med 30 dots$ \
$9 quad 16 med 14 med 21 med 13 med 11 med 6 med 22 med 19 med 2 med (bold(9)) med 23 med 12 med 24 med 17 med 25 med 18 med 26 med 27 med 28 med 29 med 30 dots$ \
$10 quad 23 med 2 med 12 med 19 med 24 med 22 med 17 med 6 med 25 med 11 med (bold(18)) med 13 med 26 med 21 med 27 med 14 med 28 med 16 med 29 med 30 dots$

The Kimberling sequence is formed by the diagonal elements. \
$K=1,3,5,4,10,7,15,8,20,9,18,24,31,14,28,22,42,35,33,46,53,6,36,23,2,55,62,59,76,$$65,dots$

It is conjectured that $K$ contains exactly all the integers.

Let $O(n)$ the index of the 1st occurrence of $n$ in $K$: $K_O(n)=n$.

One can verify that: \
$O(2) = 25$ \
$O(3) = 2$ \
$O(19) = 49595$

Find $O(16268)$.

*[My timing: 20 sec]*
]


// Problem #472
#problem-block(number: 472)[
An infinite sequence ${S_1,S_2,S_3,S_4,dots}$ is said palindromic if: for every $n_0$ there is $n>=n_0$ such as ${S_1,S_2,S_3,S_4,dots,S_n}$ is palindromic.

It can be proved that for any irrational $alpha$, the sequence $floor(alpha dot n) - floor(alpha dot (n - 1))$ for $n>=1$ is palindromic. $floor(x)$ is the integer part of $x$.

For the irrational $upright(e)=2.71828 dots.h.c$, this sequence is palindromic for following indexes:
- $1$ -- $1$
- $2$ -- $4$
- $3$ -- $11$
- $4$ -- $18$
- $5$ -- $25$
- $6$ -- $32$
- $7$ -- $71$

Find the $10^9$-th index. Give your answer modulo $10^10$.

You are given `3352820698` the $10^2$-th index.

*[My timing: 15 sec]*
]


// Problem #473
#problem-block(number: 473)[
It can be proved that any real number $x in (0,1]$ can be written uniquely in the form:
$ x = 1/a_1 - 1/(a_1 times a_2) + 1/(a_1 times a_2 times a_3) - dots.h.c $
$a_i$ being a sequence of strictly increasing integers.

For example, $upright(e)-2 = 1/1 - 1/(1 times 3) + 1/(1 times 3 times 6) - 1/(1 times 3 times 6 times 14) + 1/(1 times 3 times 6 times 14 times 142) - dots.h.c$.

What is $a_100$ when developping the Champernowne constant $C=0.123456789101112 dots.h.c$.

Give your answer in compressed form: $10$ first digits[omitted digits count]$10$ last digits

Example: `1701411834[19]5884105727` for $M_127=2^127-1$.


*[My timing: 7 sec]*
]


// Problem #474
#problem-block(number: 474)[
It has recently been proved (2016) that: \
_For $g >= 5$ every integer can be decomposed as a sum of $3$ palindromes in base $g$._

For instance: $123456789=40904+4708074+118707811$ (base $10$).

How many such decompositions $n=x+y+z$ and $0<x<=y<=z$ are there for $n=314159263$ (in base $10$).

Answer format: `count,x,y,z` \
decomposition with the largest $x$

*[My timing: 15 sec]*
]


// Problem #475
#problem-block(number: 475)[
$display(mat(delim: "[", 11, 29, 43, 73; 31, 67, 17, 41; 61, 13, 59, 23; 53, 47, 37, 19))$ is the first (in lexicographic order) $4 times 4$ magic square using the smallest distinct prime numbers $>10$.

Find the first (in lexicographic order) $4 times 4$ magic square using the smallest distinct prime numbers $>100$.

Answer format: comma separated list of the matrix elements

Example: `11,29,43,73,31,67,17,41,61,13,59,23,53,47,37,19`

*[My timing: 70 sec]*
]


// Problem #476
#problem-block(number: 476)[
A sequence $S$ of positive integers, not necessarily distinct is a good sequence if:
- when $k in S$, then $(k-1) in S$ for $k>=2$
- the first occurence of $k-1$ in $S$ appears before the last occurence of $k$

Examples: ${3,1,3,1,2}$ is not a good sequence: the $1$st occurence of $2$ is after the last $3$.

The following sequences are good: \
${2,2,1,3,2}$ \
${1,3,2,1,3}$ \
${3,1,1,2,3}$ \
${3,2,3,1,2}$ \
${1,2,1,3,1}$

In a sequence $S={a_1,a_2,a_3,dots,a_n}$, $a_j$ is a record if it is greater than all elements before it: $forall i<j,a_i<a_j$.

The sequence ${4,7,5,1,6,8,2,3}$ contains $3$ records: $4,7,8$.

Amongst all good sequences with 100 elements in ${1,2,3,dots,100}$, how many have $3$ records?

Answer format: give the last $10$ significant digits \
(before trailing $0$s)
]


// Problem #477
#problem-block(number: 477)[
See #link(<p476>)[Problem 476 - Records in Good Sequences] for definitions.

Amongst all the good sequences with 100 elements in ${1,2,3,dots,100}$, how many have a maximum element $=50$?

Answer format: give the answer modulo $10^10$
]


// Problem #478
#problem-block(number: 478)[
Given $2$ dice $A,B$, we define $frak(P)(A,B)$ as the probability of rolling a strictly higher value with $A$ than $B$. If $A={2,2,4,4,9,9}$ and $B={1,1,6,6,8,8}$ we have $frak(P)(A,B)=5/9>1/2$.

Thus the probability to win with $A$ is greater than with $B$. We write: $A>B$.

We add a third die $C={3,3,5,5,7,7}$. We have: $frak(P)(B,C)=5/9$, $frak(P)(C,A)=5/9$.

Therefore: $A>B>C>A$.

A triple of dice is called non-transitive if: $A>B>C>A$, $frak(P)(A,B)=frak(P)(B,C)=frak(P)(C,A)$.

Of course if $(A,B,C)$ is such a triple, so is $(B,C,A)$ and $(C,A,B)$. These $3$ triples are considered equivalent.

We consider dice with values in range ${1,2,3,4,5,6,7,8}$.

How many dictinct non-transitive triples are there? \
There are triples where all faces for $A$ have a distinct value. What is the last one in lexicographic order? \
Between the $3$ possible representation for a triple $(A,B,C)$, $(B,C,A)$ and $(C,A,B)$, we choose the one where $A$ is the first in lexicographic order.

Answer format: `Count/(die1)(die2)(die3)`

Example: `9999/(9,9,9,9,9,9)(9,9,9,9,9,9)(9,9,9,9,9,9)`

You are given there are $104$ distinct non-transitive triples for the set ${1,2,3,4,5,6}$.

*[My timing: 80 sec]*
]


// Problem #479
#problem-block(number: 479)[
Let $n$ be a number with $2 d$ digits. Let $a$ be the first $d$ digits of this number and $b$ the last $d$ digits.

For example: \
$n=#text(fill: red)[$140$]#text(fill: green.darken(20%))[$400$] quad d=3 quad a=#text(fill: red)[$140$] quad b=#text(fill: green.darken(20%))[$400$]$

This number has an interesting property such that $n = b^2 - a^2$.

How many numbers less than $10^50$ have this interesting property?

Answer format: $"cnt",sum n$

*[My timing: \~ 2 s]*
]


// Problem #480
#problem-block(number: 480)[
Let $f(m)$ denote the number of integer pairs $(x,m)$ such that there exists a positive integer $y$ satisfies $x^y equiv 0 med (mod m)$, where $x$ and $m$ are both positive integers and $1<=x<=m$. For example, $f(12) = 2$, as two pairs $(6, 12)$ and $(12, 12)$ meet the condition.

Define $S(n)=sum_(m=1)^n f(m)$. You are given $S(10) = 16$ and $S(1000) = 5764$.

Find $S(10^14)$.

Thanks to *baihacker* for the idea.
]


// Problem #481
#problem-block(number: 481)[
Let $upright(gamma)=0.5772156649 dots.h.c$ the Euler-Mascheroni constant.

How many terms in the #link("https://en.wikipedia.org/wiki/Farey_sequence")[Farey sequence] of order $n$ are there such as: $a/b<upright(gamma)$ for $n=10^9$?

You are given $175452524024$ for $n=10^6$.

*[My timing: 30 sec]*
]


// Problem #482
#problem-block(number: 482)[
The #link("http://mathworld.wolfram.com/PrueferCode.html")[Prüfer code] is a very compact way to represent a #link("http://mathworld.wolfram.com/LabeledTree.html")[labeled tree].

We can represent a tree as a string with the following rules: (Pseudo BNF) \
`tree = node | node '(' tree [ ',' tree ] ')'` \
`node = an integer`

For examples: \
`1(2(3(4,5)))` \
`1(2(3),4,5)`

Consider a labeled tree with $n$ nodes labeled $1,2,dots,n$ in sequential order.

We can see its Prüfer code as the base $10$ representation of some integer.

For instance, the tree `1(2(3,4(5)),6(7),8)` has the following Prüfer code ${2,4,2,1,6,1} = 242161$.

Find all labeled trees with $10$ nodes whose Prüfer code correspond to a prime number.
Among these trees find those whose Prüfer code contain distinct values.

Answer format: sum of the values,(`/` delimited list of the trees in string representation - lexicographic order)

Example: `11006162,1(2(3(4(5(6)))),7(8))/1(2(3(4(5))),6(7(8)))` for 8 nodes.

*[My timing: instant]*
]


// Problem #483
#problem-block(number: 483)[
For definitions See #link(<p482>)[problem 482].

The file #link("http://www.rosecode.neocities.org/uploads/RC481_1.txt")[rc481.txt] contains $1000$ Prüfer codes.

Which code produces the labeled tree whose string representation is the largest in lexicographic order?

Answer format: the string representation corresponding to that code

Example: \
#text(size: 9.5pt)[
`1(3,9(8(25(28(26(7(12(10(19(4,6),24(11,17))),20(14(21(5,23(13(29)))))),22)))),18(15)),30(16(2),27))`
] \
This is the string representation for the 1st record of the file.

*[My timing: instant]*
]


// Problem #484
#problem-block(number: 484)[
Let $i_1,i_2,i_3,dots,i_n$ be a permutation of the set ${1,2,3,...,n}$ where $n$ is a positive integer. A permutation can also be viewed as a function $f$. We denote this permutation by the 2-by-$n$ array
$ f = mat(1,2,dots.h.c,n;i_1,i_2,dots.h.c,i_n) $
It maps number $1$ to $i_1$, number $2$ to $i_2$ and so on. When this function operates on a permutation of set $1,2,3,...,n$, that is $x_1,x_2,x_3,dots,x_n$, a new permutation $y_1,y_2,y_3,dots,y_n$ can be obtained. Here $y_1=f(x_1),y_2=f(x_2),dots,y_n=f(x_n)$.

For example, when $n=4$ and there is a permutation $2,4,1,3$. We make this permutation operate on a permutation $1,2,3,4$ continuously, and it will be
$ 1, 2, 3, 4 -> 2, 4, 1, 3 -> 4, 3, 2, 1 -> 3, 1, 4, 2 -> 1, 2, 3, 4 -> dots.h.c $
Obviously after $4$ operations the result permutation returns to the initial one.

Let $F(l,p)$ be the number of permutations of the set ${1,2,3,...,l}$ which makes the permutation $1,2,3,⋯,l$ returns to itself after $p$ operations. For instance, $F(4,3)=9$, as there are $9$ permutations meet the condition: $(1,2,3,4)$, $(1,3,4,2)$, $(1,4,2,3)$, $(2,3,1,4)$, $(2,4,3,1)$, $(3,1,2,4)$, $(3,2,4,1)$, $(4,1,3,2)$, $(4,2,1,3)$. You are also given $F(5,5)=25$, $F(10,6)=625176$, $F(20,11)=609493248001$.

Let $S(L,P)=sum_(l=1)^L sum_(p=1)^P F(l,p)$. Find $S(10000,1000) mod 1000000007$.

Thanks to *baihacker* for the idea.
]


// Problem #485
#problem-block(number: 485)[
A mountain has the shape of a cone. It has a height of $1000$ and the radius of the base is $300$.

A trail with the shortest length possible goes from point $A$ to point $B$ ($A$ and $B$ are on the same slant at a distance of $100$).

We can show that the trail starts to go uphill then downhill.

#align(center)[
  #v(10pt)
  #image(width: 250pt, "figures/p485.jpg")
  #v(10pt)
]

What are the length of the uphill part ($u$) and of the downhill part ($d$)?

Answer format: `u,d` \
rounded to $10$ digits after the decimal point
]


// Problem #486
#problem-block(number: 486)[
Let $S(p,n)$ denote the number of $n$-tuples of positive integers whose product is no larger than $p$. For example, $S(4,2)=8$, as there are eight $2$-tuples $(1, 1), (1, 2), (1, 3), (1, 4), (2, 1), (2, 2), (3, 1), (4, 1)$ meet the condition. You are also given $S(6,4)=39$, $S(10,10)=571$, $S(100,100) mod 1000000007=959337187$.

Find $S(10^12,10^12) mod 1000000007$.

Thanks to *baihacker* for the idea.

This problem was inspired by Problem 452 at Project Euler (https://projecteuler.net/problem=452)
]


// Problem #487
#problem-block(number: 487)[
A cylinder has a radius of $10$.

We place $4$ spheres of radius $5$ inside the cylinder.

#align(center)[
  #v(10pt)
  #image("figures/p487.png")
  #v(10pt)
]

What is the volume of water needed to cover exactly the spheres?

Give your answer rounded to $10$ digits after the decimal point.
]


// Problem #488
#problem-block(number: 488)[
Let $e_n$ the sequence of integers such as the decimal development of $2^(e_n)$ starts with the following digits: $66666 dots.h.c$

For instance we have: \
$e_1=224296 -> 2^224296=66666468242741993302 dots.h.c$ \
$e_5=620220 -> 2^620220=66666969606590729636 dots.h.c$

What is $e_1000000$?

*[My timing: 40 sec]*
]


// Problem #489
#problem-block(number: 489)[
#set enum(numbering: "(1)")

Let $F(N,M,R,D)$  be the number of good sequences which meet the following condition:
+ The sequence has $N$ elements
+ The maximum element in the sequence is equal to $M$
+ The sequence contains $R$ records
+ Each number occurs no more than $D$ times in the sequence
The good sequence and records are the same definition in #link(<p476>)[Problem 476].

For example, $F(4,2,2,2)$ is $3$. Only three sequences ${1,1,2,2}$, ${1,2,1,2}$, ${1,2,2,1}$ meet the conditions:
+ $4$ elements
+ Maximum element = $2$
+ $2$ records
+ Each number occurs no more than $2$ times
Notice ${1,2,1,1}$ is not in $F(4,2,2,2)$ because number $1$ occurs $3$ times; ${2,1,2,2}$ is not in $F(4,2,2,2)$ because it contains only $1$ record and number $2$ occurs $3$ times; ${2,3,1,2}$ is not in $F(4,2,2,2)$ because the maximum element is $3$.

You are given $F(11,8,3,2)=394581$ and F$(20,13,7,4) mod 1000000007=342894563$.

Find $F(80,47,13,10) mod 1000000007$.

Thanks to *C_K_Yang* for the idea.
]


// Problem #490
#problem-block(number: 490)[
Let $F_"idx" (n,k)$ denote the $k$-th term in the Farey sequence of order $n$. For example, the Farey sequence of order $5$ is ${0\/1, 1\/5, 1\/4, 1\/3, 2\/5, 1\/2, 3\/5, 2\/3, 3\/4, 4\/5, 1\/1}$, and the $7$-th term is $3\/5$, so $F_"idx" (5,7)=3\/5$. You are also given $F_"idx" (12,31)=7\/11$, $F_"idx" (123,3141)=82\/121$.

Find $F_"idx" (1234567890,314159265358979323)$. The answer should be represented as an irreducible fraction.

Thanks to *czp* for the idea.
]


// Problem #491
#problem-block(number: 491)[
Consider the Diophantine equation $x^2 + 13 x y + y^2 = z^2$.

How many solutions are there with $0<x<y<10^7$ ($x,y,z$ coprime).

Answer format: $"count",sum x,sum y,sum z$

You are given: `28989,580750261,1448965526,3481052101` for a threshold of $10^5$.

*[My timing: 20 sec]*
]


// Problem #492
#problem-block(number: 492)[
The sequence $G={1,2,2,3,3,4,4,4,5,5,5,dots}$ is defined by: $G_n=$ number of occurences of $n$ in the sequence.

$G_4=3 =>$ the number $4$ occurs $3$ times in the sequence.

What is $m=G_123456789101112$? \
Find the smallest $n$ such as $G_n=123456654321$.

You are given `1684,128276792` for `123456,123321`.

Answer format: `m,n`

*[My timing: 1.5 sec]*
]


// Problem #493
#problem-block(number: 493)[
A permutation $P$ of ${1,2,dots,n}$ is said prime if:
- $P_1=1$
- $P_n=n$
- $forall i<n$, $P_i+P_(i+1)$ is a prime number

${1,6,5,8,9,2,3,4,7,10}$ is a prime permutation.

How many prime permutations are there for $n=21$?

*[My timing: 30 sec]*
]


// Problem #494
#problem-block(number: 494)[
How many triples $(x,y,z)$ with $0<x<y<z<=123456789$ and $(x,y,z)$ coprime are there such as: $(x^4+y^4+z^4)^2=2 times (x^8+y^8+z^8)$.

Answer format: `count`

*[My timing: 3 sec]*
]


// Problem #495
#problem-block(number: 495)[
Let
$ S(n) = sum_(k = 1)^n k! $

You are given $S(10)=4037913$, $S(100) mod 1000000000039=947219250081$.

Find $S(314159265358) mod 1000000000039$.
]


// Problem #496
#problem-block(number: 496)[
Let $x_0$ a rational number $>1$. We define $x_(n+1)=x_n dot ceil(x_n)$ where $ceil(x)$ is the smallest integer $>=x$.

It is conjectured that $forall x_0$, $x_n$ is eventually an integer for $n$ large enough.

For instance, if $x_0=8/7$, $x_1=16/7$, $x_2=48/7$, $x_3=48$. The sequence starting with $8/7$ produces an integer after $3$ steps.

How many steps are necessary if we start with $3012/3011$?

You are given $18$ steps for $6/5$.

*[My timing: 5 sec]*
]


// Problem #497
#problem-block(number: 497)[
Let $nu$ a positive irrational number and $m$ a positive integer.

A pair of integers $(a,b)$ is said _$m$-good_ if $a dot ceil(nu dot b) - b dot floor(nu dot a) = m$ ($ceil(x)$ and $floor(x)$ are respectively the smallest integer $>=x$ and the largest integer $<=x$).

A pair of positive integers $(a,b)$ is said _$m$-excellent_ if $(a,b)$ is _$m$-good_ and neither $(a-b,b)$ nor $(a,b-a)$ are _$m$-good_.

How many _$m$-excellent_ pairs ($m=123456789101112$) are there if $nu=0.5772156649015314 dots.h.c$?
]


// Problem #498
#problem-block(number: 498)[
This problem is about Freecell streaks (in this #link("https://www.freecell.net/")[site] in particular).

A run of wins is called a *streak*.

The standard Freecell game has $8$ columns of cards and $4$ free cells. This version is commonly referred to as $8 times 4$. There is a wide range of other variants too. The number of columns of cards may range from $4$--$13$, and the number of free cells may range from zero to $10$. Thus, a game with $13$ columns of cards and no free cells is referred to as a $13 times 0$.

The game is currently scaled so that when your streak is small, you are automatically given somewhat easier games. As your streak increases, the difficulty level will go up until at a streak of $50$ you will be playing complete random deals (difficulty level $10$). Here's the progression:

#table(
  columns: (auto, auto),
  align: center,
  inset: 5pt,
  table.header([*Streak*], [*Difficulty*]),
  [$0$--$9$], [$5$],
  [$10$--$19$], [$6$],
  [$20$--$29$], [$7$],
  [$30$--$39$], [$8$],
  [$40$--$49$], [$9$],
  [$>=50$], [$10$ (random)]
)

There is a unique degree of "winnability" for each variant. $12$-sum games such as the standard $8 times 4$ are usually pretty winnable. But when you trend down into the $<10$ sum games and such, winnability gets pretty dicey. $5 times 4$ games, a $9$-sum variant, are only rarely winnable.

At any level there are $2^15$ different games for any variant (numbered $0$ to $32767$).

What is average streak length for $10 times 2$ variant assuming you can win any "winnable" game dealed randomly? The number of unwinnable games by level for $10 times 2$ given as below:

#table(
  columns: (auto, auto),
  align: center,
  inset: 5pt,
  table.header([*Level*], [*Count*]),
  [$5$], [$1$],
  [$6$], [$2$],
  [$7$], [$5$],
  [$8$], [$6$],
  [$9$], [$12$],
  [$10$], [$18$]
)

Input format: streak length rounded to $15$ digits after the decimal point

See also: #link("https://www.freecell.net/f/c/instructions.html#streaks")[streaks info]
]


// Problem #499
#problem-block(number: 499)[
There is a parabola with equation $y^2 = 4 x$. A line segment of length $8$ moves along the parabola, with one end on the curve, and always perpendicular to the curve. The figure below shows the trajectory of the line segment when one end of it moving through the whole curve.

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p499.png")
  #v(5pt)
]

In the whole process of moving the line segment, some points were swept exactly $3$ times. Interestingly, these points form a connected region which looks like a ginkgo leaf (blue line around in the figure).

Find the area of the "ginkgo leaf". Give your answer rounded to $10$ digits after the decimal point.

Thanks to *czp* for the idea.
]


// Problem #500
#problem-block(number: 500)[
Let binary function $f(x,y)=(x y -1)\/(x+y-1)$. There are infinite $(x,y)$ pairs of positive integers such that $f(x,y)$ is integer. For example, $f(1,1)=0$, $f(3,5)=2$, $f(5,17)=4$ and so on.

Find all such $(x,y)$ pairs for $1<=x<=y<=50000000$.

Answer format: [number of pairs],[sum of x of all pairs], [sum of y of all pairs]

Example: `258,56772,129736` for $1<=x<=y<=1000$.
]


// Problem #501
#problem-block(number: 501)[
We define the hyper factorial function $!^!$ as $n!^! = 1^1 times 2^2 times dots.h.c times n^n$.

What is $200000000!^! mod 2147483647$.

You are given: $60629238 equiv 1000000!^! mod 2147483647$.

*[My timing: 60 sec]*
]


// Problem #502
#problem-block(number: 502)[
The #link("https://en.wikipedia.org/wiki/Dragon_curve")[Dragon curve] is a fractal curve obtained by repeatedly appending a rotated version of itself.

Here are the first 4 iterations of this curve:

#align(center)[
#grid(
  columns: (180pt, 180pt),
  align: center+horizon,
  inset: 5pt,
  image(width: 100pt, "figures/p502_1.png"),
  image(width: 50pt, "figures/p502_2.png"),
  [Iteration *1*], [Iteration *2*],
  [#v(10pt)], [#v(10pt)],
  image(width: 120pt, "figures/p502_3.png"),
  image(width: 150pt, "figures/p502_4.png"),
  [Iteration *3*], [Iteration *4*]
)]

At each iteration (starting at $4$), this curve contains closed squares grouped in contiguous blocks.

For instance, at iteration $8$ we have:

#align(center)[
  #v(5pt)
  #image(width: 250pt, "figures/p502_5.png")
  #v(5pt)
]

The number of squares in each group starting from the initial point of the curve are: $1,3,6,14,33,6,3,1$.

What is the number of squares in each group at iteration $15$?

Answer format: comma delimited list

Example: `1,3,6,14,33,6,3,1` at iteration $8$.

*[My timing: 30 sec]*
]


// Problem #503
#problem-block(number: 503)[
Given two positive integers $n$ and $k$, define function
$
T(n,k) = product_(a_1 = 1)^k product_(a_2 = 1)^k dots.h.c product_(a_n = 1)^k phi (product_(i = 1)^n a_i)
$
where $phi(x)$ is #link("https://en.wikipedia.org/wiki/Euler%27s_totient_function")[Euler's totient function].

For example, $T(2,3) = phi(1 times 1) dot phi(1 times 2) dot phi(1 times 3) dot phi(2 times 1) dot phi(2 times 2) dot phi(2 times 3) dot phi(3 times 1) dot phi(3 times 2) dot phi(3 times 3) = 192$. And you are given $T(10,10) mod 1000000007=7103300$.

Find $T(10^7,10^7) mod 1000000007$.

Thanks to *C_K_Yang* for the idea.
]


// Problem #504
#problem-block(number: 504)[
Let $lambda$ a sequence of non increasing integers. It can be seen as the size of a #link("https://en.wikipedia.org/wiki/Jagged_array")[jagged array].

Let $mu$ a sequence of $sum lambda_i$ consecutive integers starting with $1$.

We fill in the array with the elements of $mu$ using the following rules:
- in each row the elements must be in ascending order (equality permitted)
- in each column, the element are strictly in acending order

We defined $K(lambda,mu)$ as the number of such arrays. It is called the #link("https://en.wikipedia.org/wiki/Kostka_number")[Kostka number].

If $lambda={3,2}$ and $mu={1,2,3,3,4}$, there are $3$ possible arrays:

```
1  3  3       1  2  3       1  2  4
2  4          3  4          3  3
```

Therefore $K({3,2},{1,2,3,3,4})=3$.

What is $K({6,4,4,3},{1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9}$?

*[My timing: 4 sec]*
]


// Problem #505
#problem-block(number: 505)[
A partition of an integer $n$ will be represented by a non increasing sequence of integers.

The partitions of $7$ in lexicographic order are:
- $1$ - $1 med 1 med 1 med 1 med 1 med 1 med 1$
- $2$ - $2 med 1 med 1 med 1 med 1 med 1$
- $3$ - $2 med 2 med 1 med 1 med 1$
- $4$ - $2 med 2 med 2 med 1$
- $5$ - $3 med 1 med 1 med 1 med 1$
- $6$ - $3 med 2 med 1 med 1$
- $7$ - $3 med 2 med 2$
- $8$ - $3 med 3 med 1$
- $9$ - $4 med 1 med 1 med 1$
- $10$ - $4 med 2 med 1$
- $11$ - $4 med 3$
- $12$ - $5 med 1 med 1$
- $13$ - $5 med 2$
- $14$ - $6 med 1$
- $15$ - $7$
and in anti-lexicographic order:
- $1$ - $7$
- $2$ - $6 med 1$
- $3$ - $5 med 2$
- $4$ - $5 med 1 med 1$
- $5$ - $4 med 3$
- $6$ - $4 med 2 med 1$
- $7$ - $4 med 1 med 1 med 1$
- $8$ - $3 med 3 med 1$
- $9$ - $3 med 2 med 2$
- $10$ - $3 med 2 med 1 med 1$
- $11$ - $3 med 1 med 1 med 1 med 1$
- $12$ - $2 med 2 med 2 med 1$
- $13$ - $2 med 2 med 1 med 1 med 1$
- $14$ - $2 med 1 med 1 med 1 med 1 med 1$
- $15$ - $1 med 1 med 1 med 1 med 1 med 1 med 1$

The $10$th partition is $4,2,1$ in the $1$st case and $3,2,1,1$ in the $2$nd.

What are the $123456789$th partition of $123$ in lexicographic and anti-lexicographic order?

Answer format: (comma delimited values)/(comma delimited values)

Example: `4,2,1/3,2,1,1`

*[My timing: 11 sec]*
]


// Problem #506
#problem-block(number: 506)[
$(430,1824,1874)$ is a special #link("https://en.wikipedia.org/wiki/Pythagorean_triple")[Pythagorean triple].

Indeed, we have: \
$430^2+2133331200=46190^2$ \
$1824^2+2133331200=46224^2$ \
$1874^2+2133331200=46226^2$

We call *special* a Pythagorean triple if there exists a positive integer $t$ such as for each element $e$ of the triple $e^2+t$ is a square.

There can exist multiple integers for a given triple. For instance, the triple $(24531,30600,39219)$ is special with the values $133453264$ and $119200745664$.

Find all special Pythagorean triples $(a,b,c)$ with $a+b+c<2000000$ (a triple is counted for each distinct $t$).

Answer format: $"Count",sum t$

You are given: `18,17172343737` for a threshold of $10000$.

*[My timing: < 1 min.]*
]


// Problem #507
#problem-block(number: 507)[
A point is choosen inside a square.

From that point $4$ lines are drawn to the middle of each side of the square, defining $4$ regions.

The areas of these regions are $72108967,65123128,69011033$.

What is the side of the square?
]


// Problem #508
#problem-block(number: 508)[
The Diophantine equation $x^2-6 x y+y^2=1$ has inifinitly many solutions in positive integers $x<=y$.

Find the $10^100$th.

Answer format: `x,y` \
give the last $10$ digits for each variable
]


// Problem #509
#problem-block(number: 509)[
Find all solutions of $x^2+y^2=1234567891011121613 dot (x-y)$ in positive integers.

Answer format: $x_1,y_1\/dots med x_n,y_n$ \
where $x_i$ are in ascending order

Example: `387,225/850,225` for the equation $x^2+y^2=1237 dot (x-y)$.

*[My timing: instant]*
]


// Problem #510
#problem-block(number: 510)[
Let $S(N)$ be the sum of $n$ ($1<=n<=N$) such that $sigma(n)-2n=-128$, where $sigma(n)$ is the sum of divisors function.

For example, $S(10^7)=11033992$.

Find $S(10^15)$.
]


// Problem #511
#problem-block(number: 511)[
Define a sequence an as below: $a_1=17$, $a_(n+1)=(a_n^4+6a_n^2+1)/(4a_n (a_n^2+1)) med (n>=1)$. Then $a_2=10657\/2465, a_3=2134495165562497\/1571545212141185, dots$. Obviously all numbers in this sequence are rational.

For a prime $p$ and a fully reduced fraction $a\/b$, define $Q(a\/b,p)$ to be the smallest positive $q$ for which $a b equiv q med (mod p)$. For example $Q(3\/5,109)=66$, because $5 times 66=330 equiv 3 med (mod 109)$ and $66$ is the smallest positive such number.

You are given $Q(a_2,1000000007)=877890477$, $Q(a_10,1000000007)=16332768$.

Find the sum of $Q(a_1234567891011121314,p)$ over all primes $p$ between $2000000000$ and $2000100000$.

Thanks to *czp* for the idea.
]


// Problem #512
#problem-block(number: 512)[
Let $S(N)$ be the sum of $n$ ($1<=n<=N$) such that $sigma(n)-2n=128$, where $sigma(n)$ is the sum of divisors function.

For example, $S(10^7)=25029284$.

Find $S(10^15)$.
]


// Problem #513
#problem-block(number: 513)[
Let $B(n)$ be the $n$-th Bell number, which can be computed as $B(0)=1$ and $B_(n+1)=sum_(k=0)^n binom(n,k)B_k$ for $n>=0$.

For example, $B(5)=52$ and $B(10)=115975$.

Let $f(N,M):=B(N) mod M$.

You can verify that $f(5,24)=4$, $f(10,8!)=35335$ and $f(10^4,12!)=82759235$.

Find $f(10^7,30!) mod (10^9+7)$.
]


// Problem #514
#problem-block(number: 514)[
A gracious numbering of a tree with $N$ vertices is defined as follow:
- each vertex is numbered by a number in $[0..N-1]$
- each edge being numbered by the difference, in absolute value, between the values of its two vertices, the values of the edges contain all integers in $[1..N-1]$ exactly once.

For the tree `A(B,C(D,E,F))`, here is an example of gracious numbering:

```
[A]  3
 +-B  4
 +-[C]  5
	  +-D  2
	  +-E  1
	  +-F  0
```

You can verify:

```
[AB] = 1
[AC] = 2
[CD] = 3
[CE] = 4
[CF] = 5
```

It is conjectured that there exists a gracious numbering for all trees.

How many gracious numberings are there for the following tree: `A(B(C,D(E,F)),G(H,I(J,K)))`?

```
[A]
 +-[B]
 |  +-C
 |  +-[D]
 |     +-E
 |     +-F
 +-[G]
	  +-H
	  +-[I]
	     +-J
	     +-K
```

*[My timing: 20 sec]*
]


// Problem #515
#problem-block(number: 515)[
Let $A_0(n)$ be the array of the binary representation of positive integer $n$.

For example, $A_0(1)=[1]$, $A_0(2)=[1,0]$ and $A_0(11)=[1,0,1,1]$.

Let $R(A)$ be the function that returns the array of run-lengths of the given array $A$.

For example, $R([1,0])=[1,1]$, $R([1,0,1,1])=[1,1,2]$ and $R([1,0,0,0,1])=[1,3,1]$.

Let $A_k(n):=R(A_(k-1)(n))$ for $k>=1$, and $M(n)$ be the minimum integer $k$ ($>=0$) such that $|A_k (n)|=1$, where $|A|$ denotes the length of $A$.

Finally, let $S(n):=sum_(i=1)^n M(i)$.

You can verify that $M(1)=0$, $M(2)=2$, $M(3)=1$, $M(11)=4$, $S(100)=346$ and $S(1234567)=6717538$.

Find $S(1234567654321)$.
]


// Problem #516
#problem-block(number: 516)[
A pandigital number in base $10$ is an integer that contains each of the digits from $0$ to $9$ (leading zero is not considered). Clearly there cannot be any pandigital numbers below $1023456789$. In other words, $1023456789$ is the smallest pandigital number. Pandigital numbers become more and more common as number gets bigger. In fact, the least number for which the proportion of pandigital numbers first reaches $1%$ is $1982653472320$.

Given two positive integers $m$, $n$ and $m>n$, Let $G(m,n)$ be the least number for which the proportion of pandigital numbers is at least $n\/m$. For instance, $G(100,1)=1982653472320$, $G(10,1)=108552671412935708$.

Find $sum_(i=2)^100 G(i,i-1)$. Since the answer can be very large, give your answer modulo $1000000033$.

Thanks to *C_K_Yang* for the idea.
]


// Problem #517
#problem-block(number: 517)[
Let $F(m,n,r,s)$ be the number of binary sequences containing:
- $m$ times the digit '$0$'
- $n$ times the digit '$1$'
- $r$ times the sequence '$00$'
- $s$ times the sequence '$11$'

For instance, $F(4,5,2,3) = 24$:
- $0 med 0 med 0 med 1 med 0 med 1 med 1 med 1 med 1$
- $0 med 0 med 0 med 1 med 1 med 0 med 1 med 1 med 1$
- $0 med 0 med 0 med 1 med 1 med 1 med 0 med 1 med 1$
- $0 med 0 med 0 med 1 med 1 med 1 med 1 med 0 med 1$
- $0 med 0 med 1 med 0 med 0 med 1 med 1 med 1 med 1$
- $0 med 0 med 1 med 1 med 0 med 0 med 1 med 1 med 1$
- $0 med 0 med 1 med 1 med 1 med 0 med 0 med 1 med 1$
- $0 med 0 med 1 med 1 med 1 med 1 med 0 med 0 med 1$
- $0 med 1 med 0 med 0 med 0 med 1 med 1 med 1 med 1$
- $0 med 1 med 1 med 0 med 0 med 0 med 1 med 1 med 1$
- $0 med 1 med 1 med 1 med 0 med 0 med 0 med 1 med 1$
- $0 med 1 med 1 med 1 med 1 med 0 med 0 med 0 med 1$
- $1 med 0 med 0 med 0 med 1 med 1 med 1 med 1 med 0$
- $1 med 0 med 0 med 1 med 1 med 1 med 1 med 0 med 0$
- $1 med 0 med 1 med 1 med 1 med 1 med 0 med 0 med 0$
- $1 med 1 med 0 med 0 med 0 med 1 med 1 med 1 med 0$
- $1 med 1 med 0 med 0 med 1 med 1 med 1 med 0 med 0$
- $1 med 1 med 0 med 1 med 1 med 1 med 0 med 0 med 0$
- $1 med 1 med 1 med 0 med 0 med 0 med 1 med 1 med 0$
- $1 med 1 med 1 med 0 med 0 med 1 med 1 med 0 med 0$
- $1 med 1 med 1 med 0 med 1 med 1 med 0 med 0 med 0$
- $1 med 1 med 1 med 1 med 0 med 0 med 0 med 1 med 0$
- $1 med 1 med 1 med 1 med 0 med 0 med 1 med 0 med 0$
- $1 med 1 med 1 med 1 med 0 med 1 med 0 med 0 med 0$

What is $F(777,555,333,111)$?

Answer format: the last $10$ digits before the trailing $0$ of this large number

You are given $7741694224$ for $F(77,55,33,11)$.
]


// Problem #518
#problem-block(number: 518)[
In mathematics, #link("https://en.wikipedia.org/wiki/Hypergraph")[hypergraph] is a generalization of a graph in which an edge can join any number of vertices (denoted as $m$), therefore introducing hyperedges.

In that case, the number of hyperedges of size $m$ that a complete hypergraph with $n$ many vertices has a more general formula, which boils down to well-know formula $n(n-1)/2$ for $m=2$.

Given that a complete hypergraph with $n=11$ number of vertices, it can be shown that the number of hyperedges of size $m=3$ is $165$. Then, what is the answer for $n=1007$ and $m=35$?

Note: This is rather an easy problem with an immediate solution, but serves as a conceptual introduction to prospective problems related to hypergraphs.
]


// Problem #519
#problem-block(number: 519)[
Let $P_n (X) = X^5 + F_(2n)X^4 + 2(F_(2n) - 2F_(n+1)^2)X^3 + 2F_(2n)(F_(2n)-2F_(n+1)^2)X^2 + F_(2n)^2 X + F_(2n)^3$ ($F_n$ is the $n$-th Fibonacci number).

Example: $P_4(X)=X^5+21X^4-58X^3-1218X^2+441X+9261$.

It can be proved that equation $P_n(X)=0$ has only integer roots.

Find the largest positive root of $P_1000 (X)=0$ (Give your answer mod $10^10$).
]


// Problem #520
#problem-block(number: 520)[
For $n$ a positive integer, the $q$-factorial is defined by
$
[n]_q ! &= product_(k = 1)^n [k]_q = product_(k = 1)^n sum_(i = 0)^(k - 1) q^i \
&= 1(1 + q)(1 + q + q^2) dots.h.c (1 + q +  dots.h.c  + q^(n - 1))
$

Let $S(n,q)=[n]_q !$. You are given $S(5,2)=9765$, $S(100,7) mod 1000000000039=850054509459$.

Find $S(123456789876,7) mod 1000000000039$.
]


// Problem #521
#problem-block(number: 521)[
Let $display(R(p, k) := (product_(i=1)^(p-1) (i^k + 1)) mod p)$.

Find $display(sum_(3 <= p <= 10^10) R(p, 20181026))$, where $p$ is prime.
]


// Problem #522
#problem-block(number: 522)[
Let $F={1,2,3,5,8,13,21,34,55,dots}$ the sequence of distinct Fibonacci numbers.

The number $1000$ can be decomposed in $15$ ways as a sum of elements of $F$
- $5,14$
- $3,4,14$
- $5,12,13$
- $1,2,4,14$
- $3,4,12,13$
- $5,10,11,13$
- $1,2,4,12,13$
- $3,4,10,11,13$
- $5,8,9,11,13$
- $1,2,4,10,11,13$
- $3,4,8,9,11,13$
- $5,6,7,9,11,13$
- $1,2,4,8,9,11,13$
- $3,4,6,7,9,11,13$
- $1,2,4,6,7,9,11,13$

For each decomposition, we give the indexes in $F$ ($0$-origin): \
${5,12,13} => 1000=F_5+F_12+F_13=13+377+610$

Find the number of decompositions of $1234568$ and give the middle one (if there is $n$ decompositions, give the decomposition $floor(n\/2)$). The 1st one has index $0$.
The decompositions are sorted by length, then lexicographically.

Answer format: count/(comma delimited list of indexes)

You are given: `15/3,4,10,11,13` for $n=1000$.

*[My timing: 50 sec]*
]


// Problem #523
#problem-block(number: 523)[
Arithmetic function $Omega(n)$ is the total number of prime factors of $n$, counting prime factors with multiplicity. For example, $Omega(3)=1$, $Omega(6)=2$, $Omega(72)=5$. Let $S(n)=sum_(x=1)^n Omega(x)$. You are given $S(10)=15$, $S(1000)=2877$.

Find $S(10^13)$.

Thanks to *baihacker* for the idea.
]


// Problem #524
#problem-block(number: 524)[
Let $C(n)$ denote the number of factorizations of $n$ into distinct factors greater than $1$.

For example, $C(24)=5$ since $24=2 times 12=2 times 3 times 4=3 times 8=4 times 6$.

Let $S(n):=sum_(i=2)^n C(n)$. You are given $S(10)=12$ and $S(10^4)=99733$.

Find $S(10^12)$.
]


// Problem #525
#problem-block(number: 525)[
Let $f(n)$ be the largest prime factor of $n$. For example $f(1)=0$, $f(6)=3$ and $f(30)=5$.

Define $display(S(k,n)=sum_(x_1=1)^n sum_(x_2=1)^n dots.h.c sum_(x_k=1)^n f(product_(i=1)^k x_i))$.

You are given $S(2,3) = f(1 times 1) + f(1 times 2) + f(1 times 3) + f(2 times 1) + f(2 times 2) + f(2 times 3) + f(3 times 1) + f(3 times 2) + f(3 times 3) = 21$, $S(3,10)=4790$, $S(6,10)=5697722$.

Find $S(9,10^9) mod 10^9$.

Thanks to *baihacker* for the idea.

This problem was inspired by Problem 642 at Project Euler (https://projecteuler.net/problem=642)
]


// Problem #526
#problem-block(number: 526)[
Let $C(N)$ be the number of positive integers $n>=2$ such that $n dot ("largest prime factor of" n)<=N$.

You are given that $C(10)=3$, $C(10^6)=9107$, $C(10^11)=34113192$ and $C(10^12)=188014194$.

Find $C(10^16)$.
]


// Problem #527
#problem-block(number: 527)[
Let $C(N)$ be the number of positive integers $n>=2$ such that $n dot ("largest prime factor of" n)^2<=N$.

You are given that $C(10)=1$, $C(10^6)=1228$, $C(10^11)=888908$ and $C(10^12)=3613513$.

Find $C(10^18)$.
]


// Problem #528
#problem-block(number: 528)[
Three segments, $[A B]$ of length $a$, $[B C]$ of length $b$ and $[C D]$ of length $c$ are perpendicular to each other.

The circle passing by the points $A,B,D$ has a radius $r$.

How many triples $(a,b,c)$ such as $1<=a,b,c<=1000$ and $"GCD"(a,b,c)=1$ are there such as $r$ is an integer?

Answer format: $"count",sum a,sum b,sum c$

You are given: `4,30,18,10` for a threshold of $10$.
]


// Problem #529
#problem-block(number: 529)[
An integer-sided triangle is a $1$-$2$-$3$ type Pythagorean triangle if its three sides $a,b,c$ satisfy the condition: $1 times a^2 + 2 times b^2 = 3 times c^2$.

For example, A triangle with three sides ${5,13,11}$ is a $1$-$2$-$3$ type Pythagorean triangle because $1 times 5^2 + 2 times 13^2 = 3 times 11^2$.

Find all distinct $1$-$2$-$3$ type Pythagorean triangles with perimeter $<=25000000$.

Answer format: $"count",sum $perimeter$$

You are given: `595,315428` for a threshold of $1000$.
]


// Problem #530
#problem-block(number: 530)[
There are $n$ ($n>1$) independent and identically distributed random variables whose cumulative distribution function is
$
F(x) = cases(
    0 quad & : x < 0,
    x^2 quad& : 0 <= x <= 1,
    1 quad& : x > 1
)
$

Let $R$ be the range for this random variables (difference between maximum and minimum). Let $E(n)$ be the expected value of $R$. Obviously $E(n)$ is between $0$ and $1$, furthermore it is rational number. You are given $E(2)=4\/15$ and $E(3)=2\/5$.

Find $E(20)$. Give your answer rounded to $10$ digits after the decimal point.

Thanks to *baihacker* for the idea.
]


// Problem #531
#problem-block(number: 531)[
A sequence generator start generating independent and identically distributed random variables whose cumulative distribution function is
$
F(x) = cases(
    0 quad & : x < 0,
    x^2 quad& : 0 <= x <= 1,
    1 quad& : x > 1
)
$

The cumulative sum is updated for every new generated number. When the sum is larger than $1$, the generator stops. Let $C$ denotes the count of generated numbers when it stops. For example, the probability for $C=3$ is $7\/45$.

Find the expected value of $C$. Give your answer rounded to $10$ digits after the decimal point.

Thanks to *baihacker* for the idea.
]


// Problem #532
#problem-block(number: 532)[
With $10$ $6$-faces dice (numbered $1$ to $6$), we can obtain all sums between $10$ and $60$.

The sum $35$ is the _champion_. It can be obtain in $4395456$ ways. it's actually the sum that can be obtained in the largest number of ways.

What is the champion if we use $n=100$ dice ?

Answer format: Champion, Number of ways

Example: `35,4395456`
]


// Problem #533
#problem-block(number: 533)[
On planet J, a year lasts for $D$ days. Holidays are defined by the two following rules.
1. At the beginning of the reign of the current Emperor, his birthday is declared a holiday from that year onwards.
2. If both the day before and after a day $d$ are holidays, then $d$ also becomes a holiday.

Initially there are no holidays. Let $f(n,d)$ be the number of methods such that all the days of the year are holidays after exactly $d$ days, with the year lasts for $n$ days.

You are given $f(4,2)=4$, $f(10,5)=240$, $f(50,100) mod 1000000007=263154905$.

Find $f(1000,10^12) mod 1000000007$.

Thanks to *baihacker* for the idea.

This problem was inspired by Problem 645 at Project Euler (https://projecteuler.net/problem=645)
]


// Problem #534
#problem-block(number: 534)[
In mathematics, a pandigital number is an integer that in a given base $B$ has each digit ${0,1,2,3,dots,B-1}$ at least once.

Given two positive integers $B$ and $L$, let $C(B,L)$ be the number of all the $L$-digit pandigital numbers in base $B$. For example, $C(3,3)=4$, there are only four $3$-digit pandigital numbers in base $3$, namely $(102)_3$, $(120)_3$, $(201)_3$
 and $(210)_3$.

Now we define a new function $D(B,N)=sum_(L=1)^N C(B,L)$.

You are given $D(5,10)=4865472$ and $D(123,321) mod 1000000007=844902472$.

Find $D(12345678,87654321) mod 1000000007$.

Note: leading zeroes are not allowed.
]


// Problem #535
#problem-block(number: 535)[
In mathematics, a pandigital number is an integer that in a given base $B$ has each digit ${0,1,2,3,dots,B-1}$ at least once.

Given two positive integers $B$ and $L$, let $S(B,L)$ denote the sum of all the $L$-digit pandigital numbers in base $B$. For example, $S(3,3)=66$, the sum of four $3$-digit pandigital numbers in base $3$ is $66$ since $(102)_3+(120)_3+(201)_3+(210)_3=(2110)_3=(66)_10$.

Now we define a new function $H(B,N)=sum_(L=1)^N S(B,L)$.

You are given $H(5,10)=24678960400080$ and $H(123,321) mod 1000000007=372652728$.

Find $H(12345678,87654321) mod 1000000007$.

Note: leading zeroes are not allowed.
]


// Problem #536
#problem-block(number: 536)[
A _Zumkeller_ number is a number such as the set of its divisors can be partitioned in two subsets of equal sum.

For instance, $"divisors"(108)=E={1,2,3,4,6,9,12,18,27,36,54,108}$ and $E=A union B$ with $A={2,12,18,108}$ and $B={1,3,4,6,9,27,36,54}$, $sum_(a in A) a = sum_(b in B) b = 140$.

Find all Zumkeller numbers in the range $[439050,439100]$.

Answer format: `count,sum`

*[My timing: 6 sec]*
]


// Problem #537
#problem-block(number: 537)[
For positive integer $k$ ($k>1$), we begin a sum $s$ at $0$ and repeatedly apply a process: we add one integer to $s$ from $1$ to $k$ with equal probability. The process ends when $s$ is a perfect square. For example, if $s$ goes through $0, 2, 3, 5, 7, 9$, the process ends at $s = 9$, and two squares $1$ and $4$ were skipped over.

Let $E(k)$ be the expected number of perfect squares skipped over when the process finishes for parameter $k$. For example, $E(2)=0.6832612735$ and $E(10)=4.9658004390$, both rounded to $10$ digits after the decimal point.

Find $E(100)$. Give your answer rounded to $10$ digits after the decimal point.

This problem was inspired by Problem 648 at Project Euler (https://projecteuler.net/problem=648)
]


// Problem #538
#problem-block(number: 538)[
Given a square tiled $n times n$ key lock screen and two integers $k_1$ and $k_2$
, where $1<=k_1<=k_2<=n^2$. Here are the rules for a valid pattern:
- Each pattern must connect at least $k_1$ keys and at most $k_2$ keys.
- All the keys must be distinct.
- If the line connecting two consecutive keys in the pattern passes through any other keys, the other keys must have previously selected in the pattern. No jumps through non selected key are allowed.
- The order of keys used matters.

For $n=3$, here are some invalid and valid patterns:

#align(center)[
  #v(5pt)
  #image(width: 400pt, "figures/p538.png")
  #v(5pt)
]

- Invalid move: $4 -> 1 -> 3 -> 6$. Line $1 -> 3$ passes through key $2$ which had not been selected in the pattern.
- Invalid move: $4 -> 1 -> 9 -> 2$. Line $1 -> 9$ passes through key $5$ which had not been selected in the pattern.
- Valid move: $2 -> 4 -> 1 -> 3 -> 6$. Line $1 -> 3$ is valid because it passes through key $2$, which had been selected in the pattern.
- Valid move: $6 -> 5 -> 4 -> 1 -> 9 -> 2$. Line $1 -> 9$ is valid because it passes through key $5$, which had been selected in the pattern.

Define $S(n,k_1,k_2)$ be the total number of unlock patterns of the $n times n$ key lock screen, which consist of minimum of $k_1$ keys and maximum $k_2$ keys. You are given $S(3,4,9)=389112$, which is the well-known total number of possible Android unlock patterns.

Find $S(5,4,25)$.

Thanks to *baihacker* for the idea.
]


// Problem #539
#problem-block(number: 539)[
Let $A(n)$ be the number of Egyptian fractions for which $1/x_1+1/x_2+...+1/x_k=3$ (for any $k>0$) with $0<x_1<x_2<dots.h.c<x_k<=n$.

For example, $A(24)=1$, there is only one Egyptian fraction which is equal to $3$.
$ 1/1+1/2+1/3+1/4+1/5+1/6+1/8+1/9+1/10+1/15+1/18+1/20+1/24=3 $

You are given $A(30)=25$.

Find $A(200)$.
]


// Problem #540
#problem-block(number: 540)[
First, some definitions are given:
- Simplex is the generalization of line-segments ($1$d) or triangles ($2$d) to $n$-dimensions. Tetrahedron is the well-known $3$-simplex. #link("http://mathworld.wolfram.com/Pentatope.html")[Pentatope] then is the $4$-simplex.
- Similarly, hypercube is the generalization of squares ($2$d) or cubes ($3$d) to $n$-dimensions. #link("http://mathworld.wolfram.com/Tesseract.html")[Tesseract] is the $4$-dimensional hypercube.

Then the question builds up as follows: \
In #link("http://mathworld.wolfram.com/LineLinePicking.html")[line line picking], the expected length of picked line-segment is shown to be $13$. \
Up one dimension, namely in #link("http://mathworld.wolfram.com/SquareTrianglePicking.html")[square triangle picking], the expected area of picked triangle is analytically given as $11/144$. \
Up one more, namely in #link("http://mathworld.wolfram.com/CubeTetrahedronPicking.html")[cube tetrahedron picking] it gets a bit complicated, but there is again an analytic answer for the expected volume of picked tetrahedron, $3977/216000-pi^2/2160$.

What about going one more up, namely tesseract pentatope picking? Since an analytic answer is hard to find, devise a numerical solution that gives the expected content of picked pentatope rounded to $6$ decimal places.

There might be some inaccuracy in my calculation for the time being ...
]


// Problem #541
#problem-block(number: 541)[
Given a rectangle $A B C D$ with side $A B = C D = a$ and side $B C = A D = b$. A curve is traced by point $D$ of the rectangle as point $A$ slides along the $x$-axis and point $B$ slides along the $y$-axis.

The curve with $a=2$ and $b=4$ is shown below.

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p541.png")
  #v(5pt)
]

There are $4$ lattice points $(-4,0),(-2,-4),(4,0),(2,4)$ on the curve above. Let $C(a,b)$ be the number of distinct lattice points on the curve with the rectangle side $a$
 and $b$. For example, $C(2,4)=4$, $C(5,5)=12$ and $C(6,3)=4$.

Define $S(n)=sum_(a=1)^n sum_(b=1)^n C(a,b)$. You are given $S(10)=432$, $S(50)=10960$ and $S(100)=44128$.

Find $S(10^8)$.
]


// Problem #542
#problem-block(number: 542)[
Given a square $A B C D$ with side length $a$. A curve is traced by point $D$
 of the square as point $A$ slides along the $x$-axis and point $B$ slides along the $y$-axis.

The curve with $a=5$ is shown below.

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p542.png")
  #v(5pt)
]

For positive integer $a$, it can be shown that at least $4$ lattice points are on the curve. An inscribed polygon can be formed by the lattice points on the curve. Let $R(a)$ be the ratio of the area of the inscribed polygon to the area of the closed curve with parameter $a$. Then $R(5)=0.942197263104$.

For $a<=100$, the maximum value of $R(a)$ is $0.992825486421$, with $a=65$.

Find the maximum value of $R(a)$ and corresponding value $a$ for $a<=10^15$. If there are two or more values of $a$ taking the maximum value $R$, give the smallest $a$.

Answer format: [value of $a$],[value of $R(a)$ (rounded to $12$ digits after the decimal point)]

Example: `65,0.992825486421` for $a<=100$.
]


// Problem #543
#problem-block(number: 543)[
Given two positive integers $a$ and $b$ with $a<=b$, let $P(N,a,b)$ denote the number of numbers not greater than $N$ and divisible by at least one number between $a$ and $b$ (inclusive).

For example, $P(15,3,5)=9$
- $3$ can divide $3,6,9,12,15$
- $4$ can divide $4,8,12$
- $5$ can divide $5,10,15$

There are $9$ numbers not greater than $15$ and divisible by at least one number between $3$ and $5$, namely $3,4,5,6,8,9,10,12,15$.

You are given $P(10^8,21,40)=41982923$.

Find $P(10^17,61,120)$.
]


// Problem #544
#problem-block(number: 544)[
Usually, in data processing multidimensional data (i.e. a multidimensional array) is vectorized and then processed. However, because of vectorization the spatial information in the data is lost.

For this problem, assume that you receive $1000$ distinct values after a vectorization of a $4$D array and you have no other information whatsoever. Then, how many possible spatial states are there for the original data? Give your answer in mod $100000009$.

Note: Assume that an array of size $1 times 1 times 1 times 1000$ or any other combination involving $1$, will also count as a $4$D array.
]


// Problem #545
#problem-block(number: 545)[
Consider all integer combinations of $a^b$ for $2<=a<=5$ and $1<=b<=5$:
$
2^1=2, 2^2=4,  2^3=8,   2^4=16,  2^5=32 \
3^1=3, 3^2=9,  3^3=27,  3^4=81,  3^5=243 \
4^1=4, 4^2=16, 4^3=64,  4^4=256, 4^5=1024 \
5^1=5, 5^2=25, 5^3=125, 5^4=625, 5^5=3125
$

If they are then placed in numerical order, with any repeats removed, we get the following sequence of $18$ distinct terms:
$ 2, 3, 4, 5, 8, 9, 16, 25, 27, 32, 64, 81, 125, 243, 256, 625, 1024, 3125 $

Given two integers $N>1$ and $M>0$, let $R(N,M)$ be the number of distinct terms in the sequence generated by $a^b$ for $2<=a<=N$ and $1<=b<=M$. For example, $R(5,5)=18$
, $R(10^2,10^3)=92715$ and $R(10^5,10^6)=99813359409$.

Find the last $20$ digits of $R(10^21,11^21)$.

This problem is a harder version of Project Euler Problem#29 (https://projecteuler.net/problem=29)
]


// Problem #546
#problem-block(number: 546)[
Using the $9$ digits $1,2,dots,9$ in that order and the $5$ operations #box(stroke: 0.5pt, inset: 3pt, baseline: 3pt)[`+-*/^`] (digits can be concatened too) it is possible to express some integers.

For instance, we have: \
`38706 = -12+3^4*(567-89)`

Can you find this representation for $88205$? (The solution is unique)

Answer format: as in the above example, without spaces and the minimum parentheses
]


// Problem #547
#problem-block(number: 547)[
Two blocks of mass $m$ and $M$ ($m<M$) are initially still.

#align(center)[
  #v(5pt)
  #image(width: 300pt, "figures/p547.jpg")
  #v(5pt)
]

We push the block $M$ in the direction of the block $m$. The block $m$ will hit the wall and bounces back toward $M$. After a certain number of collisions of $m$ between $M$ and the wall, $M$ will move to the right indefinitely.

Given that $m=1,M=123456789$, how many collisions are there?

It is assumed that the collisions are perfect: no friction, no energy loss.
]


// Problem #548
#problem-block(number: 548)[
In a circle, two perpendicular chords $A B$ and $C D$ intersect in $P$.

#align(center)[
  #v(5pt)
  #image("figures/p548.jpg")
  #v(5pt)
]

We have the following lengths:
- $||A P||=a$
- $||P B||=b$
- $||C P||=c$
- $||P D||=d$
and $a<b, c<d, a<c$.

Given that $a,b,c,d$ are positive integers $<=5000$, how many distinct circles (distinct radius) can we found?

You are given: `1913` for a threshold of $100$.

*[My timing: 60 sec]*
]


// Problem #549
#problem-block(number: 549)[
#set enum(numbering: "(1)")

Alice and Bob play a game with some piles of stones denoted by an array $[a_1,a_2,a_3,dots]$ where $a_i$ is the number of stones in the $i$-th pile. They take stones by turns and *Alice* always goes first. In each turn they must take *at least one stone* and at most a certain number of stones from a single pile. The game begins with taking stones from the first pile. If the first pile becomes empty, they are permitted to take stones from the second pile. If the second pile becomes empty, they are permitted to take stones from the third pile, and so on. The player who can not make a valid move loses.

We define an array $[a_1,a_2,a_3,dots]$ as the winning configuration if the first player (Alice) can force a win no matter what the second player (Bob) does, or the losing configuration if Bob can force a win no matter what Alice does. We also assume that Alice and Bob always play perfectly.

For example, $[2,1]$ is a winning configuration if they can take at most $2$ stones in his/her turn. The strategy is explained below.
+ Alice takes one stone in the first pile.
+ Bob takes one stone in the first pile.
+ Alice takes one stone in the second pile.
+ Bob can not make a valid move, Alice wins!!!

However, $[1,2]$ is a losing configuration if they are allowed to take at most $2$ stones in a single move. The strategy is described below.
+ Alice takes one stone in the first pile.
+ Bob takes two stones in the second pile.
+ Alice can not make a valid move, Alice loses!!!

We define the function $S(K,M,N)$ as the number of winning configurations $[a_1,a_2,a_3,dots]$ that satisfy the following conditions:
+ There are $K$ elements in the array(K piles of stones).
+ $1<=a_i<=M$ for $1<=i<=K$.
+ Alice and Bob can take no more than $N$ stones in a single move.

You are given $S(3,4,2)=39$, $S(5,5,3)=2084$ and $S(25,25,8) mod 1000000007 = 313496033$.

Find $S(10^18,11^18,1234567890) mod 1000000007$.

Thanks to *liuguangxi* for promoting this problem to larger $K,M,N$.
]


// Problem #550
#problem-block(number: 550)[
Let $F(B,L,D)$ be the sum of all the $L$-digit numbers in base $B$, the digit sum of which is $D$.

For example, $F(3,3,3)=79$. In base $3$, there are five $3$-digit numbers the digit sum of which is $3$. The sum of these five numbers is $79$: $(102)_3+(111)_3+(120)_3+(201)_3+(210)_3=(2221)_3=(79)_10$.

Now we define a new function $display(S(B,L,N) = sum_(p<=N, p "is prime") F(B,L,p))$.

For example, $S(5,5,11)=964140$ and $S(56,20,101) equiv 913761394 med (mod 1000004321)$.

Find $S(556678,999,12345701) mod 1000004321$.

Note: Leading zeroes are not allowed for a $L$-digit number in base $B$.
]


// Problem #551
#problem-block(number: 551)[
Given two positive integers $N$ and $M$ with $0<N<=M$, let $I(N,M)$ be the set which contains all natural numbers between $N$ and $M$ (inclusive). For example, $I(3,6)={3,4,5,6}$.

We define the product of a set as the product of all elements in that set, written as $P({dots})$ where ${dots}$ is a specific set. For example, $P(I(3,6))=3 times 4 times 5 times 6=360$.

Finally, We define a function $C(N,M,K)$ as the sum of product of sets over all $I(N,M)$'s subsets which contain exactly $K$ elements.

In other words, $display(C(N,M,K)=sum_(S in I(N,M), "len"(S)=K) P(S))$.

You are given $C(10,20,3)=549450$ and $C(100,200,10) mod med (10^18+3) = 491824643147614094$.

Find $sum_(i=1)^500 C(10^20,11^20,i)$. Give your answer modulo $(10^18+3)$.

*[My timing: 4 s (Python)]*
]


// Problem #552
#problem-block(number: 552)[
Given two natural numbers $a$ and $b$ with $1<a<=b$, let $J(a,b,N)$ be the set which contains all natural numbers not greater than N and not divisible by any number between $a$ and $b$ (inclusive). For example, $J(4,6,10)={1,2,3,7,9}$
- $4$ can divide $4$ and $8$
- $5$ can divide $5$ and $10$
- $6$ can divide $6$
Hence $4,5,6,8$ and $10$ will not appear in the set which $J(4,6,10)$ represents. Although they are all not greater than $10$.

We define the product of a set as the product of all elements in that set, written as $P({dots})$ where ${dots}$ is a specific set. For example, $P(J(4,6,10))=1 times 2 times 3 times 7 times 9=378$.

Finally, We define a function $D(a,b,N,K)$ as the sum of product of sets over all $J(a,b,N)$'s subsets which contain exactly $K$ elements.

In other words, $display(D(a,b,N,K)=sum_(S in J(a,b,N), "len"(S)=K) P(S))$.

You are given $D(5,8,20,3)=46035$ and $D(7,12,3000,10) mod med (10^18+3)=736056499082019203$.

Find $sum_(i=1)^150 D(11,20,11^20,i)$. Give your answer modulo $(10^18+3)$.

*[My timing: 18 s (Python)]*
]


// Problem #553
#problem-block(number: 553)[
By a partition of $m$, we mean an $n$-tuple: $p = [a_1, a_2, dots, a_n]$ of positive integers with $a_1 >= a_2 >= dots.h.c >= a_n$ and $a_1 + a_2 + dots.h.c + a_n = m$.

So to any partion $p$ of $m$, a Ferrer's diagram consisting of $m$ boxes is associated, arranged in $n$ rows in such a way that $i$-th row contains $a_i$ boxes.

Let $c$ be another partition of $m$ with $k$-tuple: $c = [b_1, b_2, dots, b_k]$ of positive integers with $b_1 >= b_2 >= dots.h.c >= b_k$ and $b_1 + b_2 + dots.h.c + b_k = m$.

If $p = [a_1, a_2, dots, a_n]$ and $c = [b_1, b_2, dots, b_k]$ are two arbitrary partitions of $m$, then by a semi-standard Young tableau of shape $p$ and content $c$, we mean any distribution of the numbers $1, 2, dots, m$ in the boxes of the associated Ferrer's diagram of $p$ in such a way that
1. every row is non-decreasing;
2. every column is (strictly) increasing; and
3. for any $1 <= i <= m$, the multiplicity of $i$ in the distribution is $b_i$.

For example if $m=6$: $p=[3,2,1]$ and $c=[2,2,2]$ (which means we have $2$ of $1$'s, $2$ of $2$'s and $2$ of $3$'s, totally $6$ of them).

```
1 1 2
2 3
3

1 1 3
2 2
3
```

The number of all semi-standard Young tableaux of shape $p$ and content $c$ is denoted by $K(p,c)$ here and it is called the Kostka coefficient or the Kostka number.

Let $p = [21,13,8,5,3]$. Find the following: \
$K(p, c_1)$ where $c_1 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,$$1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]$ \
$K(p, c_2)$ where $c_2 = [2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2]$ \
$K(p, c_3)$ where $c_3 = [3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,2]$ \
$K(p, c_4)$ where $c_4 = [4,4,4,4,4,4,4,4,4,4,4,4,2]$ \
$K(p, c_5)$ where $c_5 = [5,5,5,5,5,5,5,5,5,5]$

Answer format: $K(p,c_1),K(p,c_2),K(p,c_3),K(p,c_4),K(p,c_5)$
]


// Problem #554
#problem-block(number: 554)[
For a positive integer $n$, the primorial $n\#$ is defined as the product of all primes $<=n$: $2\#=2,3\#=6,6\#=30,dots$.

Define $display(F(n,p) = cases(n\# mod p med &\, quad "if" n < p\, , 1/p times (n\#) mod p med &\, quad "if" n >= p.))$

For example, $F(3,7)=2 times 3 mod 7=6$ and $F(7,3)=2 times 5 times 7 mod 3=1$.

For $P=998244353$, You are given $F(143,P)=675572163$ and $F(10^9,P)=574463500$.

Find $F(10^13,P)$.

*[My timing: \~ 20 s for $10^13$, \~ 65 s for $10^14$]*
]


// Problem #555
#problem-block(number: 555)[
Let $Q(n,m)$ be the number of distinct trees with $n$ nodes where each node can have no more than $m$ edges connected to it. Two trees are not considered distinct if they are #link("https://en.wikipedia.org/wiki/Isomorphism")[isomorphic].

For example, $Q(6,3)=4$. Four distinct trees are shown below.

#align(center)[
  #v(5pt)
  #image("figures/p555.png")
  #v(5pt)
]

You are given $Q(15,4)=4347$ and $Q(50,7) equiv 646618404 med (mod 1000000007)$.

Find $Q(1000,15) mod 1000000007$.
]


// Problem #556
#problem-block(number: 556)[
#set enum(numbering: "1)")

Given a positive integer $n$, let the following process:
+ We start with base $2$
+ Express $n$ in the current base
+ Increment the base by $1$
+ Take the number $n$ in this new base and decrement it by $1$
+ Go to step 2 until $n=0$

Here an example for $n=4$

#table(
  stroke: none,
  columns: (auto,)*5,
  table.hline(),
  [*Step*], [*Number*], [*Base*], [*Digits*], [*Comments*],
  table.hline(stroke: 0.5pt),
  [$1$], [$4$], [$2$], [$1,0,0$], [],
  table.hline(stroke: 0.5pt),
  [$2$], [$8$], [$3$], [$2,2$], [$8 = 1 times 3^2 + 0 times 3^1 + 0 - 1$],
  table.hline(stroke: 0.5pt),
  [$3$], [$9$], [$4$], [$2,1$], [$9 = 2 times 4^1 + 2 - 1$],
  table.hline(stroke: 0.5pt),
  [$4$], [$10$], [$5$], [$2,0$], [],
  table.hline(stroke: 0.5pt),
  [$5$], [$11$], [$6$], [$1,5$], [],
  table.hline(stroke: 0.5pt),
  [$6$], [$11$], [$7$], [$1,4$], [],
  table.hline(stroke: 0.5pt),
  [$7$], [$11$], [$8$], [$1,3$], [],
  table.hline(stroke: 0.5pt),
  [$8$], [$11$], [$9$], [$1,2$], [],
  table.hline(stroke: 0.5pt),
  [$9$], [$11$], [$10$], [$1,1$], [],
  table.hline(stroke: 0.5pt),
  [$10$], [$11$], [$11$], [$1,0$], [],
  table.hline(stroke: 0.5pt),
  [$11$], [$11$], [$12$], [$11$], [],
  table.hline(stroke: 0.5pt),
  [$12$], [$10$], [$13$], [$10$], [],
  table.hline(stroke: 0.5pt),
  [$13$], [$9$], [$14$], [$9$], [],
  table.hline(stroke: 0.5pt),
  [$14$], [$8$], [$15$], [$8$], [],
  table.hline(stroke: 0.5pt),
  [$15$], [$7$], [$16$], [$7$], [],
  table.hline(stroke: 0.5pt),
  [$16$], [$6$], [$17$], [$6$], [],
  table.hline(stroke: 0.5pt),
  [$17$], [$5$], [$18$], [$5$], [],
  table.hline(stroke: 0.5pt),
  [$18$], [$4$], [$19$], [$4$], [],
  table.hline(stroke: 0.5pt),
  [$19$], [$3$], [$20$], [$3$], [],
  table.hline(stroke: 0.5pt),
  [$20$], [$2$], [$21$], [$2$], [],
  table.hline(stroke: 0.5pt),
  [$21$], [$1$], [$22$], [$1$], [],
  table.hline(stroke: 0.5pt),
  [$22$], [$0$], [$23$], [$0$], [Done!],
  table.hline()
)

We reach the value $0$ in $22$ steps. Let write $G(4)=22$.

What is $G(1024)$? Give your answer modulo $1000000007$.

PS: This is a variant of Problem 396.
#footnote[Actually #link(<p398>)[Problem 398].]
]


// Problem #557
#problem-block(number: 557)[
A traveler goes from city $A$ to city $B$.

When traveling uphill, he moves at speed $u$ km/h \
When traveling on flat road, he moves at speed $f$ km/h \
When traveling downhill, he moves at speed $d$ km/h (of course $0<u<f<d$)

To go from $A$ to $B$, it takes $T_1$ hours. \
To go from $B$ to $A$, it takes $T_2$ hours.

For some triples $(u,f,d)$ these information are sufficient to determinate the distance between $A$ and $B$ (for instance $(30,35,42)$).

How many such triples of positive integers $(u,f,d)$ with $"GCD"(u,f,d)=1$ are there if $d<10^8$?

*[My timing: 40 sec]*

All values in this problem (speed or distance) are assumed to be integers.
]


// Problem #558
#problem-block(number: 558)[
Consider the following Diophantine Equation: $x^2-y^2-z^2-x y-y z-z x=0$.

We call an integer triple $(x,y,z)$ a primitive solution if it is a solution to the Diophantine Equation with $gcd(x,y,z)=1$.

For example, $(3,1,1)$ is a primitive solution to the above Diophantine Equation: \
$3^2-1^2-1^2-3 times 1-1 times 1-1 times 3=0$

In fact, there are only five primitive solutions for $0<z<=y<=x<=100$, namely $(3,1,1)$, $(19,11,1)$, $(37,19,5)$, $(61,29,11)$ and $(91,41,19)$. The sum of these five primitive solutions is $349$, i.e. $sum x+y+z$.

How many primitive solutions are there to the above Diophantine Equation for $0<z<=y<=x<=10^13$? What is the sum of all these primitive solutions?

Answer format: $"count",(sum x+y+z) mod 10^9$

You are given: `479,3971343` for a threshold of $10000$.
]


// Problem #559
#problem-block(number: 559)[
Consider the following Diophantine Equation: $x^2+y^2+z^2-x y-y z-z x-x-y-z=0$.

If $x, y, z$ are all integers, then it is a solution to the Diophantine Equation.

For example, $x=4, y=6, z=9$ is one solution to the above Diophantine Equation: \
$4^2+6^2+9^2-4 times 6-6 times 9-9 times 4-4-6-9=0$.

How many solutions are there to the above Diophantine Equation for $0<x<=y<=z<=10^14$? What is the sum of all these solutions?

Answer format: $"count",(sum x+y+z) mod 10^9$

You are given: `12082,178899731` for a threshold of $10000$.
]


// Problem #560
#problem-block(number: 560)[
A positive integer with $k$ (decimal) digits is called balanced if its first $ceil(k/2)$ digits sum to the same value as its last $ceil(k/2)$ digits, where $ceil(x)$, pronounced ceiling of $x$, is the smallest integer $>= x$, thus $ceil(pi)=4$ and $ceil(5)=5$.

For example, $77$, $101$, $13722$ and $585774$ are balanced numbers.

Find the number and the sum of all balanced numbers $n$ for $0<n<=11^1111$ and give your answer modulo $1000000007$.

Answer format: `count,sum` \
(both modulo $1000000007$)

You are given: `634521,744405873` for a threshold of $12345678$.

*[My timing: 1 s]*
]


// Problem #561
#problem-block(number: 561)[
Let there be a grid with $M$ rows and $N$ columns. The cells are numbered starting from $0$ (topmost left) to $M times N-1$ (bottommost right) and some cells are painted to yellow randomly using the following code:

```c
uint8 grid[NROWS*NCOLS] = {0};

void FillGrid(const int NROWS, const int NCOLS, const int NCELLS)
{
    int NCellsPainted = (NCELLS+1)>>1;
    uint painted = 0;
    uint32 seed = 10001;
    while (painted < NCellsPainted)
    {
        seed = seed * 10001 + 1001;
        uint rowcol = seed % NCELLS;
        if (grid[rowcol] == 0)
        {
            grid[rowcol] = 1; // [row,col] painted
            ++painted;
        }
    }
}
```

Consider as an example a $6 times 7$ grid filled with $20$ painted cells by generating random numbers in the range $[0, 40)$:

#set table(
  fill: (x, y) =>
    if y == 0 and x <= 5 {yellow.lighten(50%)}
    else if y == 1 and x in (0, 1, 4, 6) {yellow.lighten(50%)}
    else if y == 2 and x in (1, 3) {yellow.lighten(50%)}
    else if y == 3 and x in (2, 3, 4, 6) {yellow.lighten(50%)}
    else if y == 4 and x <= 2 {yellow.lighten(50%)}
    else if y == 5 and x == 3 {yellow.lighten(50%)}
)

#table(
  columns: (20pt,)*7,
  rows: 20pt,
  align: center+horizon,
  stroke: 0.5pt + black,
  ..range(42).map(it => [#it]),
)

Notice that some cells are painted contiguously (on the same row the cells to the right or to the left of a painted cell or on the same column upper/lower cells are also painted). Let's find such randomly painted blocks with more than $1$ cell and treat them as some sets. As for the example we would have the following two sets: \
$S_1 = {0, 1, 2, 3, 4, 5, 7, 8, 11, 15}$ \
$S_2 = {17, 23, 24, 25, 28, 29, 30}$ \
$S_1$ has $10$ elements that sum to $56$ and $S_2$ has $7$ elements that sum to $176$.

How many such sets would we have if we have a $9991 times 1001$ grid filled with $5000000$ painted cells by generating random integers in the range $[0, 10000000)$? \
What would be the set number of the set with the maximal number of elements? \
What would be the set number of the set with the maximal sum of elements?

*Note that the sets are sorted by their smallest elements and numbered accordingly.*

Answer format: `a,b,c,d,e,f,g` \
where \
$a$ is the number of sets \
$b$ is the set number of the set with the maximal number of elements \
$c$ is the number of elements of the set $S_b$ \
$d$ is the sum of elements of the set $S_b$ \
$e$ is the set number of the set with the maximal sum of elements \
$f$ is the number of elements of the set $S_e$ \
$g$ is the sum of elements of the set $S_e$

Example: `2,1,10,56,2,7,176` for the $6 times 7$ grid above.

*[My timing: < 10 s]*
]


// Problem #562
#problem-block(number: 562)[
Given two integers $m>0$ and $n>0$, let $L(m,n)$ be the number of sequences which satisfy the following properties:
- Each number in the sequence is a natural number.
- The least number divisible by each number of the sequence is $m$.
- The length of the sequence is $n$.
- Any two adjacent terms in the sequence are co-prime.

For example, $L(4,3)=6$, there are only $6$ co-prime sequences: ${1,1,4}$, ${1,4,1}$, ${2,1,4}$, ${4,1,1}$, ${4,1,2}$ and ${4,1,4}$.

You are given $L(10!,10) equiv 800548088 med (mod 1000000007)$ and \
$L(100!,100) equiv 73129372 med (mod 1000000007)$.

Find $L(10^12 !,10^12) mod 1000000007$.
]


// Problem #563
#problem-block(number: 563)[
Writing down the numbers which have a digit sum of $10$ in ascending order, we get: \
$19,28,37,46,55,64,73,82,91,109,118,dots$

Let $f(n)$ be the $n$-th occurrence of the digit sum $10$. For example, $f(1)=19$, $f(10)=109$ and $f(100)=1423$.

Let $S(k)=sum_(n=1)^k f(n)$. For example $S(100)=67582$ and $S(10^5)=178986850167799$.

Find $sum_(i=1)^100 S(11^i)$.

Give your answer modulo $(10^18+3)$.
]


// Problem #565
#problem-block(number: 565)[
Let $T(n,m)$ be the number of distinct trees with $n$ nodes where the distance between any two nodes is no more than $m$. The distance between two vertices $p$ and $q$ is the number of edges we will come across as we travel from vertex $p$ to vertex $q$ in the shortest path. Two trees are not considered distinct if they are #link("http://en.wikipedia.org/wiki/Isomorphism")[isomorphic].

For example, $T(6,3)=3$. Three distinct trees are shown below.

#align(center)[
  #v(5pt)
  #image("figures/p565.png")
  #v(5pt)
]

You are given $T(15,4)=128$ and $T(50,7) equiv 270742753 med (mod 1000000007)$.

Find $T(1000,15) mod 1000000007$.
]


// Problem #566
#problem-block(number: 566)[
The #link("http://en.wikipedia.org/wiki/Tetration")[tetration] of a number $a$ by a positive integer $b$, denoted by $a arrow.t arrow.t b$ or $attach(a, tl:b)$, is recursively defined by: \
$a arrow.t arrow.t 1=a$ \
$a arrow.t arrow.t (k+1)=a^(a arrow.t arrow.t k)$

Thus we have e.g. $2 arrow.t arrow.t 2=4$ and $3 arrow.t arrow.t 3=7625597484987$.

Let $P_(n,i)$ be the $i$-th prime number among all prime numbers $>n$ such that $P_(10,1)=11$, $P_(30,2)=37$ and $P_(100,3)=107$.

Let $"MOD"(n,m)=n "modulo" m$.

Further define $f(k)=sum_(i=1)^k "MOD"(i arrow.t arrow.t i,P_(k,i))$.

For example $f(3)="MOD"(1 arrow.t arrow.t 1,5)+"MOD"(2 arrow.t arrow.t 2,7)+"MOD"(3 arrow.t arrow.t 3,11)=14$.

You are given $f(100)=20245$.

Find $f(10^6)$.
]


// Problem #567
#problem-block(number: 567)[
For any two integers $m>1$ and $n>1$, we call an integer pair $(m,n)$ a minimum logarithmic pair if there does *not* exist two integers $a$ and $b$ with $1<a<m$ and $1<b<n$ such that $log_a (b)=log_m (n)$.

For example, $(4,9)$ is not a minimum logarithmic pair because $log_4(9)=log_2(3)$. Also $(3,9)$ is not a minimum logarithmic pair since $log_3(9)=log_2(4)$. However $(2,3)$, $(3,4)$ and $(2,4)$ are all minimum logarithmic pairs.

Let $D(N)$ be the sum of $m+n$ over all minimum logarithmic pairs $(m,n)$ for $1<m,n<=N$.

You are given $D(10)=818$, $D(100)=982052$ and $D(10000)=999830459302$.

Find $D(11^111)$ and give your answer modulo $10^18+3$.
]


// Problem #568
#problem-block(number: 568)[
A standard deck of $52$ playing cards, which consists of thirteen ranks (Ace, Two, ..., Ten, King, Queen and Jack) each in four suits (Clubs, Diamonds, Hearts and Spades), is randomly shuffled. A _connection_ is defined as two cards with the same rank appearing next to each other. Let us call a rank _perfect-$k$_ if $k$ connections occur in that rank after the shuffle.

For examples, the following card arrangement has one perfect-$0$, one perfect-$1$, and one perfect-$2$ (where `S` = spade, `H` = Heart, `D` = diamond, and `C` = club).

```
[7D][5C][7C][2S][7H][2D][2H][7S][2C][5D][5S][5H]
```

Rank $2$ is perfect-$1$ because there is only one connection between `2D` and `2H`, Rank $5$ is perfect-$2$ because one connection occurs between `5D` and `5S`, another connection occurs between `5S` and `5H`. Rank $7$ is perfect-$0$ since no connections occur.

Let $E(m,n)$ be the probability that the number of perfect-$i$ ranks is always prime for all non-zero number of perfect-$i$ ranks after a random shuffle if we use a deck of playing cards which consists of $m$ ranks, each in $n$ suits.

You are given $E(5,3) approx 0.55272$ and $E(13,4) approx 0.26393$ (A standard deck of $52$ playing cards).

Find $E(10,8)$ and give your answer rounded to $12$ places after the decimal point.
]


// Problem #569
#problem-block(number: 569)[
Let $S_N$ be the set of positive numbers less or equal to $N$. For example $S_5={1,2,3,4,5}$.

Find the subset of $S_100$ with maximal number of elements ($bold(italic("MN"))$) such that $"sum"(1\/e_i)=1$ for $i=1$ to $italic("MN")$ and the sum $T="sum"(i dot e_i)$ for $i=1$ to $italic("MN")$ is maximal.

Answer format: `MN,T`

Example: `3,26` for the subset $S={e_1=2, e_2=3, e_3=6}$ of $S_6$.
]


// Problem #570
#problem-block(number: 570)[
A cube-free number is a positive integer which is divisible by no #link("https://mathworld.wolfram.com/CubicNumber.html")[cubic number] other than $1$. Given a number $n>0$, $f(n)$ is defined as follows:
$
f(n) = cases(
  sigma_0(n) quad & "if" n "is cube-free",
  b(n) quad & "otherwise"
)
$
where $sigma_0(n)$ is the number of divisors of $n$, $b(n)≡sigma_0(c(n)^2)$ and $c(n)$ is the maximum number $p$ such that $p^3$ divides $n$.

For example, $f(28)=6$ and $f(432)=9$.

Explanation: $28$ is a cube-free number, $f(28)=sigma_0(28)=6$. However, $432$ is not a cube-free number and $216$ is the maximum cubic number which divides $432$. $c(432)=6$ and $b(432)=sigma_0(6^2)=9$.

Let $S(N)=sum_(n=1)^N f(n)$. You are given $S(10^8)=1223779154$.

Find $S(12345678987654321)$.
]


// Problem #571
#problem-block(number: 571)[
#set enum(numbering: "(1)")

We have several blue balls and red balls and we want to put them into boxes.

The rules for placing the balls into boxes are described below.
- Each box contains at least $2$ balls and at most $6$ balls.
- Each box contains at least $1$ red ball and at most $4$ blue balls.
- Balls are different from each other, even they have the same color.
- The order of the box doesn't matter. The order of each ball in the box doesn't matter.

For example, if we have $3$ blue balls and 2$$ red balls. There are $7$ different ways to put them into boxes.
+ ${B 1,R 1}, {B 2,B 3,R 2}$
+ ${B 1,R 2}, {B 2,B 3,R 1}$
+ ${B 2,R 1}, {B 1,B 3,R 2}$
+ ${B 2,R 2}, {B 1,B 3,R 1}$
+ ${B 3,R 1}, {B 1,B 2,R 2}$
+ ${B 3,R 2}, {B 1,B 2,R 1}$
+ ${B 1,B 2,B 3,R 1,R 2}$

Let $W(B,R)$ be the number of different ways to place $B$ blue balls and $R$ red balls into the boxes.

You are given $W(3,2)=7$, $W(5,4)=1510$ and $W(31,27) equiv 336072473 med (mod 1000000007)$.

Find $W(3141,2718) mod 1000000007$.
]
//------------------------------------------------------------------------------
