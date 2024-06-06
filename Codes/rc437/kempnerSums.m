(* :Title: kempnerSums.m -- a package to compute sums of Kempner series *)

(* :Mathematica Version: 4.0, 5.2, 6.0, 7.0, 8.0, 9.0, 10.3, 12.3, and 13.2 *)

(* :Package Version: 3.0, March 4, 2023:
    (1) warning: kSum[42, 15, 100] = 217.417068178528395 is NOT the sum of 1/n where n
        has no single base-100 digit with (decimal) value 42. instead, kSum[42, 15, 100]
        computes the sum of 1/n where n has no consecutive digit pair 4, then 2, 
        in base 100. this is similar to kSum[42] = 228.446304159230813, which is
        the sum of 1/n where n has no consecutive digits 4, then 2, in base 10.
        therefore, this package can NOT currently compute the sum of 1/n
        where n has no single base-100 digit whose value is (decimal) 42.
        this latter sum is given by iSum[42, 0, 15, 100] = 458.704841554097279;
        iSum[ ] is in the related package irwinSums.m.
    (2) changes to documentation: better formatting and examples.
    (3) removed "string" version of kPartialSumThreshold[], which never worked well.
    (4) changes made to prevent kPartialSumThreshold from returning incorrect values.
    (5) you can now enter -1 to use the current default number of decimal places.
        example: kSum[0, -1, 2]. initially, the default in this file is set to 15,
        but you can use kSumSetDefaultDecimals[n] to change the default value.
    (6) kSumGetDefaultDecimals[ ] shows the current default number of decimal places
        in the output.
    (7) removed unnecessary overloaded functions kSum[ ], kPartialSum[ ], etc.
    (8) minor changes to internal function kSumX[ ]:
        (a) changed m to mLocal to prevent mathematica's warning;
        (b) changed Clear[A, Psi, extraPol, n, iMaxBase] to Clear[Psi].

    possible future work:
      (a) in base b > 10, verify that digit values are 0 through b - 1;
      (b) make kSum[42, -1, 100] (or another function) compute the sum of 1/n where
          n has no base-100 digit whose decimal value is 42; see comment (1) above.

  Version: 2.3:
   8/25/2015: reformatted some lines to make them shorter for LaTeX.
   12/31/2012: new version of nf[ ] function.

   Version 2.2:
   7/24/2008: updated links to paper and on-line version of this file.
   5/30/2008: removed old code that is no longer used.
   5/14/2008: two minor changes to make this be compatible with
   mathematica versions 4 and 5.2.
   5/29/2008: use "===", not "==", to check expression types.
   reworked some of the examples.
*)

(* :Authors: Robert Baillie and Thomas Schmelzer *)

(* :Copyright: none.  This code is in the public domain.
   Users are encouraged to improve this code.
*)

(* :Summary:
   This package computes sums of "Kempner" series.

   The harmonic series 1/1 + 1/2 + 1/3 + ... + 1/n + ... diverges.  This means
   that the sum can be made as large as desired by adding enough terms.

   Suppose we delete from this series all terms with a "9" in the denominator.
   That is, we remove 1/9, 1/19, 1/29, etc.  Then the remaining series converges
   to a sum less than 80.  This was first proved in 1914 by A. J. Kempner.

   We can also delete from the harmonic series all terms whose denominators
   contain:
     any digit 0, 1, ..., 9;
    or
     a list of one or more digits, such as the even digits {0, 2, 4, 6, 8};
    or
     any individual multi-digit string or number, such as "00", 42, or 314159;
    or
     any list of patterns of digits, such as { 3, "00", 42, 314159 }.
   In all such cases, the terms that remain form a convergent series.

   However, these series converge much too slowly to get even a rough
   estimate of the sum simply by adding up the terms.  For example,
   for the series with 9 removed, the sum of the first 10^27 terms
   still differs from the final sum (22.92067...) by more than 1.

   This package computes the sums of these series to high precision.
*)

(* :Keywords: kempner, harmonic series *)

(* :Sources:
   The original article that proves convergence of these series is:
      A. J. Kempner, "A Curious Convergent Series",
      American Mathematical Monthly, vol. 21, pages 48-50 (1914).

   The original algorithm that shows how to compute a few of these sums is in:
      Robert Baillie, "Sums of Reciprocals of Integers Missing a Given Digit",
      American Mathematical Monthly, vol. 86, pages 372-374 (May, 1979).

   The functions in this file implement the algorithm in the following article:
      Thomas Schmelzer and Robert Baillie, "Summing a Curious, Slowly Convergent
      Series", in the American Mathematical Monthly, vol. 115, pages 525-540
      (June/July 2008).
      The latest version of this Mathematica code may be downloaded from
        http://library.wolfram.com/infocenter/MathSource/7166/
*)


BeginPackage[ "kempnerSums`" ]

