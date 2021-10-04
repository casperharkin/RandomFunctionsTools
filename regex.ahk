		#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
		;#Warn  ; Enable warnings to assist with detecting common errors.
		SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
		SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
		
Person := {}

; 83191753 
;r = 
;(Join`r`n
;                                                                                
;  (1.2.1)                        PIPS Production                        EQ1001M1
;                                  Person Details                                
;                                                                                
;  AGS Number ........ 855 37340                                                 
;  Surname ........... CHEONG-WING            Display SN.                        
;  Given names ....... Matthew                                                   
;  Honorary titles ...                                                           
;  Courtesy title .... MR             Preferred name ..........                  
;  Gender ............ Male                                                      
;  Date of birth ..... 11 Sep 1974    Commenced in service .... 23 Jul 2018      
;  Pay centre ........ 494            Commenced department .... 23 Jul 2018      
;  Status ............ T              Date appointed ..........                  
;  Part time (Y/N) ... N              Probation extended to ...                  
;  Shift worker (Y/N). N              Appointment confirmed ...                  
;  Days per week ..... 5              Expected Sep. date ...... 30 Jun 2022      
;  Hours per week .... 36.45          Separation date .........                  
;  War service from ..                Department from .........                  
;                to ..                 or on loan from ........                  
;     PF5  Rec Leave Accrual          Leave category ..........                  
;     PF8  Surname/AGS         PF6  Next of Kin         PF7  Payslip data        
;  Display: ___                PF9  CRP data            PF10 Education Quals.    
;  Command: __________________ PF11 Com Trans/LSL Rate                           
;                                                                                
;)
;
;
;; 86410982 
;s = 
;(Join`r`n
;
;                                                                                
;                                 PIPS Production                        EQ1001M3
;                                  Person Details                                
;  Casual                                                                        
;  AGS number ................ 864 10982                                         
;  Surname ........... BARRY                  Display SN. BARRY                  
;  Given names ............... Shilo Maxine                                      
;  Preferred name ............ Shilo                                             
;  Courtesy title ............ MRS                                               
;  Honorary titles ...........                                                   
;                                                                                
;  Date of birth ............. 05 Sep 1988                                       
;  Commenced in Service ...... 04 Aug 2020                                       
;  Commenced in Department ... 04 Aug 2020                                       
;  Expected Separation Date... 30 Jun 2021    Separation date ... 30 Jun 2021    
;                                                                                
;  Gender .................... Female                                            
;  Pay centre ................ 497            PF5  Rec Leave Accrual             
;  Shift worker .............. Y              PF6  Next of Kin                   
;                                             PF7  Payslip information           
;  Department from ...........                PF8  Previous Surname/AGS details  
;                                             PF9  CRP data                      
;  Command: ____________________              PF11 Com Trans/LSL Rate            
;                                                                                
;)

RegexMatch(Clipboard, "names \.+ \K.+\b", var)
Person.Givennames := var

RegexMatch(Clipboard, "(?<=Surname ........... )(.{1,23})", var)
Person.Surname := var

RegexMatch(Clipboard, "(?<=Date of birth .....)(.{1,15})", var)
Person.Dateofbirth := var



for each, Item in Person
	MsgBox % Item