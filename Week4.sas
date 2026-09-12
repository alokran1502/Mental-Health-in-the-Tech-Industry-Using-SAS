FILENAME REFFILE '/home/alokranjan1502/Deb/Projects/Mental Health in Tech Survey.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;

/* Determine whether there is a statistically significant association between Treatment Status  */
/* and each of the following variables by performing Chi-Square tests:  */
/* • Gender  */
/* • Family History  */
/* • Remote Work  */
/* • Benefits Provided  */
/* • Care Options Available  */

PROC FREQ DATA = work.import;
TABLES treatment*Gender/CHISQ ; 
RUN;

/* Chi-Square	df = 43	xsq = 86.6634	pvalue = <.0001 

H0: xsq = 0 : treatment and gender is not associated with each other
H1: xsq not = 0 : treatment and gender is associated.

as pvalue < 0.05, so we reject H0 and accept H1. this means association between treatment and gender
is statistically significant

*/

/*Similarly please perform chi-square for rest of the given variables.  */

/* Q11 */
/* Perform an Independent Samples t-test to determine whether the average age differs  */
/* significantly between employees who have sought treatment and those who have not.  */
/* Include the following in your answer:  */
/* • Null hypothesis  */
/* • Alternative hypothesis  */
/* • Test statistic  */
/* • p-value  */
/* • Final conclusion  */
/*  */

PROC TTEST DATA=work.import;
Class treatment;
VAR age;
where age not in (99999999999,329) ;
Run;


/*
H0: avg age  of patient who took treatment = avg age of patient who didn't took treatment
H1: avg age of patient who took treatment not= avg age of patient who didn't took treatment

Equality of Variances test
Method	  Num DF  Den   DF	    F Value	Pr > F
Folded F	634	  621	88.06	<.0001

H0: variance is equal
H1: variance is not equal

As pvalue(0.0001)<0.05 this means variance is not equal.
We consider ttest with unequal variance result.

TTest Result 
Method	      Variances	DF	   t Value	Pr > |t|
Pooled	        Equal	1255	0.57	0.5684
Satterthwaite	Unequal	648.7	0.58	0.5645

We select Satterthwaite method which is for unequal variable.
tvalue = 0.58 and pvalue = 0.5645

As pvalue(0.5645) > 0.05, so we accept H0. Avg Age of patient with treatment and with treatment is equal.

*/

proc means data=work.import;
var age ;
class treatment;
where age not in (99999999999,329) ;
run;

proc print data = work.import;
where age = 99999999999;
run;