(* :Examples:
   The main function in this package is kSum.
   kSum[X] computes the sum of 1/n where n has no digits in the set X.
   (That is, X can be either a single number, or a list of digits.)

   The output is rounded to the default number of decimal places.  This
   default is initially set to 15, but you can use kSumSetDefaultDecimals[m]
   to reset the default to m decimal places.
   Examples:
     kSum[9] computes the sum of 1/n where n has no digit 9.
     This sum is about 22.920676619264150 .
   The second parameter is the number of decimal places:
     kSum[9, 20] = 22.92067661926415034816 .
   If the number of decimal places is -1, the default number of decimal places is used:
     kSum[9, -1] = 22.920676619264150 (if the default is 15 decimals).

   kSum can also take a third parameter (the base).
     kSum[X, m, b] computes the sum of 1/n where n has no digits in X in base b.
     The sum is rounded and displayed to m decimal places.
     If the third parameter is omitted, the base is assumed to be 10.
     If you use the third parameter to specify a base other than 10, then you
     must enter a value for the second parameter.
     Example: kSum[0, 20, 2] = 1.60669515241529176378,
     or kSum[0, -1, 2] = 1.606695152415292 .
     Note: this sum is actually a rapidly-converging series
     1/1 + 1/3 + 1/7 + 1/15 + 1/31 + ... =
     Sum[1/(2^k-1), {k, 1, Infinity}] = 1.606695152415291763783301523191 ...,
     This example provides an independent check on the algorithm here.

   The first parameter, X, is the set of numbers that are to be omitted
   from the denominators.
   X can be:
     a single number: kSum[0] or kSum[314]
   or
     a list of numbers and/or strings enclosed in braces: kSum[ { 1, "07", 32 } ].

   kSum[{3, 1, 4}] computes the sum of 1/n where n contains no 3, no 1,
   and no 4 in base 10.  The sum is about 3.769948379731421 .

   kSum[314] computes the sum of 1/n where n contains no 314 in base 10.
   The sum is about 2299.829782767518338 .

   If a missing digit pattern is an integer with more than one digit, and
   that integer begins with a 0, then you must enclose the number in quotes.
   This is because Mathematica will interpret the input 09 as the integer 9:
     kSum[09] = kSum[9] = 22.920676619264150,
    but
     kSum["09"]        = 230.404757005814285 .

   kSum[ { 0, 2, 4, 6, 8, 55, 13579 } ] computes the sum of 1/n where
   n has no even digit, no 55, and no 13579.  This example is in the
   Schmelzer-Baillie paper.  The sum is about 3.090849149653806 .


   kSumFormatted is just like kSum, except that kSumFormatted formats
   the output digits into groups of 5:
     kSumFormatted[9] = 22.92067 66192 64150 .
   (Technical notes: the output from kSumFormatted is not a number, but is
   instead an object of type "NumberForm".  Also, remember that Mathematica
   will interpret the input 22.92067 66192 as 22.92067 * 66192).


   After you have computed a sum, you can use kPartialSum to compute
   partial sums of the same series.  kPartialSum uses the most recent
   sum computed by kSum or kSumFormatted.
   For example, after computing
     kSum[9] = 22.920676619264150,
   you can compute the partial sum of the same series over all terms
   whose denominators have at most 30 digits (that is, all denominators
   in the series that are less than 10^30):
     kPartialSum[30] gives 21.971055078178619 .
   This shows that even after adding all terms of the series up through 30 digits
   (that is, more than 10^27 terms), the partial sum would still differ from the sum
   of the entire series by almost 1.0.

   An example in base 2: the sum, to 20 decimals, of 1/n where n has no 0 in base 2.
     kSum[0, 20, 2] = 1.60669515241529176378 .
   To use the default number of decimal places, just enter -1:
     kSum[0, -1, 2] = 1.606695152415292 .
   Here is the partial sum over all denominators in the same series that have
   at most 5 digits in base 2, that is, denominators at most (decimal) 31.
     kPartialSum[5] = 1.575115207373272
   This partial sum is just 1 + 1/3 + 1/7 + 1/15 + 1/31 = 1709/1085.

   You can specify a different number of decimal places in the second parameter.
   After computing kSum[9]:
     kPartialSum[30, 20] = 21.97105507817861948711 .
     kPartialSum[30, -1] = 21.971055078178619 .
   This calculation shows that in order to make the partial sum exceed a threshold of 22.9,
   you would need to include at least some terms with denominators of 67 digits:
     kPartialSumThreshold[22.9]
   This function returns {66, 67, 22.899283165770095, 22.901422511119500}.
   These four values mean:
     the sum of the series for n < 10^66 is about 22.899283165770095, and
     the sum of the series for n < 10^67 is about 22.901422511119500 .
   We can verify this with the kPartialSum[ ] function:
     kPartialSum[66] = 22.899283165770095
     kPartialSum[67] = 22.901422511119500 .

   If we exclude denominators containing 314159, the Kempner sum is 2302582.33386... .
   At some point before this, the partial sum will first exceed 1000000.
   How far do we have to go in the series before this happens?
   kPartialSumThreshold gives us the answer.  kPartialSumThreshold gives us
   the (approximate) point at which a partial sum exceeds a given threshold, and
   shows how extraordinarily slowly these series converge to their final sums.  

   After computing kSum[314159] = 2.302582333863782607892*10^6 = 2302582.333863782607892, we call
     kPartialSumThreshold[1000000].  The result is:
     {569679, 569680, 999999.793917693872470, 1.000001096506746783363*10^6}
     These four numbers tell us that the sum of the series through all
     denominators having 569679 digits is 999999.793917693872470, just under
     1000000, while the sum through denominators having 569680 digits is
     1.000001096506746783363*10^6 = 1000001.096506746783363, just over 1000000.
     In other words, to make the partial sum exceed 1000000, we would have to
     include all terms with denominators having 569679 digits, and some terms
     with denominators having 569680 digits.

     These results can be checked with kPartialSum:
     kPartialSum[569679] =  999999.793917693872470
     kPartialSum[569680] = 1000001.096506746783363

   The next calculation shows that, to make the partial sum exceed 2000000
   (that is, to approximate the final sum to just one significant digit), we
   need to include at least some terms whose denominators have 2029422 digits:
     kPartialSumThreshold[2000000] returns
     {2029421, 2029422, 1.999999789743530856418*10^6, 2.000000092327587901494*10^6}

   The next calculation shows that, to make the partial sum reach the integer part
   of the sum of the entire series (that is, to reach 2302582), we must
   include at least some terms that have denominators of 15746478 digits:
   kPartialSumThreshold[2302582] returns
     {15746477, 15746478, 2.302581999999948711319*10^6, 2.302582000000282576822*10^6}

   Here is an example with an even larger sum.  If we exclude denominators
   that have the digit pattern "1234567890", the sum is
     kSum[1234567890, 20] = 2.302585092202703549829506732687*10^10 .
   After including some terms with 434304 digits, the sum finally reaches 1 million:
     kPartialSumThreshold[1000000] returns
     {434303, 434304, 999998.47617794443909902633, 1.00000077866303886642136774*10^6}
   After including some terms with 444007324 digits, the sum reaches 1 billion:
     {444007323, 444007324,
      9.9999999815290203462491699527*10^8, 1.00000000035548712899465692756*10^9}

   The partial sum over all terms having at most one billion digits is
     kPartialSum[10^9] = 2.191199428160751825211987*10^9 ,
   which is still only about 1/10 the sum of the entire series.


   You can display the current default number of decimal places with
   kSumGetDefaultDecimals[ ].  You can change the default
   number of decimal places.  For example,
     kSumSetDefaultDecimals[20]
   will set the default number of decimal places to 20.  In any individual
   calculation, you can also specify how many decimal places you want.


   This loop computes the 10 sums that arise when terms with the digits
   0, 1, 2, ..., 9 are removed from the harmonic series:
     Do[Print[ i, " ", kSum[i]], {i, 0, 9}]

   This computes sums involving all pairs of missing digits, base 10:
     For[i = 0, i <= 9, i++,
       For[j = i+1, j <= 9, j++,
         Print[ i, ",", j, ": ", kSum[{ i, j }] ]
       ]
     ]

   The next loop prints out the sums for missing digit patterns 00 through 99.
   For "00", for example, we would delete 1/100, 1/200, ... from the harmonic
   series.  We need IntegerString[ ] for the input strings "00" - "09"
   because the integers 00 - 09 have leading zeros.
   (IntegerString also works with the the remaining digit patterns 10 - 99).
   These sums range between approximately 220 and 253.
     Do[Print[IntegerString[i, 10, 2], " ",
       kSum[IntegerString[i, 10, 2], 10]], {i, 0, 99}]


   The authors believe that all output digits for kSum[X, m] are correct, rounded
   in the last place.  To verify that you got as many correct decimal places as
   you wanted, you can run the calculation again with, say, 5 more decimal places.
*)


(* usage messages for this context, and for the exported functions *)
kempnerSums::usage = "kempnerSums.m is a package that computes sums of Kempner series.\

 This package has the following functions:
 kSum[X]: returns the sum of 1/n where n has no digits in the set X.
 This is the primary calculation function in this package.\

kSumFormatted[X]: same as kSum, but formats the output.\

kPartialSum[nDigits]: uses the most input to kSum or kSumFormatted, and returns\
 the partial sum for all denominators up through (nDigits) digits.\

kPartialSumThreshold[s] tells how far we must go in the series to make the\
 partial sum exceed the given threshold s.\

kSumGetA[X]: computes the A matrix associated with X.\

kSumGetT[X]: computes the T matrix associated with X.\

The A and T matrices are described in the Schmelzer-Baillie paper.\

In these functions, X is the set of numbers to exclude from the denominators.\
 X can be a single number, or a comma-separated list of numbers enclosed in braces { }.\
 (Note: a multi-digit number that has a leading zero must be enclosed in quotes).\
kSum and kSumFormatted take an optional second parameter: the number of decimal\
 places.  If this parameter is omitted, the default number will be used.\
kSum, kSumFormatted, and kSumGetA take an optional, final parameter: the base.\
 If the base is not specified, base 10 is the default.\
 You may also call kSum and kSumFormatted with a T matrix as the first parameter.\

kSumGetDefaultDecimals and kSumSetDefaultDecimals[m] display and set the default\
 number of decimal places.\

kSumTimeAndMemory displays estimated time and memory requirements."


(* these are usage messages for individual functions *)

kSum::usage = "general forms:
 kSum[digit list, decimals, base]
 kSum[string, decimals, base]
 kSum[integer, decimals, base]
kSum[X] computes the sum of the series 1/n where n has no digits in the set X.\
 X is the set of numbers to exclude from the denominators.\
 X can be a single number, or a comma-separated list of numbers enclosed in braces { }.\
 If X is a list, then this computes the sum of 1/n where n has\
 no occurrences of any of the numbers in the list.\
 (Note: a multi-digit number that has a leading zero must be enclosed in quotes).\
 The optional second parameter is the number of decimal places (-1 for the default).\
 All results are rounded to the given number of decimal places.\

