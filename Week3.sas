/* Question 5  */
/* Create the following derived variables using SAS programming:  */
/* • Age_Group with the following categories:  */
/* o 18–25  */
/* o 26–35  */
/* o 36–45  */
/* o 46 years and above  */
/* • Treatment_Flag  */
/* o Yes = 1  */
/* o No = 0  */
/* • Remote_Work_Flag  */
/* o Yes = 1  */
/* o No = 0  */
/* • Family_History_Flag  */
/* o Yes = 1  */
/* o No = 0 */
 
data work.age_derived_data;
set work.above18_below70;
  /* Age_Group */
    if 18 <= Age <= 25 then Age_Group = "18-25";
    else if 26 <= Age <= 35 then Age_Group = "26-35";
    else if 36 <= Age <= 45 then Age_Group = "36-45";
    else if Age >= 46 then Age_Group = "46+";
    else Age_Group = "Unknown";
 
/* Treatment_Flag */
    if treatment = "Yes" then Treatment_Flag = 1;
    else if treatment = "No" then Treatment_Flag = 0;
    else Treatment_Flag = .;
/* Remote_Work_Flag */
    if remote_work = "Yes" then Remote_Work_Flag = 1;
    else if remote_work = "No" then Remote_Work_Flag = 0;
    else Remote_Work_Flag = .;
    /* Family_History_Flag */
    if family_history = "Yes" then Family_History_Flag = 1;
    else if family_history = "No" then Family_History_Flag = 0;
    else Family_History_Flag = .;
run;

/* 1. Proc format 
   2. Select method 
*/
 
proc contents data=work.age_derived_data varnum;
run;

/* Question 6  */
/* Generate frequency distributions for the following variables:  */
/* • Gender  */
/* • Country  */
/* • Treatment  */
/* • Family History  */
/* • Remote Work */
/*  */
/* Interpret any significant patterns observed.  */

proc freq data=work.age_derived_data order=Freq;
    tables Gender Country Treatment Family_History Remote_Work / missing;
    title "Frequency Distributions";
run;

/*Gender column values are not correct, it require data cleaning  */



/* Question 7  */
/* Identify the ten countries with the highest number of survey respondents. Present the  */
/* results in descending order.  */
 
proc contents data=work.age_derived_data;
run;
 
proc print data=work.age_derived_data;
run;
 
proc sql outobs=10;
    select Country, count(*) as Respondents
    from work.age_derived_data
    group by Country
    order by Respondents desc;
quit;



/* Question 8  */
/* Calculate the average age of respondents grouped by each of the following variables:  */
/* • Gender  */
/* • Country  */
/* • Treatment Status  */
/* • Remote Work Status  */

proc means data=work.age_derived_data mean n;
    class Country;
    var Age;
    title "Average Age by Country";
run;
 
proc means data=work.age_derived_data mean n;
    class Treatment;
    var Age;
    title "Average Age by Treatment Status";
run;
 
proc means data=work.age_derived_data mean n;
    class Remote_Work;
    var Age;
    title "Average Age by Remote Work Status";
run;


/* Proc Means Data = work.age_derived_data mean N; */
/* Var Age; */
/* Class Country Treatment Remote_work; */
/* Run; */




/* Question 9  */
/* Perform cross-tabulation analyses between the following variables:  */
/* • Treatment and Gender  */
/* • Treatment and Family History  */
/* • Treatment and Remote Work  */
/* • Treatment and Work Interference  */
/* Include row percentages, column percentages, and overall percentages wherever  */
/* appropriate.  */
/* Interpret the findings. */
 
proc freq data=work.age_derived_data;
    tables treatment*Gender
           treatment*family_history
           treatment*remote_work
           treatment*work_interfere / missing;
    title "Cross-Tabulation: Treatment vs. Key Variables";
run;

/* Conclusion: 1. Only 15% employees opt for treatment if they work remotely.   
               2. 28% employeess opt for treatment of they have family history. 

*/



