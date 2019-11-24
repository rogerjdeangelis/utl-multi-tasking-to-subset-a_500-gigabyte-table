Multi-tasking to subset a 500 gigabyte table                                                                         
                                                                                                                     
github                                                                                                               
https://tinyurl.com/wlkzc4b                                                                                          
https://github.com/rogerjdeangelis/utl-multi-tasking-to-subset-a_500-gigabyte-table                                  
                                                                                                                     
I understand the meaning of very large dataset to be near 1tb, perhaps 500gb;                                        
I assume the subset is quite small 20gb?                                                                             
                                                                                                                     
I you partition the big dataset using SPDE or just spread it across different channels(drives)                       
that can speed things up.                                                                                            
If you have a couple of NVMe SSD arrays this can be even faster.                                                     
                                                                                                                     
sas forum                                                                                                            
https://tinyurl.com/rreg6ee                                                                                          
https://communities.sas.com/t5/SAS-Programming/How-to-subset-a-very-large-dataset-by-date/m-p/602297                 
                                                                                                                     
github multitasking                                                                                                  
https://tinyurl.com/y5a4x7p6                                                                                         
https://github.com/rogerjdeangelis?utf8=%E2%9C%93&tab=repositories&q=systask+in%3Areadme&type=&language=             
                                                                                                                     
I have some examples of moderate soze table ie ~200gb on my site.                                                    
                                                                                                                     
*_                   _                                                                                               
(_)_ __  _ __  _   _| |_                                                                                             
| | '_ \| '_ \| | | | __|                                                                                            
| | | | | |_) | |_| | |_                                                                                             
|_|_| |_| .__/ \__,_|\__|                                                                                            
        |_|                                                                                                          
;                                                                                                                    
                                                                                                                     
libname sd1 "d:/sd1";                                                                                                
data sd1.have;                                                                                                       
  input date $24. var ;                                                                                              
cards4;                                                                                                              
2018-04-03 03:44:18.728 8                                                                                            
2018-04-03 07:40:02.221 1                                                                                            
2018-04-03 09:20:20.135 5                                                                                            
2018-04-03 14:50:11.752 2                                                                                            
2018-04-03 02:42:17.005 5                                                                                            
2018-04-05 01:22:20.264 4                                                                                            
2018-04-05 04:45:49.402 2                                                                                            
2018-04-06 04:09:50.710 0                                                                                            
2018-04-07 04:12:31.623 3                                                                                            
2018-04-11 04:11:01.528 8                                                                                            
2018-04-03 03:44:18.728 8                                                                                            
2018-04-03 07:40:02.221 1                                                                                            
2018-04-03 09:20:20.135 5                                                                                            
2018-04-03 14:50:11.752 2                                                                                            
2018-04-03 02:42:17.005 5                                                                                            
;;;;                                                                                                                 
run;quit;                                                                                                            
                                                                                                                     
*            _               _                                                                                       
  ___  _   _| |_ _ __  _   _| |_                                                                                     
 / _ \| | | | __| '_ \| | | | __|                                                                                    
| (_) | |_| | |_| |_) | |_| | |_                                                                                     
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                    
                |_|                                                                                                  
;                                                                                                                    
                                                                                                                     
                                                                                                                     
 WORK.SUBSET total obs=10                                                                                            
                                                                                                                     
           DATE              VAR                                                                                     
                                                                                                                     
  2018-04-03 03:44:18.728     8                                                                                      
  2018-04-03 07:40:02.221     1                                                                                      
  2018-04-03 09:20:20.135     5                                                                                      
  2018-04-03 14:50:11.752     2                                                                                      
  2018-04-03 02:42:17.005     5                                                                                      
  2018-04-03 03:44:18.728     8                                                                                      
  2018-04-03 07:40:02.221     1                                                                                      
  2018-04-03 09:20:20.135     5                                                                                      
  2018-04-03 14:50:11.752     2                                                                                      
  2018-04-03 02:42:17.005     5                                                                                      
                                                                                                                     
*                                                                                                                    
 _ __  _ __ ___   ___ ___  ___ ___                                                                                   
