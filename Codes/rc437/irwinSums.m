(* :Title: irwinSums.m -- a package to compute sums of irwin series *)

(* :Mathematica Version: 4.0, 5.2, 6.0, 7.0, 8.0, 9.0, 10.3, 12.3, and 13.2 *)

(* :Package Version: 3.0, March 4, 2023:
    (1) change in computeMaxPowerNeeded[ ] to fix underflow warnings in Mathematica
        versions 12 and 13. the results are the same as in previous versions of
        Mathematica, but the warnings in versions 12 and 13 are now gone.
    (2) previously, after setPrintLevel[0] was used to set the print level to 0,
        calculations took far too long. this bug is now fixed.
    (3) added new function iPartialSumCheck[ ]: this uses simple summation of terms to
        check the output of iPartialSum[ ]. iPartialSumCheck[ ] does not do extrapolation
        or make estimates. the first 5 parameters are the same as for iPartialSum[ ].
        with the same input values, iPartialSumCheck[ ] and iPartialSum[ ] should give
        almost exactly the same results.
    (4) added new functions setDefaultDecimals[n] and getDefaultDecimals[ ].
        these let you set and view the default number of decimal places in the output.
    (5) in any calculation, you can enter -1 to use the default number of decimal places.
        the last parameter in each function is the base, which, if omitted, defaults to 10.
        the next to last parameter is the number of decimal places. if you specify the base
        as the last parameter, you must enter some value for the number of decimal places;
        if you enter -1, the default number of decimal places will be used.
    (6) these functions work if the base is any integer greater than 1, including > 10.
        the corresponding digits are the integers 0 through (base - 1). default base = 10.
    (7) removed the version of iPartialSumThreshold[ ] where the threshold parameter
        is entered as a string; this never worked well and is not needed anyway.
    (8) added functions setMaxIterations[n] and getMaxIterations[ ]. the previous
        default (5400) was too small to compute iSum[0, 434]. the new default (60000)
        is large enough that the user probably won't have to use setMaxIterations[ ].

    suggestions for future work:
      make it possible to compute the sum of 1/n where n has, for example, one occurrence
      of a 2-digit integer like 35; or m occurrences (m >= 0) of a k-digit integer (k > 1).
      note that iSum[35, 0, 15, 100] is different: this is the sum of 1/n where n has no
      base-100 digit whose value is (decimal) 35.

    Version: 1.5, August 18, 2013:
      (1) Changes to make the output more self-explanatory.
      (2) Fixed output function nf[ ] so for numbers between 0 and 1,
          we display exactly the requested number of decimal places
          instead of one more than the requested number.
      (3) In the NSum[ ] calls in computeMaxPowerNeeded[ ], added
            AccuracyGoal->nDecimals + 10
          to eliminate the "NIntegrate::izero ..." warning when running
          iSum[0, 200, 420].  This prevents local variable ns from being set to 0.

    Version 1.4, December 21, 2008:
      Cosmetic changes to comments.

    Version 1.3:
      added iPartialSumThreshold[ ] to compute how many digits are required
      in the denominators for the partial sum to reach a given threshold.

    Version 1.2:
      added setPrintLevel[ ] user function to control the amount of displayed output.
        default value = 1.  user can set the value to 0 to suppress all output,
        including "sum for k occurrences ...".
*)

(* :Author: Robert Baillie *)

(* :Copyright: none.  This code is in the public domain.
   Users are encouraged to improve this code.
*)

(* :Summary:
   This package computes sums of "Irwin" series.

   The harmonic series 1/1 + 1/2 + 1/3 + ... + 1/n + ... diverges.
   This means that the sum can be made as large as desired by adding
   enough terms.

   Suppose we delete from this series all terms with a "9" in the
   denominator.  That is, we delete 1/9, 1/19, 1/29, etc.  Then the
   remaining series
     1/1 + 1/2 + ... + 1/8 + 1/10 + ... + 1/18 + 1/20 + ...
   converges to a sum less than 80.  This was proved by A. J. Kempner
   in 1914.  The sum of this series is about 22.92067 66192 64150 .

   In 1916, Irwin proved that the sum of 1/n where n has at most a fixed
   number of occurrences of one or more digits, is a convergent series.

   For example, this Irwin series, where the denominators have exactly one 9,
     1/9 + 1/19 + 1/29 + ...
   converges.  The sum of this series is about 23.04428 70807 47848 .

   At first glance, it appears that this is just the harmonic series
   with 90% of the terms removed, and would therefore diverge just like
   the harmonic series does.  However, this series thins out much
   more than than the harmonic series.  For example, the vast majority of
   100-digit integers have more than one 9, so would be excluded from the sum.

   Irwin's result is a generalization of Kempner's.  In Kempner's series,
   the digit 9 occurs zero times.  It also follows that the sum of 1/n
   where n has exactly n1 occurrences of digit d1, n2 occurrences of d2,
   etc., converges.

   These series converge much too slowly to get even a rough
   estimate of the sums by simply adding up the terms.

   This package computes the sums of Irwins' series to high precision.
*)

(* :Keywords: kempner, irwin, harmonic series *)

(* :Sources:
   The original article that proves convergence of these series is:
      Frank Irwin, "A Curious Convergent Series",
      American Mathematical Monthly, vol. 23, pages 149-152 (May, 1916).
      Available free through JSTOR at http://dx.doi.org/10.2307/2974352 .
   See also:
      A. J. Kempner, "A Curious Convergent Series",
      American Mathematical Monthly, vol. 21, pages 48-50 (February, 1914).
      Available free through JSTOR at http://dx.doi.org/10.2307/2972074 .

      Robert Baillie, "Sums of Reciprocals of Integers Missing a Given Digit",
      American Mathematical Monthly, vol. 86, no. 5, May, 1979, pp. 372-374.

      Thomas Schmelzer and Robert Baillie, "Summing a Curious, Slowly Convergent Series",
      American Mathematical Monthly, vol. 115, no. 6, June-July, 2008, pp. 525-540.
*)


BeginPackage[ "irwinSums`" ]

