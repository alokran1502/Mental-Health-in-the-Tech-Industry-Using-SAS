/*
Import the provided CSV dataset into SAS using an appropriate library. Verify that the 
dataset has been imported successfully by displaying the first 20 observations.
*/

FILENAME REFFILE '/home/alokranjan1502/Deb/Projects/Mental Health in Tech Survey.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;

PROC PRINT DATA=WORK.IMPORT(OBS=20);
RUN;