| '_ \| '__/ _ \ / __/ _ \/ __/ __|                                                                                  
| |_) | | | (_) | (_|  __/\__ \__ \                                                                                  
| .__/|_|  \___/ \___\___||___/___/                                                                                  
|_|                                                                                                                  
;                                                                                                                    
                                                                                                                     
%let _s=%sysfunc(compbl(C:\Progra~1\SASHome\SASFoundation\9.4\sas.exe -sysin c:\nul                                  
  -sasautos c:\oto -work d:\wrk -rsasuser));                                                                         
                                                                                                                     
* this places the macro in my autocall library, c:/oto, so the batch command can find the macro;                     
* index on yyyy_qtr will speed this up;                                                                              
                                                                                                                     
filename ft15f001 "c:\oto\cutDat.sas";                                                                               
parmcards4;                                                                                                          
%macro cutDat(mthday,beg,end);                                                                                       
   libname sd1 "d:/sd1";                                                                                             
   data sd1.out_&mthday._&beg;                                                                                       
       set sd1.have(firstobs=&beg obs=&end where=(date=:'2018-04-03'));                                              
   run;quit;                                                                                                         
%mend cutDat;                                                                                                        
;;;;                                                                                                                 
run;quit;                                                                                                            
                                                                                                                     
%*cutDat(2018_4_3,1,2); * check interatively;                                                                        
                                                                                                                     
* set up;                                                                                                            
systask kill sys1 sys2 sys3 sys4  sys5 sys6 sys7 sys8;                                                               
                                                                                                                     
systask command "&_s -termstmt %nrstr(%cutDat(2018_4_3,1,2);) -log d:\log\a1.log" taskname=sys1;                     
systask command "&_s -termstmt %nrstr(%cutDat(2018_4_3,3,4);) -log d:\log\a2.log" taskname=sys2;                     
systask command "&_s -termstmt %nrstr(%cutDat(2018_4_3,5,6);) -log d:\log\a3.log" taskname=sys3;                     
systask command "&_s -termstmt %nrstr(%cutDat(2018_4_3,7,8);) -log d:\log\a4.log" taskname=sys4;                     
systask command "&_s -termstmt %nrstr(%cutDat(2018_4_3,9,10);) -log d:\log\a5.log" taskname=sys5;                    
systask command "&_s -termstmt %nrstr(%cutDat(2018_4_3,11,12);) -log d:\log\a6.log" taskname=sys6;                   
systask command "&_s -termstmt %nrstr(%cutDat(2018_4_3,13,14);) -log d:\log\a7.log" taskname=sys7;                   
systask command "&_s -termstmt %nrstr(%cutDat(2018_4_3,15,16);) -log d:\log\a8.log" taskname=sys8;                   
                                                                                                                     
waitfor sys1 sys2 sys3 sys4  sys5 sys6 sys7 sys8;                                                                    
                                                                                                                     
*SAMPLE LOG;                                                                                                         
                                                                                                                     
libname sd1 "d:/sd1";                                                                                                
data subset/view=subset; * do not materialize physical partitions can be usefull;                                    
    set                                                                                                              
      sd1.out_:;                                                                                                     
run;quit;                                                                                                            
                                                                                                                     
*    _      ___                __    _   _                                                                           
  __| |_   / / | ___   __ _   / /_ _/ | | | ___   __ _                                                               
 / _` (_) / /| |/ _ \ / _` | / / _` | | | |/ _ \ / _` |                                                              
| (_| |_ / / | | (_) | (_| |/ / (_| | |_| | (_) | (_| |                                                              
 \__,_(_)_/  |_|\___/ \__, /_/ \__,_|_(_)_|\___/ \__, |                                                              
                      |___/                      |___/                                                               
;                                                                                                                    
                                                                                                                     
NOTE: SAS initialization used:                                                                                       
      real time           0.57 seconds                                                                               
      cpu time            0.34 seconds                                                                               
                                                                                                                     
NOTE: Libref SD1 was successfully assigned as follows:                                                               
      Engine:        V9                                                                                              
      Physical Name: d:\sd1                                                                                          
                                                                                                                     
NOTE: There were 2 observations read from the data set SD1.HAVE.                                                     
      WHERE date=:'2018-04-03';                                                                                      
NOTE: The data set SD1.OUT_2018_4_3_1 has 2 observations and 2 variables.                                            
NOTE: DATA statement used (Total process time):                                                                      
      real time           0.07 seconds                                                                               
      cpu time            0.03 seconds                                                                               
                                                                                                                     
                                                                                                                     
                                                                                                                     
NOTE: SAS Institute Inc., SAS Campus Drive, Cary, NC USA 27513-2414                                                  
NOTE: The SAS System used:                                                                                           
      real time           0.68 seconds                                                                               
      cpu time            0.40 seconds                                                                               
                                                                                                                     
                                                                                                                     