(* :Examples:
   general form: iSum[digits, counts, nDecimals, iBase]
   iSum[9, 0] = sum of 1/n where n has no 9's = 22.920676619264150 .
   iSum[9, 1] = sum of 1/n where n has exactly one 9 = 23.044287080747848 .
   iSum[{8, 9}, {1, 1}] = sum of 1/n where n has one 8 and one 9 = 5.756763686415333 .
   iSum[{9, 3}, {2, 0}] = sum of 1/n where n has two 9's and no 3's = 2.593253652747189 .

iSum[9, 2]  (this computes the sum of 1/n where n has exactly two 9's)
Detailed explanation of the output: five lines are printed:
Line
 1    sum = 23.026040265961244
 2     sum with exactly 0 occurrences of 9 = 22.920676619264150
 3     sum with exactly 1 occurrence  of 9 = 23.044287080747848
 4     sum with exactly 2 occurrences of 9 = 23.026040265961244
 5     sum with at most 2 occurrences of 9 = 68.991003965973242
Line 1: This is the requested sum of 1/n where n has exactly two 9's.
Lines 2 - 4: Three sums were computed as intermediate steps in this calculation:
  the sums of 1/n where n has exactly zero, one, or two 9's.
Line 5 shows the total of the three sums in lines 2 - 4. This is just the sum
  of 1/n where n has at most two 9's.

in all functions, if the number of decimal places is given as -1, the default is used;
with this feature, you don't have to keep specifing the value for the current default.
here is a sum in base 2; the 4th parameter is the base.
iSum[1, 2, 20, 2] = sum of 1/n where n has two 1's in base 2; 20 decimal places.
iSum[1, 2, -1, 2] = same as above, but the number of decimals is the current default value.

iSum[{9, 3}, {2, 1}]  (compute the sum of 1/n where n has two 9's and one 3)
Detailed explanation of the output: two lines are printed:
   sum = 4.169026439566082
    sum with at most 2 9's and at most 1 3 = 34.282119242240692
Line 1: This is the requested sum of 1/n where n has exactly two 9's and one 3.
Line 2: Six sums were computed as intermediate steps in this calculation. They are
  the sums of 1/n where n has exactly:
    zero 9's and zero 3's
    zero 9's and one 3
    one 9 and zero 3's
    one 9 and one 3
    two 9's and zero 3's
    two 9's and one 3.
Line 2 shows the total of these six sums. This is just the sum of 1/n
  where n has at most two 9's and one 3.
*)


(* usage messages for this context, and for the exported functions *)

irwinSums::usage = "irwinSums.m is a package that computes sums of Irwin and some Kempner series.
This package has functions iSum, iSumFormatted, iPartialSum, iPartialSumCheck, iPartialSumThreshold,
setPrintLevel, and setDefaultDecimals.
  iSum[d, k]: computes the sum of 1/n where n has exactly k occurrences of the digit d.
  iSum[{d1, d2 ,...}, {k1, k2, ...}]: sum of 1/n where n has exactly k1 occurrences of d1,
   k2 occurrences of d2, etc.
  iSum[digit(s), count(s), m] rounds the result to m decimal places.
  iSum[digit(s), count(s), m, b] does calculations with m digits in base b.
  iSumFormatted[...] is the same as iSum, but formats the output in groups of 5 digits.
  iPartialSum[d, k, p] or iPartialSum[{d1, d2 ,...}, {k1, k2, ...}, p] gives the partial sum
    through denominators < 10^p.
  iPartialSumCheck[d, k, p] direct summation, with no extrapolation or estimation, to verify
  the results of iPartialSum[ ] through denominators < 10^p.
  iPartialSumThreshold[d, k, t] and iPartialSumThreshold[{d1, d2 ,...}, {k1, k2, ...}, t] tell
    how many digits are needed in the denominators in order to make the partial sum
    reach your threshold, t.
 setPrintLevel sets the print level to control the amount of output; default = 1.
 setDefaultDecimals sets the default number of decimal places in the output.
These functions let you specify, as the last two parameters, the number of decimal places
 and the base (at least 2). If you specify the base, you cannot omit the number of decimal places.
 You can either enter the desired number of decimal places, or -1 to use the default value." ;

(* here are usage messages for individual functions *)

iSum::usage = "general form: iSum[digits, counts, decimals, base]
iSum[d, k] computes the sum of the series 1/n where the digit d occurs\
 exactly k times in n.
iSum[{d1, d2, ...}, {k1, k2, ...}] is the sum where the digit d1 occurs exactly k1 times,\
 d2 occurs exactly k2 times, etc.
iSum[d, k, m] and iSum[{d1, d2, ...}, {k1, k2, ...}, m] give the sum to m decimal places.
 All results are rounded to the number of decimal places shown.
Examples:
  iSum[9, 0] = sum of 1/n where n has no 9's = 22.920676619264150 .
  iSum[9, 1] = sum of 1/n where n has exactly one 9 = 23.044287080747848 .
You can also specify a list of several conditions on the digits:
  iSum[{9, 3}, {2, 0}] = sum of 1/n where n has two 9's and no 3's = 2.593253652747189 .
iSum takes an optional third parameter: the number of decimal places.\
 If not specified, the default number of decimals is used.
iSum takes an optional fourth parameter: the base. If not specified, base 10 is used.
If you specify the fourth parameter (base), you must enter the third parameter\
 (the number of decimals); if the third parameter is -1, the default number of decimals\
 will be used.
Examples of calculations in base 2:
  iSum[1, 1, 20, 2] = sum of 1/n where n has one 1 in base 2.\
 The sum is 1/1 + 1/2 + 1/4 + ... = 2 .
  iSum[1, 3, 20, 2] = sum (to 20 decimals) of 1/n where n has three 1's in base 2\
 = 1.42859154585263812400 .
  iSum[0, 0, -1, 2] = sum  (to default number of decimals) of 1/n where n has no 0's in base 2\
 = 1.606695152415292 ." ;

iSumFormatted::usage = "Same as iSum, but iSumFormatted formats the output\
 into groups of 5 digits." ;

iPartialSum::usage = "general form: iPartialSum[digits, counts, p, decimals, base]
iPartialSum[d, k, p] computes the partial sum of 1/n\
 where n has k occurrences of d, for n < 10^p (or n < b^p, where b is the base).
 Similarly for iPartialSum[{d1, d2 ,...}, {k1, k2, ...}, p].
Example:
 iSum[9, 0] = 22.920676619264150. The partial sum for n < 10^30 is\
 iPartialSum[9, 0, 30] = 21.971055078178619 .
The optional 4th parameter iPartialSum[..., ..., p, m] gives the partial sum to m decimals.
The optional 5th parameter is the base:
  iPartialSum[1, 1, 6, -1, 2] = partial sum of 1/n for n < 2^6,  where n has one 1 in base 2,\
 to the default number of decimals.
  Note: this last series is just 1/1 + 1/2 + 1/4 + 1/8 + 1/16 + 1/32 = 63/32 = 1.96875." ;

iPartialSumThreshold::usage =
"general form: iPartialSumThreshold[digits, counts, threshold, decimals, base]
 iPartialSumThreshold[d, k, t] tells how many digits are needed in the denominators in order\
 to make the partial sum equal to or greater than your threshold, t.
 Four numbers are returned: { d1, s1, d2, s2 }:
 d2 is the number of digits required in the denominators to make the partial sum >= t.
 d1 = d2 - 1.
 s1 and s2 are the partial sums for n < 10^d1 and for n < 10^d2.
 The output sums s1 and s2 are such that s1 < t <= s2.
 
Example 1. iPartialSumThreshold[9, 1, 23] computes how many digits are needed in the denominators\
 to reach a partial sum of 23.
 The output is {80, 22.995762680948152, 81, 23.000125707332644}.
 Therefore, denominators of 81 digits are required:
  The sum through n < 10^80 is about 22.995762680948152.
  The sum through n < 10^81 is about 23.000125707332644.
 iPartialSum[ ] confirms this result:
   iPartialSum[9, 1, 80] = 22.995762680948152
   iPartialSum[9, 1, 81] = 23.000125707332644 .

Example 2: iPartialSumThreshold[0, 0, 1.6, -1, 2] computes how many base 2 digits are needed\
 in the denominators to reach a partial sum of 1.6.
 The output is {7, 1.598862238994319258, 8, 1.6027838076217702389}.
 Therefore, the sum through n < 2^7 is < 1.6, while the sum through n < 2^8 is > 1.6 .

Example 3. This shows what can go wrong if your threshold is threshold is too close\
 to the sum of the entire series:
   iSum[9, 1] = 23.044287080747848.
   iPartialSumThreshold[9, 1, 23.044287080747] returns error values {-1, -1, -1, -1}.
   The error message tells you to specify more accuracy. You can do this using Mathematica's\
 double backquote notation:
   23.044287080747``20 = 23.0442870807470000000.
     iPartialSumThreshold[9, 1, 23.044287080747``20]
   returns {327, 23.044287080746936363446, 328, 23.044287080747025118024} .
   You can also increase the accuracy by appending some trailing 0's. This also works:
     iPartialSumThreshold[9, 1, 23.0442870807470000000].
   You can also get iPartialSumThreshold[ ] to work by making the threshold a little smaller.
   One way to do this is to remove trailing non-zero digits from the threshold.
   For example, this works: iPartialSumThreshold[9, 1, 23.04428708074].
   returns {305, 23.044287080739194, 306, 23.044287080740034} .
   (This returned value is different because this threshold is different.)

 You can also specify a list of digits and counts:\
  iPartialSumThreshold[{d1, d2 ,...}, {k1, k2, ...}, t].
 You can also specify the number of decimal places for the output, and the base:\
   iPartialSumThreshold[d, k, t, nDecimals, base]\ 
   and\
   iPartialSumThreshold[{d1, d2 ,...}, {k1, k2, ...}, t, nDecimals, base].
   If you specify the base, you must enter the number of decimals, or -1 to to use the default
    number of decimals." ;

iPartialSumCheck::usage = "general form: iPartialSumCheck[digits, counts, p, decimals, base, print]
iPartialSumCheck[ ] uses direct summation (with no extrapolation\
 or estimates), to double-check the results of iPartialSum[ ].
 iPartialSumCheck[digits, counts, k] computes the sum for n < 10^k.
 in base b, iPartialSumCheck[digits, counts, k, nDecimals, b] computes the sum for n < b^k.
 Example 1: sum of 1/n where n has one 9:
    iSum[9, 1] = 23.044287080747848;
  compute and check the partial sum for n < 10^5
    iPartialSum[9, 1, 5] = 2.124895031316511;
    iPartialSumCheck[9, 1, 5] = 2.12489503131651.
 Example 2: sum of 1/n where n has one 0 in base 2.
    Parameter 3 is the number of decimal places (-1 for the default), parameter 4 is the base:
    iSum[0, 1, -1, 2] = 1.462590735044365.
  Verify the partial sum for n < 2^20 (parameter 4: # of decimals, parameter 5: the base):
    iPartialSum[0, 1, 20, 25, 2] = 1.4625701292878647374552066 (25 decimals);
    iPartialSumCheck[0, 1, 20, -1, 2] = 1.46257012928786 (default number of decimals)." ;

setPrintLevel::usage = "setPrintLevel[n] sets the print level = 0, 1, 2, 3, 4. Larger values\
produce more output. Default = 1." ;

getPrintLevel::usage = "getPrintLevel[ ] displays the current print level." ;

setMaxIterations::usage = "setMaxIterations[n] sets the maximum number of iterations to n.\
 this is the maximum number of digits to use in the denominators.\
 if convergence has not occurred by this point, a warning message is printed." ;

getMaxIterations::usage = "getMaxIterations[ ] displays the current maximum number of iterations.\
 this is the maximum number of digits to use in the denominators." ;

setDefaultDecimals::usage = "setDefaultDecimals[n] sets the default number of decimal places\
in the output to n. Initially, this value is set in this file to 15." ;

getDefaultDecimals::usage = "getDefaultDecimals[] displays the default number of decimal places\
 in the output." ;


Begin["`Private`"]    (* begin the private context (implementation) *)

Off[ General::spell1 ];
Off[ General::spell ];


(* here are the global variables *)

(* sjk and sjkPrev are tables (arrays) of size maxJ by maxIndexUsed.  the
   first dimension is a power, the second is an index number 1 .. maxIndexUsed.
*)
sjk;
sjkPrev;

cumulativeSums1;    (* this is a small array, size = countList[[1]] + 1 *)

iSumPrintLevel = 1;          (* default print level *)
iSumMaxIterationsMin = 5000; (* minimum value, enough for iSum[9, 10, 100] *)

(* here is the default maximum number of iterations (i.e., digits in the denominators
   to include in the sum). 15000 is enough for iSum[0, 434, 100].
   however, iSum[9, 0, -1, 1000], needs denominators of about 53000 digits (in base 1000).
   so, set this to 60000. if this is too small, a message tells the user how to increase it.
   iSum[9, 0, -1, 1000] = 6802.410165253090787 (takes about 400 seconds on 2020-era laptop).
*)
iSumMaxIterations = 60000;   (* default *)

(* $MachinePrecision is typically about 15 *)
originalDefaultDecimals = 15;
nDefaultDecimals = originalDefaultDecimals;  (* setDefaultDecimals[n] can change this to any desired value *)


Unprotect[iSum, iSumFormatted, iPartialSum, iPartialSumThreshold, iPartialSumCheck,
          setPrintLevel, getPrintLevel, setMaxIterations, getMaxIterations,
          setDefaultDecimals, getDefaultDecimals];


setDefaultDecimals[i_Integer] :=
Module[
  (* set the number of default decimal places *)
  { i2 = i },
  (* if -1, set to the original default that is hard-coded in this file *)
  If[i2 == -1, i2 = originalDefaultDecimals];
  If[i2 < 1, i2 = 1];
  If[nDefaultDecimals == i2,
    Print["Default number of 'irwinSums' decimal places was already set to ", i2] ,
    Print["Default number of 'irwinSums' decimal places changed from ", nDefaultDecimals, " to ", i2]
  ];
  nDefaultDecimals = i2;
  nDefaultDecimals    (* return this value *)
];  (* end of setDefaultDecimals *)


getDefaultDecimals[ i_:0 ] :=
Module[  (* no parameter needed *)
  { },
  Print["Current number of 'irwinSums' default decimal places is ", nDefaultDecimals]
];    (* end of getDefaultDecimals *)


setPrintLevel[i_Integer:1] :=
Module[
  { i2 },
  i2 = i;
  (* 0 is the minimum value a user can set.  however, some
     functions like iPartialSumThreshold can set it lower *)
  If[i2 < 0, i2 = 1];  (* default *)
  If[i2 > 4, i2 = 4];
  If[i2 == iSumPrintLevel,
    Print["Print level was already set to ", iSumPrintLevel] ,
    Print["Print level changed from ", iSumPrintLevel, " to ", i2]
  ];
  iSumPrintLevel = i2;
  iSumPrintLevel  (* return this value *)
];    (* end of setPrintLevel *)


getPrintLevel[ i_:0 ] :=
Module[
  { },
  Print["Current print level is ", iSumPrintLevel]
];    (* end of getPrintLevel *)


setMaxIterations[i_Integer:1] :=
Module[
  { i2 },
  i2 = i;
  (* iSumMaxIterationsMin is the minimum value a user can set. *)
  If[i2 < iSumMaxIterationsMin, i2 = iSumMaxIterationsMin];
  If[i2 == iSumMaxIterations,
    Print["Max iterations is set to ", iSumMaxIterations] ,
    Print["Max iterations changed from ", iSumMaxIterations, " to ", i2]
  ];
  iSumMaxIterations = i2;
];    (* end of setMaxIterations *)

getMaxIterations[ i_:0 ] :=
Module[
  { },
  Print["Current max iterations is ", iSumMaxIterations]
];    (* end of getMaxIterations *)



getDigitsforNFunction[y_, nDec_] :=
Module[
(* this computes the number of digits to send to the N[ ] function.
   we want to display an extended-precision number to (nDec) decimal places,
   not counting the leading zeros if the number is between 0 and 1.
   if Abs[y] < 1, then N[y, nDec] displays the correct number of decimal places.
   otherwise, in N[y, nDec], the number of digits shown includes digits to the left of
   the decimal point.  in this case, we must increase the number of digits sent to N[ ].
*)
  { nExtra },
  If[Abs[y] >= 1,
    nExtra = 1 + Floor[ Log[10, Abs[y]] ],
    nExtra = 0
  ];
  nExtra + nDec
]    (* end of getDigitsforNFunction *)


(* nf0 formats a number to (nDec) decimal places *)
nf0[y_, nDec_] := If[y == 0, 0, N[y, getDigitsforNFunction[y, nDec]] ];

(* nf1 formats a number to (nDec) decimal places, with a space every 5 digits *)
nf1[y_, nDec_] := If[y == 0, 0, 
  NumberForm[y, getDigitsforNFunction[y, nDec], DigitBlock->5, NumberSeparator->{""," "}] ];

(* nf[ ] does number formatting.  show (nDec) decimal places, not counting leading zeros
   if the number is between 0 and 1.
   if the iFlag is 1, this does "NumberForm" formatting with spaces separating groups of
   5 digits; otherwise, the standard N[ ] function is used.
*)
nf[y_, nDec_, iFlag_:0] := If[iFlag == 0, nf0[y, nDec], nf1[y, nDec] ];


(* powerx is just like Power[], but powerx returns 0^0 = 1 without "Indeterminate" warnings *)
powerx[0, 0] := 1;               (* special case *)
powerx[x_, y_] := Power[x, y] ;  (* in other cases, use the built-in function Power[] *)


isThisASpecialDigit[iDigit_, nConditions_, digitList_List] :=
Module[
  (* if iDigit is in the list of special digits,
     then return the 1-based location in the list;
     otherwise, return 0. *)
  { j },
  For[j = 1, j <= nConditions, j++,
    If[iDigit == digitList[[j]], Return[j]]
  ];

  0    (* return this value *)

];    (* end of isThisASpecialDigit *)


bn[iBase_Integer, n_Integer, nConditions_Integer, digitList_?VectorQ] :=
Module[
  (* this is for a set of special digits
     compute sum(k = 0 through iBase-1) of k^n (for k not a special digit).
     example: if iBase = 10, one special digit (d),
     compute bn = 9 (n = 0), bn = 0^n + 1^n + ... + 9^n - d^n (n > 0).
  *)
  { bn = 0, k },

  If[n == 0, Return[iBase - nConditions] ];    (* iBase minus number of special digits *)

  For[k = 1, k <= iBase - 1, k++,
    If[isThisASpecialDigit[k, nConditions, digitList] != 0, Continue[] ];
    bn += powerx[k, n];
  ];

  Return[bn];
];    (* end of bn *)


checkInputLists[digitList_?VectorQ, countList_?VectorQ, iBase_:10] :=
Module[
(* called by computeIrwinSum, which is called by the list versions of
   iSum[ ], iPartialSum[ ], and iPartialSumThreshold[ ].
   this is also called by iPartialSumCheck[ ].
*)
  { nConditions, i, j },

  (* validate all input entered by the user *)
  If[ (iBase < 2) || ( ! IntegerQ[iBase]),
    (* Print["error: base = ", iBase, " must be an integer from 2 through 10."]; *)
    Print["error: base = ", iBase, " must be an integer greater than 1."];
    Return[0];
  ];

  nConditions = Length[digitList];

  If[nConditions < 1,
   Print[" error 1: nConditions = ", nConditions, " must be at least 1."];
   Return[0];
  ];
  If[nConditions > iBase,
    Print[" error 2: nConditions = ", nConditions, " must be <= base = ", iBase];
    Return[0];
  ];

  If[nConditions != Length[countList],
    Print["Mismatch: digit list and count list have different lengths (", Length[digitList],
          " and ", Length[countList], ")"];
    Return[0];
  ];

  For[i = 1, i <= nConditions, i++,
    If[ (IntegerQ[digitList[[i]]] != True) || (digitList[[i]] < 0) || (digitList[[i]] >= iBase),
      Print["digit # ", i, " = ", digitList[[i]], " is not a valid digit in base ", iBase];
      Return[0];
    ];
    (* If[IntegerQ[countList[[i]]] != True, *)
    If[ (IntegerQ[countList[[i]]] != True) || (countList[[i]] < 0),
      Print["count # ", i, " = ", countList[[i]], " is not a valid count"];
      Return[0];
    ];
    For[j = i+1, j <= nConditions, j++,
      If[digitList[[i]] == digitList[[j]],
        Print["error: digit # ", i, " = ", digitList[[i]], " is duplicated"];
        Return[0];
      ];
    ];    (* end for j loop *)
  ];    (* end for i loop *)

  (* if every non-zero digit has zero occurrences, then we have an empty sum.
     example: the sum of 1/n where n has no 1 in base 2. 
     just print a message and return 0
  *)
  If[nConditions == iBase - 1,
    j = 0;
    For[i = 0, i <= iBase-1, i++,
      If[ (countList[[i]] == 0) && (digitList[[i]] != 0),
        j++;
      ];    (* end If[ ] *)
    ];    (* end for i loop *)
    If[j == iBase - 1,
      Print["all non-zero digits have 0 occurrences: this is an empty sum"];
      Return[0];
    ];
  ];    (* end If[ ] *)

  Return[ 1 ];  (* all ok *)

];  (* end of checkInputLists *)


getArrayIndexFromList[n_Integer, ci_?VectorQ, iList_?VectorQ] :=
Module[
 (* this is called with nConditions = n and countList = ci.
    this function is the inverse of getListFromArrayIndex. *)
 { i, iSum = 0, iProd = 1 },
  iSum = iList[[1]];
  For[i = 2, i <= n, i++,
    iProd = iProd * (ci[[i-1]] + 1);
    iSum += iList[[i]] * iProd;
  ];

  iSum + 1    (* return this value; all arrays in mathematica are 1-based *)

];    (* end of getArrayIndexFromList *)


getListFromArrayIndex[iArrayIndex_Integer, n_Integer, ci_?VectorQ] :=
Module[
(*
  given an array index, find the list iList[1..n] that gives this index.
  this is called with nConditions = n and countList = ci.
  this function is the inverse of getArrayIndexFromList.
*)
  { i, iProd = 1, iTemp, iList = Table[0, {n}] },

  iProd = Product[ci[[i]] + 1, {i, n-1}];

  iTemp = iArrayIndex;
  iTemp = iTemp - 1;    (* for mma *)
  For[i = n-1, i >= 1, i--,
    iList[[i+1]] = Floor[ iTemp/iProd ];
    iTemp = iTemp - iProd*iList[[i+1]];    (* remainder *)
    iProd = Floor[ iProd/(ci[[i]] + 1) ];
  ];
  iList[[1]] = iTemp;

  iList    (* return this list *)

];    (* end of getListFromArrayIndex *)


updateCumulativeSums1[iBase_Integer, nConditions_Integer, countList_?VectorQ] :=
Module[
  (* if there is one condition, and we are summing the series for k occurrences
     of a digit, then keep track of all cumulative sums for i = 0, 1, 2, ..., k
     occurrences of that digit. *)
  { i, iArrayIndex, kOccurFound },

  kOccurFound = Table[ 0, {iBase + 1} ];

  For[i = 0, i <= countList[[1]], i++,
    kOccurFound[[1]] = i;
    iArrayIndex = getArrayIndexFromList[nConditions, countList, kOccurFound];
    cumulativeSums1[[i+1]] += sjkPrev[[ 1, iArrayIndex ]];
  ];
];    (* end of updateCumulativeSums1 *)


printSumsWithKOccurrences[nDec_Integer, nConditions_Integer, digitList_?VectorQ,
                          countList_?VectorQ, iFormatted_Integer] :=
Module[
  (* if there is just one condition, then print
     the sum for exactly k occurrences, k = 0, 1, 2, ... countList[[1]]. *)
  { k, occurStr },
  If[nConditions != 1, Return[] ];

  For[k = 0, k <= countList[[1]], k++,
    If[k == 1, occurStr = "occurrence ", occurStr = "occurrences"];
    Print[" sum with exactly ", k, " ", occurStr, " of ", digitList[[1]], " = ",
          nf[cumulativeSums1[[k+1]] , nDec, iFormatted] ]
  ];  (* end for k loop *)

];    (* end of printSumsWithKOccurrences *)


printAtMostSumNCond[nConditions_Integer, digitList_?VectorQ, countList_?VectorQ, sumSmallerK_,
                    nDec_Integer, iFormatted_Integer] :=
Module[
  (* print the "at most" sums on the digits when there are at least two conditions;
     nConditions equals the length of the digitList and countList vectors.
     for two conditions, show both conditions; for 3 or more, show the first and the last
     for iSum[{7, 8}, {2, 3}], print
      sum with at most 2 7's and at most 3 8's = 54.974509900258921
     iSum[{7, 8, 9}, { 2, 3, 4}]
      sum with at most 2 7's, ..., and at most 4 9's = 51.551633838456648
  *)
  { k, dotStr, s1Str, s2Str },
  If[nConditions < 2, Return[] ];
  If[nConditions == 2, dotStr = "", dotStr = ", ...," ];
  If[countList[[1]] == 1, s1Str = "", s1Str = "'s" ];
  If[countList[[nConditions]] == 1, s2Str = "", s2Str = "'s" ];

  Print[" sum with at most ", countList[[1]], " ", digitList[[1]],
        s1Str, dotStr," and at most ", countList[[nConditions]], " ",
        digitList[[nConditions]], s2Str, " = ", nf[sumSmallerK, nDec, iFormatted]
  ];

];    (* end of printAtMostSumNCond *)


directSummation[iBase_Integer, numDigits_Integer, maxPower_Integer, nConditions_Integer,
                digitList_?VectorQ, countList_?VectorQ, nDec_Integer] :=
Module[
  (* compute partial sums by directly adding terms whose denominators have (numDigits) digits *)
  { nTerms,    (* return this value *)
    iStart, iLast, i, iNumber, iDigitPos, iQuot, iRemainder, iDigit, jPower,
    k, kFound, iOK, iMatch, sumK = 0,
    kOccurFound,
    iArrayIndex,
    xNumb, xRecip, xRecipPower
  },

  kOccurFound = Table[0, {nConditions}];    (* 1-based, one for each special digit *)
  nTerms = 0;
  iStart = iBase^(numDigits - 1);
  iLast  = iBase * iStart - 1;  (* iLast  = iBase^numDigits - 1 *)

  For[i = iStart, i <= iLast, i++,
    (* break up (i) into individual digits *)
(* note for a future version: it might be faster to use digits = DigitCount[i, iBase]
   test this later; 2023
*)
    (* clear all counts *)
    For[k = 1, k <= nConditions, k++, kOccurFound[[k]] = 0];
    iNumber = i;
    For[iDigitPos = 1, iDigitPos <= numDigits, iDigitPos++,
(*
      iQuot = Floor[ iNumber/iBase ];
      iRemainder = iNumber - iBase*iQuot;
*)
      (* next line is 40% faster than above two lines; 2023 *)
      { iQuot , iRemainder } = QuotientRemainder[ iNumber , iBase ];
      iDigit = iRemainder;
      kFound = isThisASpecialDigit[iDigit, nConditions, digitList];
      (* if this is the digit for condition number 2, increment the 2nd total *)
      If[kFound > 0,
        kOccurFound[[kFound]]++ ;
      ];
      iNumber = iQuot;
    ];    (* end for iDigitPos loop *)

    iOK = 1;
    iMatch = 1;
    For[k = 1, k <= nConditions, k++,
      If[kOccurFound[[k]] > countList[[k]],
        iOK = 0;    (* this (i) had too many occurrences of one or more digits *)
        Goto[nextI];    (* go to next iteration of main (i) loop *)
      ];
      If[kOccurFound[[k]] < countList[[k]], iMatch = 0];
    ];    (* end for k loop *)

    If[iMatch == 1,    (* (i) has n1 occurrences of digit d1, n2 of d2, etc. *)
      nTerms = nTerms + 1
    ];
    xNumb = i;
    xRecip = N[1/xNumb, nDec];

    (* now compute the place in the sjkPrev array where this sum belongs *)
    iArrayIndex = getArrayIndexFromList[nConditions, countList, kOccurFound];
    sjkPrev[[ 1, iArrayIndex ]] += xRecip;

    xRecipPower = xRecip;    (* xNumb^(-1) *)
    For[jPower = 2, jPower <= maxPower, jPower++,
      xRecipPower = xRecipPower*xRecip;    (* xNumb^(-jPower) *)
      sjkPrev[[ jPower, iArrayIndex ]] += xRecipPower;
    ];

Label[nextI];

  ];    (* end For i loop *)
  nTerms    (* return this value *)

];    (* end of directSummation *)


computeMaxPowerNeeded[iBase_Integer, nDecimals_Integer, dsDigits_Integer] :=
Module[
  (* enter with nDecimals, which specifies the desired tolerance,
     and dsDigits = 2nd parameter to directSummation;
     dsDigits is directSumDigits in the calling function, computeIrwinSum[ ].
     let a = iBase^(dsDigits - 1), b = iBase^dsDigits - 1, and
     eps = 10^-nDecimals.
     directSummation computes Sum[1/n^j, {n, a, b}]
     for j = 1, 2, ..., k.
     we want to estimate the value of k that makes
       Sum[1/n^k, {n, a, b}] < eps .
     in bases 2 through 10, a good approximation is
       Log[iBase, 10] * nDecimals/(dsDigits - 1).
     if this is not close to a value that makes the sum < eps, then
     we must solve an equation.  we estimate the sum by an integral:
       Integrate[x^-c, {x, a, b}] = (b^(1-c) - a^(1-c))/(1-c).
     then we find the value of c that makes this < eps.
  *)
  { eps, a, b, r0, k, ns, c, r },

  eps = 10^(-nDecimals);    (* maximum tolerance *)
  (* a and b are the lower and upper limits of directSummation *)
  a = iBase^(dsDigits - 1);
  b = iBase * a - 1;  (* b = iBase^dsDigits - 1 *)

  (* next line is why we want dsDigits > 1 (= directSumDigits in (computeIrwinSum[ ]) *)
  r0 = Ceiling[ Log[iBase, 10] * nDecimals/(dsDigits - 1) ];
  (* this r0 is usually a good approximation to the value we need *)

  (* find a value of k that guarantees Sum[N[1/n^k], {n, a, b}] < eps *)
  For[k = r0, k <= 10*r0, k++,
(*    ns = NSum[1/n^k, {n, a, b}]; *)
(* NSum[ ] works in version 10, but fails in versions 12 and 13;
   also, NSum[ ] is sometimes less accurate than Sum[ N[], {n, a, b}] *)
(*    ns = NSum[1/n^k, {n, a, b}, AccuracyGoal->nDecimals + 10]; *)
(* next line works in versions 12 and 13; 2023 *)
    ns = Sum[ N[1/n^k, nDecimals + 10], {n, a, b}];
    ns = Re[ns];    (* needed only for mathematica version 5.2 *)
    If[ns < eps, Goto[loopDone] ];
  ];    (* end for k loop *)

  (* if we get here, we will have to solve the equation *)
  r = FindRoot[(b^(1 - c) - a^(1 - c))/(1 - c) == eps, {c, r0} ];
  r0 = Ceiling[c /. r];    (* get the numerical value from the rule *)
  (* find a value that guarantees NSum < eps *)
  For[k = r0, k <= 10*r0, k++,
(*    ns = NSum[1/n^k, {n, a, b}]; *)
(* next line works in version 10, but fails in versions 12 and 13 *)
(*    ns = NSum[1/n^k, {n, a, b}, AccuracyGoal->nDecimals + 10]; *)
(* next line works in versions 12 and 13; 2023 *)
    ns = Sum[ N[1/n^k, nDecimals + 10], {n, a, b}];
    ns = Re[ns];    (* needed only for mathematica version 5.2 *)
    If[ns < eps, Goto[loopDone] ];
  ];    (* end for k loop *)
  Return[ -r0 ];    (* return this negative value to indicate an error *)

Label[loopDone];
  r0 + 2   (* add 2 more powers just to be safe *)
];    (* end of computeMaxPowerNeeded *)


checkDigitAndCountParams[param1_, param2_] :=
Module[
  (* computeIrwinSum[ ] takes two params for digit(s) and count(s),
     and assumes they are vectors of equal lengths (the lengths could be 1).
     if these are integers, convert them to vectors of length 1.
  *)
  { nInts = 0, nLists = 0, arg1, arg2 },

  If[ (VectorQ[param1] && VectorQ[param2]) , nLists = 2];
  If[ (IntegerQ[param1] && IntegerQ[param2]) , nInts = 2];
  If[ (nLists != 2) && (nInts != 2),
    Print["error: the digit and count parameters must be two integers or two lists"];
    Return[ { -1 , -1 } ];  (* error: return integers *)
  ];

  If[nLists == 2,
    arg1 = param1;   arg2 = param2 ,
    arg1 = {param1}; arg2 = {param2}  (* convert these to vectors *)
  ];

  Return[ {  arg1  ,  arg2  } ] ;  (* return the list of two vectors *)

];  (* end of checkDigitAndCountParams *)


computeIrwinSum[iBase_Integer, digits_, counts_,
                nDecimals0_Integer, iFormatted_Integer,
                nDigits_:0, threshold_:-1 ] :=
Module[
  (* this private function is the main calculation routine for the package.
     if nDigits > 0, this computes the partial sum through denominators
     of (nDigits) digits, that is, denominators that are < 10^nDigits,
     and then terminates without computing the complete sum.
     this parameter is used when the user calls iPartialSum[ ].
     threshold is used when the user calls iPartialSumThreshold[ ].

     called by iSum[ ], iPartialSum[ ], and iPartialSumThreshold[ ].

     this usually returns a single number: either the sum >= 0, or an error value < 0.
     however, if a threshold > 0 was specified as input, then a 2-element list
     { sum, digit number } is returned.
  *)
  {
    (* iPrint
         = 0 for no output except for the final result,
         = 1 for minimal output,
         = 2 for some extra output,
         = 3 for some output for each iteration of the loop,
         = 4 for more output during the loop.
    *)
    digitList, countList,
    iPrint,
    nShow = 10,    (* number of digits, for displaying during the loop *)
    nConditions,    (* number of digits with a condition placed on them *)
    directSumDigits,
    nDecimals, nDec,
    i, j, nMax, n, j1, k1,    (* index values in various loops *)
    iDigit, jPower, iDigitStart, k, numTerms, iAllTiny,
    (* given a digit distribution, the array index values tell
       where to store a sum in the sjk and sjkPrev arrays *)
    iArrayIndex, iArrayIndex0, iArrayIndex2, maxIndexUsed,
    maxJ,
    jMaxPower,
    maxIterations,  (* arbitrary upper limit on outer loop, to prevent infinite loop *)
    maxTermAddedI,    (* max term added for one iteration of the iDigit loop *)
    maxTermAddedJ,    (* max term added for one iteration of the jPower loop *)
    maxTermArray,
    iSpecialSum = 0, iDone = 0,
    tiny1, tiny2,
    (* sum = cumulative sum that we are looking for, with exactly n1 d1's, n2 d2's, etc. *)
    requestedSum = 0,
    (* sumOneDigit = requested sum for a single value of iDigit (that is, one power of 10) *)
    sumOneDigit = 0,
    (* sumSmallerK is the cumulative sum over all 0 <= k1 <= n1, 0 <= k2 <= n2, etc. *)
    sumSmallerK = 0,
    sumB1, sumB2, term1, term2, bnx2, ajn,
    kList, tableOfLists,
    occurStr,
    iTemp,
    bString = "",
    allCombos,  (* example: for iSum[{x, y}, {a, b}], allCombos = list of (1 + a)*(1 + b) sums *)
    comboTemp,  (* for printing *)
    time0, time1, time2
    , dsdIncr = 0  (* direct sum digit increment; for testing, set this to 1, 2, etc. *)
    (* , prevSumOneDigit = 0 *) (* for finding a particular increment, 2023 *)
    (* , pSumArray = {}, numSaved = 0 *)  (* for returning all partial sums for 1, 2, ... digits *)
  },

  (* if digits and counts are single numbers, this converts them to vectors of length 1 *)
  { digitList , countList } = checkDigitAndCountParams[digits, counts];
  If[ ! VectorQ[digitList],
    Return[0]
  ];

  (* check the validity of the input lists entered by the user *)
  If[checkInputLists[digitList, countList, iBase] == 0,
    Return[0]  (* invalid input *)
  ];

  iPrint = iSumPrintLevel;
  (* we use nDecimals because we cannot reset the input parameter nDecimals0 *)
  nDecimals = nDecimals0;
  If[nDecimals < 5, nDecimals = 5];
(*
  nDecimals = nDecimals + 2;
  nDec = nDecimals + 2;
*)
(* make nDec a little larger to allow for 4-digit sums like
   iSum[9, 0, -1, 1000] = 6802.410165253090787 *)
  nDec = nDecimals + 4;

  nShow = Min[20, nDec];

  If[iPrint >= 2,
    Print["iBase = ", iBase, ", digitList = ", digitList, ", countList = ", countList];
  ];

  (* check the validity of the input lists entered by the user *)
(* moved to above
  If[checkInputLists[digitList, countList, iBase] == 0,
    Return[0]  (* invalid input *)
  ];
*)

  If[iBase != 10,  (* for printing, create a string like  " (base 2)"  *)
    bString = " (base " <> ToString[iBase] <> ")"
  ];

  (* at this point, we have not returned 0, so we can assume all input is valid *)
  time0 = TimeUsed[];

  (* proceed with the calculation *)
  nConditions = Length[digitList];
  tiny1 = 1/10^(2 * nDec) ;
  tiny2 = 1/10^(nDec + 5) ;


  (* the larger nDecimals is, the larger maxIterations and jMaxPower need to be.
     in most cases, maxIterations = 60 * nDecimals works.
     maxIterations is used only to make sure the outer loop is finite,
     so we can set it to any reasonable value.
     if nConditions = 1 and countList[[1]] = (say) 434, maxIterations must fairly large.
  *)
  (* this global value can be changed with setMaxIterations[n] *)
  maxIterations = iSumMaxIterations;
  If[iPrint >= 2, Print["maxIterations = ", maxIterations] ];


  (* directSumDigits is roughly the log of 1000 to base (iBase).
     for base 2, directSumDigits = 10; so, we do a direct sum to 2^10.
     for bases 2 - 9, directSumDigits > 3.
     for bases 10 - 31, directSumDigits = 3; in base 10, we do a direct sum to 1000.
     for bases 32 - 999, directSumDigits = 2.
     for bases > 999, directSumDigits = 1; this causes r0 to have a divide by 0 problem
     in computeMaxPowerNeeded[ ]. in this case, we reset directSumDigits = 2.
  *)
  directSumDigits = Ceiling[ Log[iBase, 1000] ];
  (* next line prevents divide by 0 when we compute r0 in computeMaxPowerNeeded[ ],
     for example, when iBase = 1000 *)
  If[directSumDigits < 2, directSumDigits = 2];  (* 2023 *)

(* march, 2023 *)
If[dsdIncr != 0,
  Print["testing: directSumDigits changed from ", directSumDigits, " to ", directSumDigits + dsdIncr];
  directSumDigits = directSumDigits + dsdIncr;
];  (* dsdIncr *)

  maxJ = computeMaxPowerNeeded[iBase, nDecimals, directSumDigits];
  If[maxJ < 0,
    maxJ = -maxJ;    (* change back to positive, then print it *)
    Print["Could not find good estimate for maxJ; computed maxJ = ", maxJ];
    Return[0];
  ];

  If[iPrint >= 2,
    Print["nDecimals = ", nDecimals, ", directSumDigits = ", directSumDigits,
          ", computed maxJ = ", maxJ];
  ];

  jMaxPower = maxJ;    (* this value depends on nDecimals and directSumDigits *)


(* if all digits 0 through iBase-1 are assigned a maximum number of occurrences,
   then the series is finite.  in this case, the number of digits in the
   largest possible denominator is the sum of the countList[[ ]] values.
   example: if we want one each of 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, then the
   (finite) series terminates after 10-digit denominators.
*)
  If[nConditions == iBase,
    iSpecialSum = Sum[countList[[i]], {i, nConditions}]
  ];

  maxTermArray = Table[ 0, { maxJ } ];

  (* sjk and sjkPrev are tables (arrays) of size maxJ by maxIndexUsed *)
  (* example: for iSum[{x, y}, {a, b}], maxIndexUsed = (1 + a)*(1 + b)
     = number of sums that must be computed for the "sum with at most..." output line
  *)
  maxIndexUsed = Product[1 + countList[[i]], {i, nConditions}];

  If[iPrint >= 3,
    Print["maxIndexUsed = ", maxIndexUsed];
  ];


  kList = Table[ 0, {nConditions + 1} ];
  tableOfLists = Table[ 0, { maxIndexUsed }, { nConditions + 1 } ];

allCombos = Table[ 0, { maxIndexUsed } ];  (* array with maxIndexUsed entries *)

  cumulativeSums1 = Table[ 0, { countList[[1]] + 1 } ];


  For[i = 1, i <= maxIndexUsed, i++,
    (* for each index value, compute the list and store it in tableOfLists. *)
    kList = getListFromArrayIndex[i, nConditions, countList];

(* Print["i = ", i, ", kList = ", kList]; *)
(* for iSum[{8, 9}, {1, 2}, 10], maxIndexUsed = (1 + 1)*(1 + 2) = 6;
   compute 6 sums of all combinations of at most one 8's and at most two 9's
i = 1, kList = {0,0}; iSum[{8, 9}, {0, 0}, 10] = 11.2915816168
i = 2, kList = {1,0}; iSum[{8, 9}, {1, 0}, 10] = 5.8240865454
i = 3, kList = {0,1}; iSum[{8, 9}, {0, 1}, 10] = 5.7263236348
i = 4, kList = {1,1}; iSum[{8, 9}, {1, 1}, 10] = 5.7567636864
i = 5, kList = {0,2}; iSum[{8, 9}, {0, 2}, 10] = 2.8543206271
i = 6, kList = {1,2}; iSum[{8, 9}, {1, 2}, 10] = 4.3052660799
*)

    (* debugging: check that the mapping and its inverse work properly *)
    iArrayIndex = getArrayIndexFromList[nConditions, countList, kList];
    If[iArrayIndex != i,
      Print["error: i = ", i, " != iArrayIndex = ", iArrayIndex];
      Return[0];
    ];

    For[j = 1, j <= nConditions, j++,
      tableOfLists[[i, j]] = kList[[j]]
    ];
  ];    (* end for i loop *)


  iArrayIndex0 = getArrayIndexFromList[nConditions, countList, countList];
  If[iArrayIndex0 != maxIndexUsed,
    Print["error: iArrayIndex0 != maxIndexUsed: iArrayIndex0 = ", iArrayIndex0, ",
          maxIndexUsed = ", maxIndexUsed];
    Return[0];
  ];


  (* initialize sjkPrev and sjk to be 2-dimensional arrays *)
  sjk = Table[ 0, { maxJ }, { maxIndexUsed } ];

  (* directly compute the sum for denominators having <= (directSumDigits) digits,
     that is, for denominators <= iBase^(directSumDigits) - 1.
  *)
  For[iDigit = 1, iDigit <= directSumDigits, iDigit++,
    (* set sjkPrev to an array of 0's *)
    sjkPrev = Table[ 0, { maxJ }, { maxIndexUsed } ];

    directSummation[iBase, iDigit, jMaxPower, nConditions, digitList, countList, nDec];

    (* requestedSum is the partial sum, so far, of the desired series *)
    (* requestedSum += sjkPrev[[ 1, iArrayIndex0 ]]; *)
(* prevSumOneDigit = sumOneDigit; *)  (* 2023 *)
    sumOneDigit = sjkPrev[[ 1, iArrayIndex0 ]];
    requestedSum += sumOneDigit;

    For[i = 1, i <= maxIndexUsed, i++,
allCombos[[i]] += sjkPrev[[ 1, i ]];
      sumSmallerK += sjkPrev[[ 1, i ]]
    ];    (* end For i loop *)

    If[ (nDigits > 0) && (nDigits == iDigit),
      iDone = 1
    ];

    If[ (threshold > 0) && (requestedSum > threshold),
      (* do the same thing in first and second loops *)
      Return[ { nf[requestedSum, nDecimals] , iDigit } ];
    ];

    If[iDone == 1,
      If[iPrint >= 1,
        Print["partial sum through ", iDigit, bString, " digits = ", requestedSum];
        If[ (nConditions != 1) || (countList[[1]] != 0),
          Print[" partial sum for all ", maxIndexUsed, " 'at most' conditions = ", sumSmallerK]
        ];
      ];    (* end if iPrint *)
      Break[];
    ];    (* end if iDone == 1 *)

    If[iPrint >= 3,
      Print[" partial sum for ", iDigit, bString, " digits = ", sjkPrev[[ 1, iArrayIndex0 ]] ];
      Print["   cumulative sum = ", requestedSum]
      (* no need for next print if nConditions = 1 and countList[[1]] = 0 *)
      If[ (nConditions != 1) || (countList[[1]] != 0),
        Print[" sum for all ", maxIndexUsed, " 'at most' conditions = ", sumSmallerK]
      ];
    ];  (* end if iPrint *)

    If[nConditions == 1, updateCumulativeSums1[iBase, nConditions, countList] ];

  ];    (* end For iDigit direct summation loop *)


  time1 = TimeUsed[];

  If[iDone == 1,
    Goto[endLoops]
  ];

  If[iPrint >= 2,
    Print["direct sum through ", directSumDigits, bString, " digits (that is, n < ",
          iBase^directSumDigits, ") = ", requestedSum] ;
    Print["iteration starting with denominators having ", directSumDigits+1, bString, " digits"]
  ];

  iDigitStart = directSumDigits + 1;


  (* here is the main loop.
     this computes sums over (iDigit)-digit numbers from sums over (iDigit - 1)-digit numbers. *)

  For[iDigit = iDigitStart, iDigit <= maxIterations, iDigit++,    (* outermost loop *)
    (* compute the sum of numbers in the set that have have (iDigit) digits,
      using the sums of reciprocals of powers over numbers having (iDigit-1) digits
    *)
    maxTermAddedI = 0;    (* largest term added for this value of iDigit *)

    maxTermArray = Table[ 0, { jMaxPower } ];  (* set maxTermArray to all 0's *)

    For[jPower = 1, jPower <= jMaxPower, jPower++,
      nMax = jMaxPower - jPower;

      maxTermAddedJ = 0;    (* largest term added for this value of jPower *)

      For[iArrayIndex = 1, iArrayIndex <= maxIndexUsed, iArrayIndex++,
        (* for this index value, set kList = corresponding n-tuple. *)
        kList = getListFromArrayIndex[iArrayIndex, nConditions, countList];

        sumB1 = sumB2 = 0;
        (* here is the "infinite" loop, where n goes from 0 to infinity *)
        For[n = 0, n <= nMax, n++,
          ajn =  Binomial[jPower + n - 1, n] / powerx[iBase, jPower + n];
          If[OddQ[n], ajn = -ajn];    (* this is now (-1)^n * ajn *)

          For[k = 1, k <= nConditions, k++,
            If[kList[[k]] > 0,
              (* this is for { 10 * S(i, k1, k2, ..., k(k)-1, ..., kn) + d(k) } *)
              kList[[k]] = kList[[k]] - 1;    (* decrement the kth index value *)
              iArrayIndex2 =  getArrayIndexFromList[nConditions, countList, kList];
(* when computing iSum[0, 1] = 23.026735341569127 (or iSum[0, 2]), we call powerx[0, 0]
   whenever digitList[[k]] = 0 and n = 0; powerx[0, 0] then returns 1.
   these do NOT call powerx[0, 0]: iSum[9, 0], iSum[9, 1], iSum[9, 2], iSum[0, 0].
   we use powerx to avoid warning about 0^0 being indeterminate,
   and because the first term in the negative binomial expansion is 1.
*)
              term1 = powerx[digitList[[k]], n] * ajn * sjkPrev[[ jPower + n, iArrayIndex2 ]];
              sumB1 = sumB1 + term1;
              maxTermAddedJ = Max[maxTermAddedJ, Abs[term1]];
              kList[[k]] = kList[[k]] + 1;    (* restore the kth index value *)
            ];    (* end if kList[k] *)
          ];    (* end For k loop *)

          (* this is for the final set in the above union
            { 10 * S(i, k1, k2, ..., kn) + d. where d is none of d1, d2, ..., dn }
          *)

          bnx2 = bn[iBase, n, nConditions, digitList];
          term2 = bnx2 * ajn * sjkPrev[[ jPower + n, iArrayIndex ]];
          maxTermAddedJ = Max[maxTermAddedJ, Abs[term2]];
          sumB2 = sumB2 + term2;

        ];    (* end For n loop *)

        sjk[[jPower, iArrayIndex]] = sumB1 + sumB2;
      ];    (* end For iArrayIndex loop *)

      maxTermArray[[jPower]] = maxTermAddedJ;
      maxTermAddedI = Max[maxTermAddedI, maxTermAddedJ];

    ];    (* end For jPower loop *)

(* prevSumOneDigit = sumOneDigit; *)  (* 2023 *)
    sumOneDigit = sjk[[1, iArrayIndex0 ]];    (* sum for this many digits *)
    requestedSum += sumOneDigit;

    If[ (threshold > 0) && (requestedSum > threshold),
      (* do the same thing in first and second loops *)
      Return[ { nf[requestedSum, nDecimals] , iDigit } ];
    ];

    For[i = 1, i <= maxIndexUsed, i++,
allCombos[[i]] += sjk[[ 1, i ]];
      sumSmallerK += sjk[[1, i]]    (* update the sum for all 'at most' conditions *)
    ];

    If[ (nDigits > 0) && (nDigits == iDigit),    (* request is to compute partial sums *)
      iDone = 1;
      If[iPrint >= 1,
        Print["partial sum through ", iDigit, bString, " digits = ", nf[requestedSum, nDecimals]];
        If[ (nConditions != 1) || (countList[[1]] != 0),
          Print[" partial sum for all ", maxIndexUsed, " 'at most' conditions = ", nf[sumSmallerK, nDecimals]]
        ];
      ];    (* If[iPrint >= 1] *)
      Break[];
    ];

    sjkPrev = sjk;    (* this copies the entire array *)

    If[nConditions == 1, updateCumulativeSums1[iBase, nConditions, countList] ];

    If[iPrint >= 4,
      Print[" partial sum for ", iDigit, bString, " digits = ", N[sumOneDigit, nShow],
            ", cumulative sum = ", N[requestedSum, nShow] ];
      (* no need for next line if nConditions = 1 and countList[[1]] = 0 *)
      If[ (nConditions != 1) || (countList[[1]] != 0),
        Print[" sum for all ", maxIndexUsed, " 'at most' conditions = ", N[sumSmallerK, nShow] ]
      ];
    ];  (* end if iPrint *)


    If[ (iSpecialSum > 0) && (iDigit > iSpecialSum),
      iDone = 1;
      Print["this is a finite series that terminates after ", iSpecialSum, bString, " digits"]
    ];

    (* if all terms for a given jPower were very small, then we can decrease jMaxPower *)
    If[jMaxPower > 2,
      j1 = jMaxPower;
      For[jPower = jMaxPower, jPower >= 2, jPower--,
        If[maxTermArray[[jPower]] < tiny1,
          j1 = jPower
         ,
          Break[]
        ];
      ];    (* end for jPower loop *)
      If[jMaxPower != j1,
        If[iPrint >= 4,
          Print["iDigit = ", iDigit, ": changing jMaxPower from ", jMaxPower, " to ", j1]
        ];
        jMaxPower = j1;
      ];
    ];    (* end if jMaxPower > 2 *)

    If[nDigits > 0,
      Continue[];    (* if calculating partial sums only, skip checks for convergence *)
    ];

    (* if all sjk values are sufficiently tiny, then we are done *)
    iAllTiny = 1;
    For[k1 = 0, k1 <= maxIndexUsed, k1++,
      If[sjk[[2, k1 ]] > tiny2,
        iAllTiny = 0;    (* not all are tiny *)
        Break[];
      ]
    ];

  If[ (iPrint >= 2) && (iDigit == iDigitStart),
    Print["sum through denominators having ", iDigitStart, bString, " digits (that is, n < ",
          iBase^iDigitStart, ") = ", requestedSum] ;
  ];

    If[ (iAllTiny == 1) && (sjk[[1, iArrayIndex0 ]] < tiny2),
      If[ (sjk[[1, iArrayIndex0 ]] != 0) && (sjk[[1, iArrayIndex0 ]] / requestedSum < tiny2),
        iDone = 1;
        time2 = Round[TimeUsed[] - time0];
        If[iPrint >= 2,
          Print["last iteration of main loop:"];
       (* Print[" max term added = ", maxTermAddedI, ", sum for ", iDigit, bString,
                " digits = ", nf[sumOneDigit, nShow]]; *)
          Print[" sum for denominators having ", iDigit, bString, " digits = ", nf[sumOneDigit, nShow]];
          Print["iteration done after including denominators with ", iDigit, bString,
                " digits (", time2, " seconds)."]
        ];  (* end if iPrint >= 2 *)
      ];    (* end If sjk ... *)
    ];    (* end If iAllTiny ... *)

    If[ (iDigit == maxIterations) && (iDone == 0),
      Print["last iteration (", maxIterations, ") of main loop, but no convergence yet."];
      iTemp = maxIterations * 2;
      Print[" use setMaxIterations[n] to make 'maxIterations' larger (perhaps ", iTemp, "),"];
      Print[" and start this calculation again."]
      Print["  partial sum just for ", iDigit, "-digit denominators = ", N[sjk[[1, iArrayIndex0 ]], nShow] ];
      requestedSum = 0;
      Break[]
    ];

    If[ (iDone == 1) && (iPrint > 0),
      Print["sum = ", nf[requestedSum, nDecimals, iFormatted] ];
        If[ (nConditions == 1) && (countList[[1]] != 0),
          printSumsWithKOccurrences[nDecimals, nConditions, digitList, countList, iFormatted];
          If[countList[[1]] == 1, occurStr = "occurrence ", occurStr = "occurrences"];
          Print[" sum with at most ", maxIndexUsed - 1, " ",
                occurStr, " of ", digitList[[1]], " = ",
                nf[sumSmallerK, nDecimals, iFormatted] ];
        ];
        If[nConditions > 1,
          printAtMostSumNCond[nConditions, digitList, countList,
                              sumSmallerK, nDecimals, iFormatted];
        ];
      (* Break[] *)  (* move this to below. regardless of iPrint, we should break if iDone = 1 *)
    ];  (* end if (iDone == 1) && (iPrint > 0) *)

    (* if we are done, break out of the iDigit loop *)
    If[iDone == 1,
      Break[]
    ];

  ];    (* end For iDigit loop *)

Label[endLoops];

  If[ (iSumPrintLevel > 1) && (maxIndexUsed > 1),  (* 2023 *)
(* if the calculation was iSum[{8, 9}, {1, 1}, 10], this line was just printed:
   sum with at most 1 8 and at most 1 9 = 28.5987554834
 in this case, the For[i...] loop below will print the following 5 lines:
   iSum[{8,9}, {0,0}] = 11.2915816168
   iSum[{8,9}, {1,0}] = 5.8240865454
   iSum[{8,9}, {0,1}] = 5.7263236348
   iSum[{8,9}, {1,1}] = 5.7567636864
    total of these 4 sums = 28.5987554834
*)
    For[i = 1, i <= maxIndexUsed, i++,
      kList = getListFromArrayIndex[i, nConditions, countList];
      comboTemp = nf[allCombos[[i]], nDecimals, iFormatted];
      Print[" iSum[", digitList, ", ", kList, "] = ", comboTemp];
    ];  (* end for i loop *)
    comboTemp = nf[Apply[Plus, allCombos], nDecimals, iFormatted];
    Print["  total of these ", maxIndexUsed, " sums = ", comboTemp];
  ];  (* end (iSumPrintLevel > 1) && (maxIndexUsed > 1) *)

  (* return the value of the requested sum *)
  nf[requestedSum, nDecimals, iFormatted]

];    (* end of private function computeIrwinSum *)



(* here are the functions that the user can call:
    iSum, iSumFormatted, iPartialSum, iPartialSumThreshold, iPartialSumCheck,
    setPrintLevel, getPrintLevel, setMaxIterations, getMaxIterations,
    setDefaultDecimals, getDefaultDecimals
*)


iSum[digits_, counts_, nDecimals_Integer:-1, iBase_Integer:10, iFormatted_Integer:0] :=
Module[
(*
parameter 1 is either a single digit, or a list of digits (in base iBase).
parameter 2 is either a count, or a list of counts (one count for each digit in parameter 1).
parameter 3 is the number of decimal places. if -1, or if omitted, use nDefaultDecimals.
parameter 4 is the base. if omitted, base 10 is assumed.
parameter 5 is used only by iSumFormatted[ ].
*)
  (* examples: sums of 1/n where n has exactly:
     iSum[ 9, 3 ]              three 9's; = 23.025852998372444
     iSum[ { 9 }, { 3 } ]      three 9's; = 23.025852998372444
     iSum[ 9, 3, 25 ]          three 9's, to 25 decimals; = 23.0258529983724443171429038
     iSum[{9, 0}, {1, 1}]      one 9 and one 0; = 5.757259706518391
     iSum[{9, 8}, {2, 0} ]     two 9's and no 8's; = 2.854320627073917
     iSum[{9, 8}, {2, 0}, 25 ]  two 9's and no 8's, 25 decimals; = 2.8543206270739167581722731
     iSum[ 0, 1, -1, 2 ]       one 0 in base 2 (-1: use default decimals); = 1.462590735044365
     iSum[ 0, 1, 25, 2 ]       one 0 in base 2 to 25 decimals; = 1.4625907350443646995461454
     iSum[{0, 2}, {1, 1}, -1, 3]  one 0, one 2 in base 3, default decimals; = 0.868751694857522
     iSum[15, 1, -1, 16]       one 15 in base 16; = 44.368334748702945
  *)
  { nDec = nDecimals },
  If[nDec == -1, nDec = nDefaultDecimals];  (* if nDecimals = -1, use default *)

  computeIrwinSum[iBase, digits, counts, nDec, iFormatted]

];    (* end of iSum[digit(s), count(s), decimals, base] *)


iSumFormatted[digits_, counts_, nDecimals_Integer:-1, iBase_Integer:10] :=
Module[
(* parameters 1 - 4 are the same as in iSum[ ]
   example: iSumFormatted[ 9, 3 ] gives the formatted result of iSum[ 9, 3 ]
*)
  { iFormatted = 1 },
  iSum[digits, counts, nDecimals, iBase, iFormatted]
];    (* end of iSumFormatted[ ] *)


iPartialSum[digits_, counts_, numDigits_Integer?Positive,
            nDecimals_Integer:-1, iBase_Integer:10] :=
Module[
(*
parameter 1 is either a single digit, or a list of digits (in base iBase).
parameter 2 is either a count, or a list of counts (one count for each digit in parameter 1).
parameter 3 specifies the power of 10 (or iBase) to terminate the partial sum.
parameter 4 is the number of decimal places. if -1, or if omitted, use nDefaultDecimals.
parameter 5 is the base. if omitted, base 10 is assumed.
*)
  (* examples:
       iPartialSum[ 9, 0, 30 ] = sum to 10^30 where n has no 9's
       iPartialSum[ { 9, 0 }, { 3, 1 }, 20 ] = sum to 10^20 where n has three 9's and one 0
       iPartialSum[ { 9, 0 }, { 3, 1 }, 20, 25 ] above sum to 25 decimals
       iPartialSum[15, 1, 5, -1, 16] = sum over n < 16^5, where n has one 16 in base 16
       you can also use lists of length 1, if you prefer:
         iPartialSum[ {9}, {0}, 30 ] is the same as iPartialSum[ 9, 0, 30 ]
  *)
  { nDec = nDecimals, iFormatted = 0 },
  If[nDec == -1, nDec = nDefaultDecimals];  (* if nDecimals = -1, use default *)

  computeIrwinSum[iBase, digits, counts, nDec, iFormatted, numDigits]

];    (* end of iPartialSum[digits, counts, numDigits, decimals, base] *)


iPartialSumThreshold[digits_, counts_, threshold_?Positive,
                     nDecimals_Integer:-1, iBase_Integer:10] :=
Module[
(*
parameter 1 is either a single digit, or a list of digits (in base iBase).
parameter 2 is either a count, or a list of counts (one count for each digit in parameter 1).
parameter 3 is the threshold, as a numeric value.
parameter 4 is the number of decimal places. if -1, or if omitted, use nDefaultDecimals.
parameter 5 is the base. if omitted, base 10 is assumed.
*)

(* given a numeric threshold t, this computes the smallest k such that
   the sum of 1/n for n < 10^k, is greater than t (assuming the base is 10).
   iPartialSumThreshold returns four numbers: {k, sum1, k+1, sum2},
   where sum1 is the sum for n < 10^k, and sum2 is the sum for n < 10^(k+1).
   examples:
   1. iSum[9, 0] = 22.920676619264150.
   at what point does the partial sum reach 22?
   iPartialSumThreshold[9, 0, 22] = {30, 21.971055078178619, 31, 22.066017232287173}
   this means that:
   the sum over n < 10^30 is about 21.971; the sum over n < 10^31 is about 22.066.

   2. example with two conditions on n: the sum of 1/n where n has three 9's and one 0, is
   iSum[{9, 0}, {3, 1}] = 2.888545932755274 . therefore, the threshold must be less than this
   value. in this example, the threshold is 2:
   iPartialSumThreshold[{ 9, 0 }, { 3, 1 }, 2] = {27, 1.910422503190251, 28, 2.0043388417551473}
   so, the sum over n < 10^27 is about 1.910; the sum over n < 10^28 is about 2.004.

   3. if your threshold is too close to the sum of the entire series, this function returns
   the error values {-1, -1, -1, -1}.
   if this happens, you should either
     (a) increase the accuracy of the threshold by using mathematica's double backquote
         notation or by appending a few trailing 0's,
   or
     (b) make the threshold a little smaller (for example, remove tje trailing non-zero digit).
   example:
   iSum[9, 1] = 23.044287080747848
   this fails brcause this threshold (23.044287080747) is too close to the actual sum:
     iPartialSumThreshold[9, 1, 23.044287080747]
   however, by using mathematica's double backquote notation to increase
   the accuracy of the threshold, you get the correct result:
     iPartialSumThreshold[9, 1, 23.044287080747``20]
   or, you can append trailing 0's:
       iPartialSumThreshold[9, 1, 23.04428708074700000000]
   (these methods increased the accuracy of the threshold from about 15 to 20.)
   the returned values are
     {327, 23.044287080746936363446, 328, 23.044287080747025118024}.
   you can also lower the threshold slighly, from 23.044287080747 to 23.04428708074:
     iPartialSumThreshold[9, 1, 23.04428708074] returns
     {305, 23.044287080739194, 306, 23.044287080740034}
   (this threshold is a little smaller, so these returned values are different.)
  
   4. here, the sum is over n having one digit with the value 15, in base 16.
   iPartialSumThreshold[15, 1, 2, -1, 16] = {5, 1.698821554097735, 6, 2.3851449040460524}.
   so, the sum for n < 16^5 is about 1.69882, and the sum over n < 16^6 is about 2.38514.

   let {k, s1, k+1, s2} = iPartialSumThreshold[digits, counts, t].
   in almost all cases, we will have s1 < t < s2.
   here is what can happen when threshold t = exact sum of a series for n < 10^k:
   either s1 or s2 could equal t. that is, we know that s1 <= t <= s2,
   but we cannot say which of s1 or s2 equals t.
   example 1: t = Sum[1/n, {n, 1, 8}] = 761/280 = approx 2.71785714285714
     iPartialSumThreshold[9, 0, 761/280] = {1, 2.717857142857143, 2, 4.7718487650820612}
     in this example, s1 = sum to 10^k = t
   example 2:iPartialSumThreshold[9, 2, 1/99] = {1, 0, 2, 0.0101010101010101}
     in this example, s2 = sum to 10^(k+1) = t
*)
(*
warning: you can encounter problems here if you display numbers to fewer than 15 digits.
suppose your mathematica setting
  Edit/Preferences/Appearance/Numbers/Displayed precision
is set to display machine-precision numbers to only 12 digits.

1. if you call
  iPartialSumThreshold[9, 0, 22.92067661926414]
you get a warning:
"Error: your threshold (22.9206766193) is too close to the sum of the entire series
(22.920676619264150). Threshold needs more accuracy. Suggestion: use 22.9206766193``20".

2. this message is misleading, because this last value is larger than the full sum of the series.
  iPartialSumThreshold[9, 0, 22.9206766193``20]
"Error: your threshold (22.9206766193000000000) is greater than the sum of the entire series
(22.92067661926415034816). Suggestion: remove trailing non-zero digits from threshold
to make it smaller."

the root of the problem is that your original threshold
22.9206766192641 has been rounded (up), and is printed as
22.9206766193. this is greater than the sum of the series, which is
22.920676619264150.

3. if you change the setting to display 15 digits, then (in this case)
this function works as expected:
  iPartialSumThreshold[9, 0, 22.92067661926414]
"Error: your threshold (22.9206766192641) is too close to the sum of the entire series
(22.920676619264150). Threshold needs more accuracy. Suggestion: use 22.9206766192641``20" .
this does return the correct values:
  iPartialSumThreshold[9, 1, 22.9206766192641``20]
returns {69, 22.908719070593782675332, 70, 22.920716288849472578437}
however: note that, even when displaying 15 digits, we can still lose a digit:
the input 22.92067661926414 (16 digits) gets rounded to 22.9206766192641 (15 digits).
ultimately, there is no way to program around this problem. if you enter more digits
than you have chosen to display, then the above message will always throw digits away.
*)
  { digitList , countList, nDec = nDecimals,
    iFormatted = 0, nDigits = 0, totalSum, iPrintLevelSave,
    xSum1 = 0, nDig1 = 0, xSum2, nDig2, nDec2,
    tAcc, tAccIncr = 5,
    errorReturn = {-1, -1, -1, -1}
  },
  If[nDec == -1, nDec = nDefaultDecimals];  (* if nDecimals = -1, use default *)

  If[iBase < 2 ,
    Print["error: base = ", iBase, " is not valid."];
    Return[ errorReturn ]
  ];

  { digitList , countList } = checkDigitAndCountParams[digits, counts];
  If[ ! VectorQ[digitList],
    Return[ errorReturn ]
  ];

  tAcc = 1 + Floor[Accuracy[threshold]];
  If[tAcc == Infinity,
    nDec2 = nDec,
    nDec2 = Max[nDec, tAcc]
  ];

  iPrintLevelSave = iSumPrintLevel;
  iSumPrintLevel = -1;    (* suppress all printed output except error messages *)
  totalSum = iSum[digitList, countList, nDec2, iBase];
  If[threshold > totalSum,
    Print["Error: your threshold (", threshold,
          ") is greater than the sum of the entire series (", totalSum, ").",
          " Suggestion: remove trailing non-zero digits from threshold to make it smaller."];
    iSumPrintLevel = iPrintLevelSave;
    Return[ errorReturn ]    (* error *)
  ];
  If[threshold == totalSum,
    If[tAcc == Infinity,  (* this can happen, for example, if threshold = (exactly) 10 Log[10] *)
      tAcc = 1 + Floor[Accuracy[totalSum]];  (* use this instead; increase this by tAccIncr *)
      Print["Error: your threshold (", threshold, ")",
            " is too close to the sum of the entire series (", totalSum, ").",
            " Threshold needs more accuracy. Suggestion: use N[threshold, ", tAcc + tAccIncr, "]"];
    ,
      Print["Error: your threshold (", threshold, ")",
            " is too close to the sum of the entire series (", totalSum, ").",
            " Threshold needs more accuracy. Suggestion: use ", threshold,"``", tAcc + tAccIncr];
    ];  (* end if tAcc == Infinity *)
    iSumPrintLevel = iPrintLevelSave;
    Return[ errorReturn ]    (* error *)
  ];  (* end if threshold == totalSum *)

  { xSum2 , nDig2 } = computeIrwinSum[iBase, digitList, countList, nDec2,
                                      iFormatted, nDigits, threshold];

  If[nDig2 > 1,
    nDig1 = nDig2 - 1;
    xSum1 = iPartialSum[digitList, countList, nDig1, nDec2, iBase];
  ];

  If[ (nDig1 == 1) && (xSum1 == threshold),
    iSumPrintLevel = iPrintLevelSave;
    Return[  { nDig1, xSum1, nDig2, xSum2 } ]
  ];

  If[ (xSum1 >= threshold) && (nDig2 > 1),
    (* xSum1 should be less than the threshold.
       if it is not, decrease the number of digits by 1 *)
    nDig2 = nDig1;
    xSum2 = xSum1;
    nDig1 = nDig2 - 1;
    xSum1 = iPartialSum[digitList, countList, nDig1, nDec2, iBase];
  ];

  iSumPrintLevel = iPrintLevelSave;

  (* if the computed xSum1 and xSum2 are correct, then
     xSum1 < threshold and xSum2 >= threshold. *)

  If[ (xSum1 >= threshold) || (xSum2 < threshold),
  (* explain how to increase the accuracy by (tAccIncr) digits *)
    Print["Threshold is not specified to enough accuracy. You can use backquotes ",
          threshold, "``", tAcc + tAccIncr, " to increase the accuracy."];
    Return[ errorReturn ]    (* error *)
  ];

(* note: kPartialSumThreshold[ ] in kempnerSums.m returns the numbers in a different order:
   { nDig1, nDig2, xSum1, xSum2 }
*)
  { nDig1, xSum1, nDig2, xSum2 }

];    (* end of iPartialSumThreshold[digits, counts, threshold (numeric), decimals, base] *)


iPartialSumCheck[digits_, counts_, numDigits_Integer?Positive,
                 nDecimals_Integer:-1, iBase_Integer:10, iPrint_Integer:0] :=
Module[
(*
parameter 1 is either a single digit, or a list of digits (in base iBase).
parameter 2 is either a count, or a list of counts (one count for each digit in parameter 1).
parameter 3 is the number of digits (in base iBase): compute n up to iBase^numDigits.
parameter 4 is the number of decimal places. if -1, or if omitted, use nDefaultDecimals.
parameter 5 is the base. if omitted, base 10 is assumed.
parameter 6: if this is 1, then print the first few values of n.

iPartialSumCheck[9, 0, 5]: no 9 in base 10, partial sum for n < 10^5.
iPartialSumCheck[{8, 9}, {1, 1}, 6]: one 8, one 9, for n < 10^6.
iPartialSumCheck[9, 0, 5, -1, 10]: no 9 in base 10, partial sum for n < 10^5.
iPartialSumCheck[15, 1, 5, -1, 16]: one 15 in base 16; partial sum for n < 16^5.
iPartialSumCheck[15, 1, 5, -1, 16, 1]: same, but print out list of all n < 16^2.
*)
(* this performs a double-check on the iPartialSum[ ] function.
   this uses DigitCount[n] to get the values of n that meet the specified conditions
   on the digits, then simply sums 1/n for these n that are < 10^numDigits.
   this result should be very close to iPartialSum[digitList, countList, numDigits].
   this does not use the extrapolation procedure used by iSum[ ] or iPartialSum[ ].

   enter with digitList = list of digits, and countList = list of counts:
   for example, iPartialSumCheck[ {3, 4}, {1, 0}, 5 ] means n has one 3, and 0 4's.
   we display the number of terms.
   return totalSum, which should match iPartialSum[digitList, countList, numDigits].
   (if base = 10 and numDigits >= 6, iPartialSumCheck[ ] may take over 30 seconds.)
   iPartialSum[{9}, {1}, 6]      = 2.894055045366066;
   iPartialSumCheck[{9}, {1}, 6] = 2.89405504536607.
   one 3, no 4:
   iPartialSum[ {3, 4}, {1, 0}, 6 ] =      2.678293381896710;
   iPartialSumCheck[ {3, 4}, {1, 0}, 6 ] = 2.67829338189671.
   this: Table[iPartialSum[ {3, 4}, {1, 0}, k ], {k, 1, 6}] computes 6 partial sums
   to 10^k, where k = 1..6. iPartialSumCheck[ {3, 4}, {1, 0}, 6 ] prints these 6 values.
   if the 6th parameter (iPrint) is 1, this prints all values of n up to iBase^3
   that were included in the sum.
*)
  { digitList , countList, nDec = nDecimals,
    listLength, totalTerms, totalSum, iExpo, nStart, nEnd,
    terms1, sum1, n, numDigitsInN, goodN, i, iDigit, iLoc, iExpoMax, maxNToSave,
    nArray = { }, listLimit = 1000,
    baseString = ""
  },
  If[nDec == -1, nDec = nDefaultDecimals];  (* if nDecimals = -1, use default *)

  If[iBase < 2,
    Print["base = ", iBase, " is not valid"];
    Return[ 0 ] 
  ];

  { digitList , countList } = checkDigitAndCountParams[digits, counts];
  If[ ! VectorQ[digitList],
    Return[ 0 ]
  ];

  If[checkInputLists[digitList, countList, iBase] == 0,
    Return[ 0 ]  (* first two vectors are invalid *)
  ];

  listLength = Length[digitList];

  If[iSumPrintLevel > 0,
    Print["Digits = ", digitList, ", counts = ", countList, ", base = ", iBase];
    If[iBase^numDigits >= 10^7,
      Print["Warning: this calculation will obtain the digits of all n < base^numDigits = ",
            iBase^numDigits];
    ];
  ];

  (* for base 10, store list of n's < listLimit (= 1000); for base 2, store n's < 2^9, etc. *)
  iExpoMax = Floor[ Log[iBase,listLimit] ];
  iExpoMax = Min[iExpoMax, numDigits];
  maxNToSave = iBase^iExpoMax;

  totalTerms = 0;
  totalSum = 0;
  For[iExpo = 1, iExpo <= numDigits, iExpo++,
    nStart = iBase^(iExpo - 1);
    nEnd = iBase^iExpo - 1;
    terms1 = 0;  (* count of n where n has this many (iExpo) digits *)
    sum1 = 0;  (* sum of 1/n where n has (iExpo) digits *)
    For[n = nStart, n<= nEnd, n++,
      (* for this n, count the number of occurrences of this digit *)
      (* numDigitsInN is the list of digits; order = 1, 2, ..., 9, 0 *)
      numDigitsInN = DigitCount[n, iBase];
      goodN = 1;
      For[i = 1, i <= listLength, i++,
        (* for this input digit, see if the count equals countList[[i]] *)
        iDigit = digitList[[i]];
        If[iDigit != 0, iLoc = iDigit , iLoc = iBase];
        If[numDigitsInN[[ iLoc ]] != countList[[i]] , goodN = 0];
      ];  (* end for i loop *)
      If[goodN == 1,
        (* get here if n has the desired counts of all specified digits *)
        terms1++;
        sum1 += N[1/n, nDec];
        If[(iPrint == 1) && (n < maxNToSave),
          (* save every small n that meets all conditions *)
          AppendTo[nArray, n];
        ];
       ];  (* end if goodN == 1 *)
    ];  (* end for n loop *)
    totalTerms += terms1;
    totalSum += sum1;
    If[iSumPrintLevel > 0,
      If[iBase == 10,
        Print["n: ", nStart, " ... ", nEnd,
            ": terms: ", terms1, ", total terms: ", totalTerms,
            ", sum of 1/n: ", sum1, ", total sum: ", totalSum];
        , 
        (* here: for other bases, print base^power instead of just the number *)
        baseString = " (" <> ToString[iBase] <> "^" <> ToString[iExpo - 1] <> " ... " <>
                     ToString[iBase] <> "^" <> ToString[iExpo] <> " - 1)" ;
        Print["n: ", nStart, " ... ", nEnd, baseString,
            ": terms: ", terms1, ", total terms: ", totalTerms,
            ", sum of 1/n: ", sum1, ", total sum: ", totalSum];
      ];  (* end if iBase == 10 *)
    ];  (* end if iSumPrintLevel > 0 *)
  ];  (* end for iExpo loop *)
    

If[ (iPrint == 1) && (Length[nArray] > 0),
  Print["the ", Length[nArray], " values of n < ", iBase, "^", iExpoMax, " in the sum are:"]
  Print[nArray];
];

  Return[totalSum];
];  (* end of iPartialSumCheck *)


End[ ]         (* end the private context *)


(* protect the exported symbols *)
Protect[iSum, iSumFormatted, iPartialSum, iPartialSumThreshold, iPartialSumCheck,
        setPrintLevel, getPrintLevel, setMaxIterations, getMaxIterations,
        setDefaultDecimals, getDefaultDecimals];


EndPackage[ ]  (* end the irwinSums package context *)