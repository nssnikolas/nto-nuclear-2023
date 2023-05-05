REM save delta T in sec  
dT = 0.5 rem A[0].VALUE/1000  

Rem Q_in = UP_proc * Q_in_max 
Q_IN =  A[32].VALUE/100 * A[24].VALUE 
A[9].VALUE = Q_IN

Rem Q_vp = L/L_nom * Q_vp_nom
Q_VP = A[8].VALUE / A[17].VALUE * A[25].VALUE 
A[10].VALUE = Q_VP 

Rem Q_out = V_out * S_out 
Q_OUT = A[27].VALUE * A[28].VALUE 
if Q_OUT > 0.1 * A[25].VALUE THEN 
{  
  if A[8].VALUE < 0.25*A[17].VALUE THEN Q_OUT = 0.1 * A[25].VALUE 
} 
A[11].VALUE = Q_OUT 
   
Rem L = L + dT* (P_r * (Q_IN - Q_VP) - Q_OUT)/Sd
L = A[8].VALUE + dT*( A[22].VALUE * (Q_IN - Q_VP) - Q_OUT) / A[20].VALUE
if L < 0 THEN L = 0 
A[8].VALUE = L 
A[49].VALUE = A[8].VALUE 

REM Control:
Rem auto up  
CTRL_UP = A[33].VALUE + A[52].VALUE  
IF CTRL_UP > 100 THEN CTRL_UP = 100 
IF CTRL_UP < 0 THEN CTRL_UP = 0
IF A[4].value == 1 THEN A[32].VALUE = CTRL_UP
Rem auto down 
IF A[6].value == 1 THEN A[37].VALUE = A[38].VALUE
Rem close up 
IF A[3].value == 1 THEN A[32].VALUE = 0 
Rem close down  
IF A[5].value == 1 THEN A[37].VALUE = 0
 
REM Emergency situation maximum water  
IF A[8].VALUE > A[43].VALUE THEN   
{  
  A[3].VALUE = 1   
  A[45].VALUE = 1    
}   
ELSE   
{   
  A[45].VALUE = 0  
}  
 

REM Emergency situation maximum water  
IF A[8].VALUE < A[44].VALUE THEN  
{ 
  A[5].VALUE = 1  
  A[46].VALUE = 1   
}  
ELSE  
{  
  A[46].VALUE = 0 
} 
 
Rem RESET    
IF A[1].VALUE == 0 THEN    
  {    
    A[8].VALUE = 0  
    A[9].VALUE = 0  
    A[10].VALUE = 0  
    A[11].VALUE = 0    
    A[45].VALUE = 0    
    A[46].VALUE = 0 
  REM reset constants  
    REM Target values     
    A[17].VALUE = 1.7  
    A[18].VALUE = 70   
    REM Emergency situations  
    A[43].VALUE = 2.0  
    A[44].VALUE = 0.5 
    REM Model params    
    A[20].VALUE = 11.1765    
    A[21].VALUE = 0.18 
    A[22].VALUE = 1.0798   
    A[23].VALUE = 9.81 
    A[24].VALUE = 0.039 
    A[25].VALUE = 0.0000416667  
    REM Control UP    
    A[29].VALUE = 0.005  
    A[30].VALUE = 0.39
    A[31].VALUE = 0.2
    A[40].VALUE = 0.03  
    REM Control UP    
    A[34].VALUE = 0.025  
    A[35].VALUE = 0.2  
    A[36].VALUE = 0.5 
  }     