Examples:
 kSum[9] = 22.920676619264150 (n has no 9's; use the default of 15 decimal places)\

 kSum[9, 25] = 22.9206766192641503481636571 (same result, rounded to 25 decimals)\

 kSum[09] = 22.920676619264150 (same as kSum[9]: Mathematica treats 09 as 9)\

 kSum[\"09\"] = 230.404757005814285 (leading 0, so quotes are required)\

 kSum[{3, 1, 4}] = 3.769948379731421 (n has no 3's, no 1's, and no 4's)\

 kSum[314] = 2299.829782767518338 (n has no digit string 314)\

 kSum[314159, 20] = 2302582.33386378260789202376 (n has no string 314159)\

 kSum[{0, 2, 4, 6, 8}] = 3.171765473415905 (n has no even digits)\

 kSum[{1, 3, 5, 7, 9}] = 1.962608412994617 (n has no odd digits)\

 kSum[{0, 1, 4, 6, 8, 9}] = 1.857333779940978 (n has only prime digits 2, 3, 5, 7)\

 kSum[{\"00\", 11, 22, 33, 44, 55, 66, 77, 88, 99}] = 23.382957488301063 (no double digits)\

kSum takes an optional third parameter: the base. If not specified, base 10 is used.\
 If you use the third parameter, you cannot omit the second parameter.\
 Example: kSum[0, -1, 2] = 1.606695152415292 (denominators with no 0 in base 2).\
 Another form: kSum[ T ], where the input is the T matrix; see the Schmelzer-Baillie paper."

kSumFormatted::usage = 
 "Similar to kSum, but digits after the decimal point are separated into groups of 5."

kPartialSum::usage = "general form: kPartialSum[p, decimals]
 Using the most recent input to kSum or kSumFormatted, compute the sum of all terms\
 whose denominators have at most (p) digits.
 You must call kSum or kSumFormatted before calling kPartialSum.\

 Example: kSum[9] = 22.920676619264150 . Then, kPartialSum[30] returns 21.971055078178619 .
 This is the sum of all terms in the series with denominators < 10^30."

kPartialSumThreshold::usage = "general form: kPartialSumThreshold[threshold, decimals]
 Using the most recent input to kSum or kSumFormatted, compute the number of digits needed
 in the denominators to make the partial sum exceed threshold.

 kPartialSumThreshold returns four numbers: { d1, d2, s1, s2 }:\
 d2 is the smallest number of digits required in the denominators to make the partial sum > s.\
 s2 is the sum over denominators < 10^d2.\
 Also, d1 = d2 - 1, and s1 is the sum over denominators < 10^d1.

 Given s, s1 and s2 will normally be such that s1 < s < s2.
 You must call kSum or kSumFormatted before calling kPartialSumThreshold.

 The value of s must be less than the sum of the entire series. If s is too close to the sum of
 the entire series, then kPartialSumThreshold will return error values {-1, -1, -1, -1}.
 If this happens, you should either (a) make the threshold, s, a little smaller,\
 or (b) increase the accuracy of s by appending 0's, or by using Mathematica's\
 double backquote ( `` ) notation.\

 Example 1:
  kSum[9] = 22.920676619264150 .
  Then, kPartialSumThreshold[22] returns {30, 31, 21.971055078178619, 22.066017232287173}.
  Therefore, the sum over denominators < 10^30 is about 21.971055078178619,
  while the sum over denominators < 10^31 is about 22.066017232287173 .
  So, to make the partial sum exceed 22, we need some terms whose denominators have 31 digits.\

 Example 2:
  This example shows what happens if your input is too close to the sum of the entire series.
  kSum[9] = 22.920676619264150 .
  kPartialSumThreshold[22.92067661926] returns {-1, -1, -1, -1}.
  If this happens, you must either (a) make the the threshold smaller,\
  or (b) increase the accuracy of your threshold value.\
  For example, this works: kPartialSumThreshold[22.9206766192].
  The return values are {252, 253, 22.920676619198174, 22.920676619204772}.

  You can increase the accuracy of the threshold by appending 0's:
  kPartialSumThreshold[22.9206766192600000].
  The returned values are {278, 279, 22.920676619259888, 22.920676619260314}.
  (This threshold is larger than 22.9206766192, so we expect different returned values.)

  You can also use the double backquote notation:
  This also works: kPartialSumThreshold[22.92067661926``16].
  This returns the same values {278, 279, ...} as before.

  You can also convert the decimal value to an exact rational value:
  kPartialSumThreshold[22 + 92067661926/100000000000].
  This returns the same values {278, 279, ...} as before."

kSumGetT::usage = "kSumGetT[X] computes and displays the T matrix associated with X.\
 X is the collection of numbers to omit from the denominators.\
 This function takes an optional second parameter: the base; if not specified, base 10 is used."

kSumGetA::usage = "kSumGetA[X] computes and displays the A matrix associated with X.\
 X is the collection of numbers to omit from the denominators.\
 This function takes an optional second parameter: the base; if not specified, base 10 is used."

kSumShowA::usage = "kSumShowA[ ] shows the A matrix for the previously-entered input string or list."

kSumTimeAndMemory::usage = "kSumTimeAndMemory[nDigits] estimates time and memory requirements\
 for kSum[9, nDigits].\
  Note that kSum[99, nDigits] needs more time and memory than kSum[9, nDigits]."

kSumSetDefaultDecimals::usage = "kSumSetDefaultDecimals[n] sets the default number of decimal places\
 to n. Initially, this value is set in this file to 15." ;

kSumGetDefaultDecimals::usage = "kSumGetDefaultDecimals[] displays the default number of decimal places\
 in the output." ;

kSumShowDefaultDecimals::usage =
 "kSumShowDefaultDecimals (no parameters) displays the current default number of decimal places."


Begin["`Private`"]    (* begin the private context (implementation) *)


Off[ General::spell1 ];
Off[ General::spell ];

(* $MachinePrecision is typically about 15 *)
nDefaultDecimals = 15;  (* kSumSetDefaultDecimals[n] can change this to any desired value *)


getDigitsforNFunction[y_, nDec_] :=
Module[
(* we want to display an extended-precision number to (nDec) decimal places,
   not counting the number of leading zeros if the number is between 0 and 1.
   if Abs[y] < 1, N[y, nDec] displays the correct number of decimal places;
   otherwise, in N[y, nDec], the number of digits shown includes digits to the left
   of the decimal point; in this case, we must increase the number of digits sent to N[ ].
*)
  { nExtra },
  If[Abs[y] >= 1,
    nExtra = 1 + Floor[ Log[10, Abs[y]] ],
    nExtra = 0
  ];
  nExtra + nDec
]    (* end of getDigitsforNFunction *)


(* nf formats a number to (nDec) decimal places, with a space every 5 digits *)
(*
nf[y_, nDec_] :=
  If[y == 0, 0,
    NumberForm[y, Max[ 1, Floor[1+Log[10, Abs[y]]] ] + nDec, DigitBlock->5, NumberSeparator->{""," "}]
  ];
*)
nf[y_, nDec_] :=
  If[y == 0, 0,
    NumberForm[y, getDigitsforNFunction[y, nDec], DigitBlock->5, NumberSeparator->{""," "}]
  ];


removeDups[inputList_?VectorQ] :=
Module[
  (* remove duplicates from a list without changing the order;
     (Union[ ] removes duplicates, but also sorts the list) *)
  { },
  elimReps[u_, v_] := If[MemberQ[u, v], u, Append[u, v]];
  Fold[elimReps, {First[inputList]}, Rest[inputList]]
];


(* Mathematica version 4 does not have a Norm[x, y] function.  so, to make this package
   work in version 4, we define a function that is equivalent to Norm[v, 1], which is:
     Norm[v, 1] = Abs[ v[[1]] ] + Abs[ v[[2]] ] + ... + Abs[ v[[n]] ] *)
normOne[v_?VectorQ] := Apply[Plus, Map[Abs, v] ];


(* powerx is just like Power[], but powerx returns 0^0 = 1 without "Indeterminate" warnings *)
powerx[0, 0] := 1;               (* special case *)
powerx[x_, y_] := Power[x, y] ;  (* in other cases, use the built-in function Power[] *)


(* speedMode = 0 for (slow, use less memory), 1 for (fast, lots of memory); 1 is the default *)
(* speedMode = 1; *)



(* these global variables are computed in kSumX, and are used in kPartialSum *)
A = Null;
extraPol = 0;
n = 0;
Psi = Null;
iBaseSave = 0;
kSumSave = 0;
nDecimalsSave = 0;


Unprotect[kSum, kSumFormatted, kPartialSum, kPartialSumThreshold, kSumGetT, kSumGetA, kSumShowA,
          kSumTimeAndMemory, kSumSetDefaultDecimals, kSumGetDefaultDecimals,
          kSumShowDefaultDecimals]; 


convertInputListToStrings[inputList_?VectorQ] :=
Module[
  (* convert input list to all strings; if a list element is neither a string
     nor an integer, return an empty list. *)
  { len, i, str, outputList = { }, bSet },
  len = Length[inputList];
  For[i = 1, i <= len, i++,
    bSet = False;
    If[StringQ[ inputList[[i]] ], str = inputList[[i]]; bSet = True];
    If[IntegerQ[ inputList[[i]] ], str = ToString[ inputList[[i]] ]; bSet = True];
    If[bSet == False,
      Print["Error: Invalid input list: value #", i ," is neither a String nor an Integer."];
      Return[ {} ]
    ];
    AppendTo[outputList, str];
  ];
  outputList
];


setT[stringList_?VectorQ, iBase_Integer:10] :=
Module[ (* enter with a list of strings {s1, s2, ...}, like { "12", "345" }; return the T matrix *)
  (* note: this function returns a 2-dimensional matrix, not a list.  even when the output
     matrix has only one row, it is a matrix of the form {{1,2,3. ...}}, not a vector of the
     form {1,2,3, ...}. *)
  (* programming note: this function was not written in mathematica's efficient "functional" style.
     this function does not need to be very efficient.  this function sets up the T matrix farily,
     quickly.  calculating the sum takes far longer.  readers are welcomed to improve this code.
  *)
  { nInputStrings, i, s, s2, len, validDigits, j, t, iRow, firstNChars, d, dTest, found, jStart,
    inputList0, inputList = {},    (* copy of input list *)
    nSingleDigits = 0, nRows = 0, firstRow, nSetStrings = 0, setStrings = {},
    firstJChars, bFound, k, dString, s2Appended, maxMatched, nCompare, iSaved, t2 },

  (* preliminaries: check input validity, make a list of input strings with spaces removed. *)

  If[( iBase < 2) || (IntegerQ[iBase] == False),
    Print["Error: Base = ", iBase," is not valid."];
    t = Table[-1, {1}, {1}];    (* return this invalid 1 by 1 matrix *)
    Return[t]
  ];

  inputList0 = removeDups[stringList];    (* remove duplicate strings, but keep the order unchanged *)

  nInputStrings = Length[inputList0];
  If[nInputStrings < 1,
    Print["Error: No input string specified."];
    t = Table[-1, {1}, {iBase}];    (* return this invalid 1 by iBase matrix *)
    Return[t]
  ];

  If[iBase <= 10,    (* make a list of all valid digits in this base *)
    validDigits = CharacterRange["0", ToString[iBase-1]]  (* these are characters, not numbers *)
  ];
  (* if iBase > 10, how should we check that the digits are valid?
     perhaps we could use lower-case letters a-z for bases 11-36,
     as Mathematica does for BaseForm[ ].  note: we can still enter
     a digit in any base, say 0 in base 100 or base 1000.  for example,
       kSum[0, 10, 100] = 460.5252026385
     and
       kSum[0, 10, 1000] = 6907.756101048 . *)

  For[i = 1, i <= nInputStrings, i++,
    (* make sure this list element is an integer or a string *)
    If[UnsameQ[ Head[inputList0[[i]]] , String ] && UnsameQ[ Head[inputList0[[i]]] , Integer ],
      Print["Error: Invalid input list: value[",i,"] is not a String."];
      If[Head[inputList0[[i]]] === Symbol, Print["Two commas in a row."] ];
      t = Table[-1, {1}, {iBase}];    (* return this invalid (1 by iBase) matrix *)
      Return[t]
    ];

    s = inputList0[[i]];

    If[Head[s] === Integer, s = ToString[s]];
    (* for convenience, user can include spaces, but we ignore them *)
    s2 = StringReplace[s, " " -> ""];
    len = StringLength[s2];
    If[len == 0, Continue[]];

    If[iBase <= 10,  (* verify that this input string is a valid number in this base *)
      For[j = 1, j <= len, j++,
        If[MemberQ[validDigits, StringTake[s2, {j}]] == False,  (* jth character *)
          Print["Error: input character '", StringTake[s2, {j}],
                 "' is not a valid digit in base ", iBase];
          t = Table[-1, {1}, {iBase}];    (* return this invalid (1 by iBase) matrix *)
          Return[t]
        ];
      ];
    ];
    (* this string is ok, so add it to inputList *)
    AppendTo[inputList, s2];
    If[len == 1, nSingleDigits++];
  ];    (* end For[ i ] loop *)

  (* if only single digits are present, return this one-row matrix *)
  If[nSingleDigits == nInputStrings,
    (* the first row has zeros in the positions corresponding to
       input strings of length 1.  other positions have non-zero entries. *)
    firstRow = Table[1, {1}, {iBase}];
    For[i = 1, i <= nInputStrings, i++,
      If[StringLength[ inputList[[i]] ] == 1,
        j = ToExpression[ inputList[[i]] ];
        firstRow[[1, j+1]] = 0;
      ];
    ];
    Return[firstRow]
  ];

  (* now we set up the unique strings that define all the sets.
     see the schmelzer-baillie paper for details.

     example 1: suppose the input string is { "314" }.
     let S be the set of all integers not containing this string.
     then we make 3 subsets of S:
     set 2 is all elements of S that end in "3" ;
     set 3 is all elements of S that end in "31" ;
     set 1 is all other elements of S.

     example 2: suppose the input list is { "12", "345", "3467" }.
     let S be the set of all integers containing none of these strings.
     then we make 4 subsets of S:
     set 2 is all elements of S that end in "1" ;
     set 3 is all elements of S that end in "3" ;
     set 4 is all elements of S that end in "34" ;
     set 5 is all elements of S that end in "346" ;
     set 1 is all other elements of S.

     example 3: complicated example from the schmelzer-baillie paper:
     suppose the input list is { "0", "2", "4", "6", "8", "55", "13579" }.
     then we make 6 subsets of S:
     set 2 is all elements of S that end in "5" but not "135" ;
     set 3 is all elements of S that end in "1" ;
     set 4 is all elements of S that end in "13" ;
     set 5 is all elements of S that end in "135" ;
     set 6 is all elements of S that end in "1357" ;
     set 1 is all other elements of S.
  *)

  setStrings = { "" }; nSetStrings = 1;    (* for first set (first row) *)

  For[i = 1, i <= nInputStrings, i++,    (* process the ith input string *)
    s2 = inputList[[i]];
    len = StringLength[s2];
(* Print["line 652: i = ", i, ", s2 = ", s2, ", len = ", len]; *)
    If[len > 1,    (* input strings of length 1 are processed elsewhere *)
      For[j = 1, j <= len-1, j++,
        firstJChars = StringTake[s2, j];

        (* make sure that string firstJChars is not already in the setStrings list *)
        bFound = False;
        For[k = 1, k <= nSetStrings, k++,
          If[setStrings[[k]] == firstJChars, bFound = True; Break[] ];
        ];

        If[bFound == False,
          AppendTo[setStrings, firstJChars];
          nSetStrings++;
        ];
      ];    (* end For[ j ] loop *)
    ];    (* end If[len > ... 1] *)
  ];    (* end For[ i ] loop *)

  (* at this point, we have setStrings = {1, 3, 34, 346}.
     the number of rows will be the number of elements in setStrings. *)

  nRows = Length[setStrings];
  (* now we know the dimensions of the matrix *)
  t =  Table[1, {nRows}, {iBase}];

  (* now set the elements of the matrix *)

  For[iRow = 1, iRow <= nRows, iRow++,
    s2 = setStrings[[iRow]];
    (* append each digit to string s2 and see which set the appended string belongs to *)
    For[d = 0, d < iBase, d++,
      (* create a string (s2Appended) that consists of the string
         for this set, with the single digit d appended. *)
      dString = ToString[d];
      s2Appended = StringJoin[s2, dString];
      (* if d is a prohibited digit, set t[..] = 0 *)
      If[ Length[Position[inputList, dString]] > 0,
        t[[iRow, d+1]] = 0;
        Continue[];    (* next d *)
      ];
      (* if s2Appended equals any of the prohibited input strings, then set t[..] = 0 *)
      bFound = False;

      For[i = 1, i <= nInputStrings, i++,
        If[ s2Appended == inputList[[i]], t[[iRow, d+1]] = 0;
          bFound = True; Break[] ];  (* end If *)
      ];  (* end For[ i ] loop *)

      If[bFound == True, Continue[] ];

      (* if we get here, then s2Appended is not a prohibited input string.
         see if s2Appended contains a prohibited string. *)
      For[i = 1, i <= nInputStrings, i++,
        If[ Length[StringPosition[ s2Appended, inputList[[i]] ] ] > 0,
           t[[iRow, d+1]] = 0;
           bFound = True; Break[];
        ];
      ];

      If[bFound == True, Continue[] ];

      (* if we get here, then this (row, column) was not set to 0.
         see which set s2Appended belongs in.  an example in the schmelzer-baillie
         paper shows that a string ending in "5" could be in two sets ("5" and "135").
         so, first, try to select the set (if any) whose string equals s2Appended.
      *)

      (* final digits of s2Appended could match more than one setStrings[[i]].
         among the matches, save the value of i for which
         StringLength[ setStrings[[i]] ] is largest.
      *)
      maxMatched = 0;    (* max number of final digits that match *)
      iSaved = 0;
      For[i = 2, i <= nSetStrings, i++,
        nCompare = StringLength[ setStrings[[i]] ];
        (* if s2Appended is shorter than setStrings[[i]], then it cannot match setStrings[[i]] *)
        If[StringLength[s2Appended] < nCompare, Continue[] ];
        (* compare the last (nCompare) characters of s2Appended and setStrings[[i]] *)
        If[ StringTake[s2Appended, -nCompare] == StringTake[setStrings[[i]], -nCompare],
          bFound = True;
          If[StringLength[ setStrings[[i]] ] > maxMatched,
            maxMatched = StringLength[ setStrings[[i]] ];
            iSaved = i;
          ];
        ];
      ];  (* end For[ i ] loop *)

      If[bFound, t[[iRow, d+1]] = iSaved];

    ];  (* end For[ d ] loop *)
  ];    (* end For[ iRow ] loop *)

  t    (* return this matrix *)
];    (* end of setT *)


kSumX[stringList_?VectorQ, T_?MatrixQ, nDecimals0_Integer:-1, iBase_Integer:10] :=
Module[
  (* the user calls kSum[ ] or kSumFormatted[ ].  those functions call this
     private function kSumX, which does all the work. *)
  { nDecimals, inputLen, nDecSum, f, c, a, S, z, nInputDigits, totalDigits,
    iMaxBase, goalMult, matB, wTrunc2, i, d, l, m, w, h,
    iPrint = 0, (* below, see Print["h[", i, ",", j,"]=", Sort[h]] for list of integers *)
    xi },

  (* Clear[A, Psi, extraPol, n, iMaxBase]; *)    (* clear the global variables *)
  Clear[Psi];  (* need Psi, do not need the others *)

  (* in base 10, if the input is one string of N digits, then the sum will have N+1 digits.
     if there are additional strings, they can only lower the sum.  therefore, the shortest
     string in the list provides an upper bound for the number of digits in the sum. *)
  (* inputLen = Min[StringLength[stringList]]; *)
  (* StringLength[ ] is not Listable in version 4; next line works in versions 4, 5, 6, 7 *)
  inputLen = Min[Map[StringLength, stringList]];

  (* iMaxBase and goalMult depend on the base.  their values were determined empirically.
     to insure that we get as many decimal places of precision as the user requested. *)

  (* iMaxBase is roughly the log of 1000 to base (iBase). so, for base 10, iMaxBase = 3.
     for base 2, iMaxBase = 10.  for base 100 if we use "Apply[Plus, N[1/S[i, j]^k, nDecSum]]",
     then iMaxBase = 3 uses too much memory.
  *)
  nDecimals = nDecimals0;
(*  If[nDecimals < 1, nDecimals = 1]; *)
  If[nDecimals == -1, nDecimals = nDefaultDecimals];  (* if nDecimals = -1, use default *)

  iMaxBase = Ceiling[ Log[iBase, 1000] ];

  (* for base 1000, kSum[0, 20, 1000] = 6907.75610104793192687449 .
     for this, we need iMaxBase > 1 *)
  If[iMaxBase < 2, iMaxBase = 2];    (* could happen if iBase = 1000 *)

  iBaseSave = iBase;    (* used in kPartialSum *)

  (* goalMult = 1.1 is ok for base 100, but is too small for base 10.
     1.4 is usually enough for base 10.  an exception: 100th decimal place of kSumFormatted["99", 100]
     is different from that of kSumFormatted["99", 110].  so, use 1.5 for base 10.
     for base 2, we need an even larger multiplier: 3.1 is too small, but 3.2 works.
     for bases between 2 and 10, a goalMult < 3.2 might work, but we will use 3.2.
  *)
  goalMult = 1.5;
  If[iBase < 10,   goalMult = 3.2 ];
  If[iBase >= 100, goalMult = 1.1 ];

  (* for base 10, the number of correct decimal places turns out to be about (2/3) * nDecSum.
     therefore, adjust nDecSum accordingly, based on the input (nDecimals).
     also, an N-digit string gives rise to a sum with N+1 digits to the left of the
     decimal point.  for base 100, the sum has 2N+1 digits to the left of the decimal point.
  *)

  nInputDigits = inputLen;
  totalDigits = nDecimals + nInputDigits;    (* works in base 10 *)
  If[iBase > 10, totalDigits = nDecimals + 2*nInputDigits ];

  nDecSum = Floor[goalMult * totalDigits];

  (* for large bases (say 1000), we may have to slightly increase the number of digits
     to prevent this: kSum[0, 10, 1000] = 6907.756101048 (only 9 decimals shown). *)
  If[iBase > 10,    
    nDecSum = nDecSum + Ceiling[Log[10, iBase]*nInputDigits]
  ];

  (* the computation of A here is the same code as kSumGetA. *)
  f[j_, l_, m_] := f[j, l, m] = If[T[[l, m]] == j, 1, 0] ;

  n = Dimensions[T][[1]] ;    (* number of rows *)

  A = (1/iBase) Sum[ Table[f[j, l, m + 1], {j, n}, {l, n}] , {m, 0, iBase-1} ] ;

  c[k_, w_] := c[k, w] = Binomial[k + w - 1, w] ;

(*
   we use powerx to avoid warning about 0^0 being indeterminate,
   and because the first term in the negative binomial expansion is 1.
*)
  a[k_, w_, m_] := iBase^(-k - w) * c[k, w] * (-1)^w * powerx[m, w] ;

  matB[a_?MatrixQ] := (Inverse[# - a] - #) &[IdentityMatrix[Length[a]]];

  (* function of i, k, and nDecSum *)
  wTrunc2[i_, k_] := Max[Floor[(nDecSum + 1)/(i - 1) + 1 - k] + 1, 0] ;

  extraPol = nDecSum + 1;

(*
  If[iPrint > 0,
    Print["nDecimals = ", nDecimals, ", iMaxBase = ", iMaxBase, ", goalMult = ", goalMult];
    Print["nDecSum = ", nDecSum];
  ];
*)

  S[i_, j_] := S[i, j] =
  If[i == 1, Complement[Extract[Table[d, {d, 0, iBase-1}], Position[T[[1]], j]], {0}] ,
    Module[
    (* mathematica displays this m in red and flags this declaration as a possible error *)
(*      { p, el, m, k, elel, mm }, *)
      { p, el, mLocal, k, elel, mm },  (* eliminates mathematica compile warning; january 2023 *)
      p = Position[Table[T[[el, mLocal]], {el, n}, {mLocal, iBase}], j]; h = {};
      For[k = 1, k <= Length[p], k++,
        {elel, mm} = p[[k]];
        h = Join[h, iBase * S[i - 1, elel] + (mm - 1)]
      ]
    ];    (* end Module *)

(* for kSum[0], h is the list 2 or 3-digit integers with no 0 *)
(* If[iPrint == 1, Print["h[", i, ",", j,"]=", h] ]; *)
If[iPrint == 1, Print["h[", i, ",", j,"]=", Sort[h]] ];  (* 2023 *)

    h    (* return this list of i-digit integers = S[i,j] *)
  ] ;    (* end If *)


(* here are two ways to compute Psi:
     N[Apply[Plus, 1/S[i, j]^k], nDecSum]    this is slow but uses little memory
   or
     Apply[Plus, N[1/S[i, j]^k, nDecSum]]    this is fast but uses lots of memory

   lst1 = Range[11, 99]
   lst1 = Select[Range[11, 99], Mod[#, 10] != 0 &]  (* for kSum[0], remove 20, 30, ..., 90 *)
   there is a difference in how these two expressions are evaluated:
     N[Apply[Plus, 1/lst1^k], nDecSum]
     Apply[Plus, N[1/lst1^k, nDecSum]]
     f1[k_, nDec_] := N[Apply[Plus, 1/lst1^k], nDec] - Apply[Plus, N[1/lst1^k, nDec]]
     f2[nDec_] := { N[Apply[Plus, 1/lst1], nDec] , Apply[Plus, N[1/lst1, nDec]] } // N
*)

  Psi[i_, j_, k_] := Psi[i, j, k] =
    If[i <= iMaxBase,

   (* If[speedMode == 0,
        N[Apply[Plus, 1/S[i, j]^k], nDecSum],  (* slow, but uses little memory; N[long rational] *)
       (* Apply[Plus, N[1/S[i, j]^k, nDecSum]] *) (* fast, but uses lots of memory; sum of decimals *)
       (* compute only one 1/S[i, j]^k at a time to save memory; 1/21/2008 *)
       (* xSum = 0; 
          For[xi = 1, xi <= Length[S[i, j]], xi++,
            xSum += N[1/(S[i, j][[xi]])^k, nDecSum]
          ];
          xSum
       *)
       Sum[ N[1 / (S[i, j][[xi]])^k, nDecSum], { xi, Length[S[i, j]] } ]    (* 1/24/2008 *)
      ] *) (* end If[speedMode] *)

(* Print["line 898: i = ", i, ", j = ", j, ", S[i, j][[xi]] = ", S[i, j]  ]; *)

      Sum[ N[1 / (S[i, j][[xi]])^k, nDecSum], { xi, Length[S[i, j]] } ]
     ,
      (* below, i > iMaxBase *)
      Sum[f[j, l, m + 1]*Sum[a[k, w, m]*Psi[i - 1, l, k + w],
         {w, 0, wTrunc2[i, k]}], {m, 0, iBase-1}, {l, 1, n}]
    ] ;    (* end If *)

(*
If[iPrint == -1,
  Print["kSumx: extraPol = ", extraPol, ", n = ", n];
  (* print the Psi values that will be used in computing z, below.  the 3rd argument
     is always 1 there, but values of Psi[i-1, j, k] where k > 1 were used above
     to compute Psi[i, j, k]. *)
  Print["  (1) Psi (1..", extraPol, ", 1..", n, ", 1) = ",
        N[Table[Psi[i, j, 1], {i, 1, extraPol}, {j, 1, n}], 5] // TableForm ];
  Print["  (2) Psi (", extraPol, ", 1..", n, ", 1) = ",
        N[Table[Psi[extraPol, j, 1], {j, n}], 5] // TableForm ];
];
*)

  (* use normOne[v] instead of Norm[v, 1] so this can run with Mathematica 4.0 *)
  z = Sum[Psi[i, j, 1], {i, 1, extraPol}, {j, 1, n}] +
    normOne[matB[A] . Table[Psi[extraPol, j, 1], {j, n}] ];

  (* return z, rounded to the number of decimal places requested *)
  If[z == 0, kSumSave = 0, kSumSave = N[z, Floor[ 1 + Log[10, z] ] + nDecimals ] ];

  nDecimalsSave = nDecimals;

(* If[iPrint == 1, Print["z = ", z] ]; *)

  kSumSave    (* kSumSave is used in kPartialSum *)

]    (* end of kSumX *)


kSum[T_?MatrixQ, nDecimals0_Integer:-1] :=
Module[ (* in this version, we input a T matrix, not a string *)
  (* note: the base is not a parameter; the base is the number of columns in the matrix *)
  (* warning - a matrix is a type of list.  therefore, this kSum[matrix] function must be
     placed before kSum[list] in this source code file. *)
  { nDecimals = nDecimals0, n, iBase, i, stringList = { }, s = ""},

  (* If[nDecimals0 < 1, nDecimals0 = 1]; *)
  If[nDecimals == -1, nDecimals = nDefaultDecimals];  (* if nDecimals = -1, use default *)

  n = Dimensions[T][[1]];    (* number of rows *)
  If[Length[ Dimensions[T] ] == 1,
    iBase = Length[T],          (* T is a 1 by n matrix *)
    iBase = Dimensions[T][[2]]; (* iBase is the number of columns in the T matrix *)
  ];

  (* make a string of length n.  it doesn't matter what its digits are; only the length matters. *)
  For[i = 1, i <= n, i++, s = StringJoin[s, "0"] ];

  AppendTo[stringList, s];
  kSumX[stringList, T, nDecimals, iBase]
]    (* end of kSum[T matrix, nDec] *)


kSum[inputList_?VectorQ, nDecimals0_Integer:-1, iBase_:10] :=
Module[
  { nDecimals = nDecimals0, lst, T },
  If[nDecimals == -1, nDecimals = nDefaultDecimals];  (* if nDecimals = -1, use default *)

  lst = convertInputListToStrings[inputList];
  If[Length[lst] == 0, Return[0] ];
  T = setT[lst, iBase];
  If[ T[[1, 1]] < 0, Return[0] ];
  kSumX[lst, T, nDecimals, iBase]
]    (* end of kSum[list, nDec, base] *)


kSum[s_String, nDecimals0_Integer:-1, iBase_:10] :=
Module[
  { nDecimals = nDecimals0, stringList = { s } },
  If[nDecimals == -1, nDecimals = nDefaultDecimals];  (* if nDecimals = -1, use default *)
  kSum[stringList, nDecimals, iBase]
]    (* end of kSum[string, nDec, base] *)


kSum[i_Integer, nDecimals0_Integer:-1, iBase_:10] :=
Module[
  { nDecimals = nDecimals0, stringList = { ToString[i] } },
(* Print["line 975: i = ", i, ", stringList = ", stringList, ", FullForm[stringList] = ", FullForm[stringList]]; *)
  If[nDecimals == -1, nDecimals = nDefaultDecimals];  (* if nDecimals = -1, use default *)
  kSum[stringList, nDecimals, iBase]
]    (* end of kSum[integer, nDec, base] *)


kSumFormatted[T_?MatrixQ, nDecimals0_Integer:-1, iBase_:10] :=
Module[ (* in this version, we input a T matrix *)
  (* returns a formatted value of type NumberForm, not a number *)
  { nDecimals = nDecimals0, z },
  If[nDecimals == -1, nDecimals = nDefaultDecimals];  (* if nDecimals = -1, use default *)
  z = kSum[T, nDecimals];
  nf[z, nDecimals]
]    (* end of kSumFormatted[matrix, nDec, base] *)


kSumFormatted[inputList_?VectorQ, nDecimals0_Integer:-1, iBase_:10] :=
Module[ (* returns a formatted value of type NumberForm, not a number *)
  { nDecimals = nDecimals0, z },
  If[nDecimals == -1, nDecimals = nDefaultDecimals];  (* if nDecimals = -1, use default *)
  z = kSum[inputList, nDecimals, iBase];
  nf[z, nDecimals]
]    (* end of kSumFormatted[list, nDec, base] *)


kSumFormatted[s_String, nDecimals0_Integer:-1, iBase_:10] :=
Module[ (* returns a formatted value of type NumberForm, not a number *)
  { nDecimals = nDecimals0, stringList = { s } },
  If[nDecimals == -1, nDecimals = nDefaultDecimals];  (* if nDecimals = -1, use default *)
  kSumFormatted[stringList, nDecimals, iBase]
]    (* end of kSumFormatted[string, nDec, base] *)


kSumFormatted[i_Integer, nDecimals0_Integer:-1, iBase_:10] :=
Module[ (* returns a formatted value of type NumberForm, not a number *)
  { nDecimals = nDecimals0, stringList = { ToString[i] } },
  If[nDecimals == -1, nDecimals = nDefaultDecimals];  (* if nDecimals = -1, use default *)
  kSumFormatted[stringList, nDecimals, iBase]
]    (* end of kSumFormatted[integer, nDec, base] *)


kPartialSum[nDigits_Integer?Positive, nDecimals0_Integer:-1] :=
Module[ (* partial sum calculation, using previous kSum *)
  (* using the same input just passed to kSum[ ], compute the partial sum of 1/k,
     where k has <= nDigits digits (that is, denominators are < 10^nDigits).
     warning: this could underflow if nDigits > about 2*10^9.
     first, call kSum[string, decimals].  then, we can call kPartialSum[digits, decimals].
     this function uses the existing values of global variables A, extraPol, n, Psi,
     iBaseSave, and kSumSave, all of which were set in the last call to kSum.
     note: if this returns less than the requested number of decimal places, then you must
     call kSum again with the desired number of places.
  *)
  { nDecimals = nDecimals0, partSum = 0, i, j, matBTrunc },
  If[nDecimals == -1, nDecimals = nDefaultDecimals];  (* if nDecimals = -1, use default *)

(* formal definition, but this is slow
  matBTrunc[a_?MatrixQ, M_] :=
    ((# - MatrixPower[a, M+1]).Inverse[# - a] - #) &[ IdentityMatrix[Length[a]] ];
*)

  matBTrunc[a_?MatrixQ, M_] :=
  Module[
    (* instead of computing the exact value of a^(M+1), we first convert "a"
       to floating-point, then exponentiate. if enough decimal places are used,
       this will produce an accurate value of a^(M+1).
    *)
    { nDec, ndigSum, (* a2, *) a3 },

    If[nDecimals < 1, nDecimals = 1];
    ndigSum = 1 + Floor[Log[10, kSumSave]];
    (* nDec = nDecimals + ndigSum + IntegerLength[M+1] + 5; *)
    nDec = nDecimals + ndigSum + (1+Floor[Log[10, M+1]]) + 5;  (* for mma version 5.2 *)

    (* a3 = MatrixPower[a, M+1] ; *)    (* very slow *)

    a3 = MatrixPower[N[a, nDec], M+1] ;  (* fast *)

    ((# - a3).Inverse[# - a] - #) &[ IdentityMatrix[Length[a]] ]
  ];    (* end of Module matBTrunc *)


  If[ (extraPol <= 0) || (kSumSave == 0),    (* must call kSum[ ] or kSumFormatted[ ] first *)
    Print["Error: no sum has been computed yet. Call kSum[ ] or kSumFormatted[ ] first."];
    Return[0]
  ];

  If[nDigits > extraPol,
     (* Check[ ] forces partSum to be 0 if an overflow or underflow occurs *)
     partSum = Check[ Sum[Psi[i, j, 1], {i, 1, extraPol}, {j, 1, n}] +
       normOne[matBTrunc[A, nDigits - extraPol] . Table[Psi[extraPol, j, 1], {j, n}] ] ,
           0, General::unfl 
                    ];    (* check only for underflow for mma version 5.2 *)
   ,
     (* else: nDigits <= extraPol; just sum up to i = nDigits *)
     partSum = Sum[Psi[i, j, 1], {i, 1, nDigits}, {j, 1, n}]
  ];  (* end If nDigits > extraPol *)

  If[partSum == 0, 0, N[partSum, Floor[ 1 + Log[10, partSum] ] + nDecimals ] ]

]    (* end of kPartialSum[nDigits, nDec] *)


kPartialSumThresholdX[pSum0_?NumericQ, nDecDefault_] :=
Module[
  (* this private function is called by public functions kPartialSumThreshold.

     using the previous input to kSum[ ], compute the number of digits
     at which the partial sum exceeds the threshold pSum0.
     example:
       kSum[9] = 22.920676619264150.
       kPartialSumThreshold[22] tells approximately how far we must go in the series
       to make the partial sum exceed 22.
       kPartialSumThreshold[22] returns {30, 31, 21.971055078178619, 22.066017232287173}.
       this means that if we add all terms in the series including all those having
       30 digits (that is, denominators < 10^30), the sum will be 21.971055078178619,
       and if we also include terms with denominators having 31 digits, the sum will
       be 22.066017232287173.  therefore, we would need at least some 31-digit
       denominators in order to make the sum exceed 22.

     in general, the input value (22, in this example) will lie  between the partial sums
     that are returned:
       21.971055078178619 < 22 < 22.066017232287173.

     a warning about using this function:
     if the threshold is too close to the sum returned by kSum[ ], you must either
     (a) reduce the threshold, then call kPartialSumThreshold[ ] again, or
     (b) increase the accuracy of the threshold by appending a few 0's, or by using
         mathematica's double backquote notation.

     here is an example showing how this can heppen.  suppose you compute
       kSum[314, 20] = 2299.82978276751833845359.
     then, if you enter
       kPartialSumThreshold[2299.8297827675]
     the error values {-1, -1, -1, -1} are returned.

     there are several ways around this:
     1. you can use mathematica's double backquote notation to increase
        the accuracy of your input. so, you could enter:
          kPartialSumThreshold[2299.8297827675``20]
        this prints and returns
          Calculate where the partial sum exceeds 2299.8297827675000000000
          {32381, 32382, 2299.82978276749999808677, 2299.82978276750001646395}
     2. append some 0's to the threshold:
         kPartialSumThreshold[2299.82978276750000000]
        this returns the same values as in (1) above.
     3. convert the decimal value to an exact rational number:
         kPartialSumThreshold[2299 + 8297827675/10000000000]
        this returns the same values as in (1) above.
     4. slightly lower the value of the threshold:
          kPartialSumThreshold[2299.8297827]
        this returns
          {24190, 24191, 2299.82978269996594626883, 2299.82978270003363424071}
        (as expected, this smaller threshold gives in slightly different results).
  *)

  { i, s, psa, psb, psc, a, b, c, nDec, diff, pSum, iLimit = 30, tAcc,
    errorReturn = { -1, -1, -1, -1 } },

  If[ (extraPol <= 0) || (kSumSave == 0),
    Print["Error: no sum has been computed yet. Call kSum[ ] or kSumFormatted[ ] first."];
    Return[ errorReturn ]
  ];

  pSum = pSum0;

  If[pSum <= 0, Return[ errorReturn ] ];    (* error *)
  nDec = nDecDefault;

  If[nDec < nDecimalsSave, nDec = nDecimalsSave];

(* remove this january, 2023
  If[Accuracy[pSum] < nDec, pSum = SetAccuracy[pSum, nDec] ];
*)

  Print["Calculate where the partial sum exceeds ", pSum];

  s = kSumSave;

  If[pSum > s,
    Print["Value must be less than the actual sum (", s, ")."];
    Return[ errorReturn ]
  ];    (* error *)

  If[pSum >= s,
    Print[pSum, " is too close to the actual sum (", s, ").",
          " Either enter a smaller threshold, or increase the accuracy of the threshold."];
    Return[ errorReturn ]
  ];    (* error *)

  a = 1;
  psa = kPartialSum[a, nDec] ;
  If[pSum < psa,
    Return[ { 0, 1, 0.0, psa } ];
  ];
  b = a;
  For[i = 1, i <= iLimit, i++,
    psb = kPartialSum[b, nDec] ;
    If[psb > pSum, Break[ ] ];
    a = b; psa = psb;
    b = b * 2;
  ];

  (* get here with b such that partial sum > pSum *)
  If[psb == pSum,
    Print[pSum, " is too close to the actual sum."];
    Print["Either use a smaller value, or increase the number of decimals (2nd parameter)."];
    Return[ errorReturn ]    (* error *)
  ];
  If[psb < pSum, Return[ errorReturn ] ];    (* error *)

  (* enter the loop below with psa < pSum and psb > pSum.
     compute c = (a + b)/2, then compute psc. *)

  diff = b - a;
  c = a + diff/2;

  For[i = 1, i <= iLimit, i++,
    psc = kPartialSum[c, nDec] ;
    If[psc > pSum,
      b = c; psb = psc;
     ,
      a = c; psa = psc;
    ];
    diff = b - a;
    If[diff < 2, Break[] ];
    c = a + diff/2;

  ];    (* end loop *)

  If[ (pSum <= psa) || (psb <= pSum),
    tAcc = Ceiling[Accuracy[pSum]] + 5;
    Print["Accuracy[pSum] = ", Accuracy[pSum], ", tAcc = ", tAcc];
    Print["Your threshold is too close to the sum of the entire series.\
 You must either (a) use a smaller value, or (b) increase the accuracy of the value by\
 appending 0's or by using the double backquote notation, such as: ", pSum, "``", tAcc];
    Return[ errorReturn ];
  ];

  Return[ { a, b, psa, psb } ];
];    (* end of kPartialSumThresholdX *)


kPartialSumThreshold[pSum0_?NumericQ, nDecimals_Integer:-1] :=
Module[
(* a numeric value was entered. this calls the private function kPartialSumThresholdX. *)
  { nDec = nDecimals },
  If[nDec == -1, nDec = nDefaultDecimals];  (* if nDecimals = -1, use default *)
  kPartialSumThresholdX[pSum0, nDec]
];




(* these return the A and T matrices *)

kSumGetT[inputList_?VectorQ, iBase_Integer:10] :=
Module[ (* given the input list, return the matrix T *)
  { lst },
  lst = convertInputListToStrings[inputList];
  If[Length[lst] == 0, Return[ {{0}} ] ];
  setT[lst, iBase]    (* return this matrix *)
]    (* end of kSumGetT[list] *)


kSumGetT[s_String, iBase_Integer:10] :=
Module[ (* given the input string s, return the matrix T *)
  { stringList = { s } },
  kSumGetT[stringList, iBase]
]    (* end of kSumGetT[string] *)


kSumGetT[i_Integer, iBase_Integer:10] :=
Module[ (* given the input integer, return the matrix T *)
  { stringList = { ToString[i] } },
  kSumGetT[stringList, iBase]
]    (* end of kSumGetT[integer] *)


(* show the current (private context) A matrix for the previously-entered input *)
kSumShowA[] := A;

kSumGetA[inputList_?VectorQ, iBase_Integer:10] :=
Module[ (* given the input list, return the matrix A *)
  { lst2, T, f, j, l, m, A, n },

  (* use only local variables here, not the global variables A and n.
     this allows the user to call kSum, then kSumGetA, then kPartialSum,
     without kSumGetA interfering with the global variables.
  *)

  lst2 = convertInputListToStrings[inputList];
  If[Length[lst2] == 0, Return[ {{0}} ] ];
  T = setT[lst2, iBase];

  (* the computation of A here is the same code as kSumX *)
  f[j_, l_, m_] := f[j, l, m] = If[T[[l, m]] == j, 1, 0] ;

  n = Dimensions[T][[1]] ;    (* number of rows *)

  A = (1/iBase) Sum[ Table[f[j, l, m + 1], {j, n}, {l, n}] , {m, 0, iBase-1} ] ;

  A    (* return this matrix *)

]    (* end of kSumGetA[list] *)


kSumGetA[s_String, iBase_Integer:10] :=
Module[ (* given the input string s, return the matrix A *)
  { stringList = {} },
  AppendTo[stringList, s];
  kSumGetA[stringList, iBase]
];    (* end of kSumGetA[string] *)


kSumGetA[i_Integer, iBase_Integer:10] :=
Module[ (* given the input integer, return the matrix A *)
  { stringList = {} },
  AppendTo[stringList, ToString[i]];
  kSumGetA[stringList, iBase]
];    (* end of kSumGetA[integer] *)


kSumTimeAndMemory[nDigits_Integer] :=
Module[
  (* display the estimated time and memory needed to calculate kSum[9, nDigits].
     based on calculations on a dell laptop for 100, 200, ..., 600 digits. *)
  { nd, t1, t0, tFast, mFast},
  nd = nDigits;
  If[nd < 50, nd = 50];

  t1 = Timing[ kSum[9, 100] ][[1]];

  (* t0 = actual time for kSum[9, 100] on the laptop used for benchmark *)
  t0 = 3.647 ;

  tFast = .55227 + .017407*nd + .00017173*nd^2 + (3.3708*10^-7)*nd^3 ;
  mFast = (6.5614*10^6) + 2836.1*nd + 18.432*nd^2 + .0054213*nd^3 ;

  (* the following cubic polynomial works better for 100 <= nd <= 1000 *)

  Print["Estimated time and memory for kSum[9, ", nd, "]:" ];
  Print[Round[tFast*t1/t0], " seconds, ", Round[mFast/1000000], " MBytes of memory"];
  Print["  Note: kSum[99, ", nd, "], kSum[999, ", nd,"] etc., will use more time and memory." ];
];    (* end of kSumTimeAndMemory *)


kSumSetDefaultDecimals[i_Integer] :=
Module[
  (* set the number of default decimal places *)
  { i2 = i },
  If[i2 == -1, i2 = nDefaultDecimals];
  If[i2 < 1, i2 = 1];
  If[nDefaultDecimals == i2,
    Print["Default number of `kempnerSums` decimal places is set to ", i2] ,
    Print["Default number of `kempnerSums` decimal places has been changed from ", nDefaultDecimals, " to ", i2]
  ];
  nDefaultDecimals = i2;
  nDefaultDecimals    (* return this value *)
];

kSumShowDefaultDecimals := nDefaultDecimals;

kSumGetDefaultDecimals[ i_:0 ] :=
Module[  (* no parameter needed *)
  { },
  Print["Current number of `kempnerSums` default decimal places is ", nDefaultDecimals]
];    (* end of kSumGetDefaultDecimals *)


End[ ]         (* end the private kempnerSums context *)

(* protect the exported symbols *)
Protect[kSum, kSumFormatted, kPartialSum, kPartialSumThreshold, kSumGetT, kSumGetA, kSumShowA,
        kSumTimeAndMemory, kSumSetDefaultDecimals, kSumGetDefaultDecimals,
        kSumShowDefaultDecimals];

EndPackage[ ]  (* end the kempnerSums package context *)