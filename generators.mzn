nDays = 15;
nGen = 5;
include "globals.mzn";
%% number of days
int : nDays;
set of int : PERIOD = 1..nDays;
%% number of generators
int : nGen;
set of int : GEN = 1..nGen;
% Power Production
array[GEN] of int : power25 = [20,25,15,30,40];
% Modes  
enum MODE = {L025,L050,L100,SHDN};


int: ns = 7;
set of int : STATE = 1..7;
array[STATE,MODE] of int :allowed=[|2,0,0,1|0,3,7,0|0,4,0,0|0,5,6,0|0,6,0,0|0,0,0,1|0,0,6,0|];
array[GEN,PERIOD] of var MODE:schedule;
array[GEN,PERIOD] of var int :power;

constraint forall(g in GEN)(regular(row(schedule,g),ns,card(MODE),allowed,1,STATE));


constraint forall(g in GEN,p in PERIOD)(if schedule[g,p]=L025 then power25[g]=power[g,p] elseif schedule[g,p]=L050 then power25[g]*2=power[g,p] elseif schedule[g,p]=L100 then power25[g]*4=power[g,p] elseif schedule[g,p]=SHDN then power[g,p]=0  else true endif) ;

array[PERIOD] of var int:production;
constraint forall(p in 2..nDays)(sum(col(power,p))<=200/\sum(col(power,p))>=150);
constraint forall(p in PERIOD)(production[p]=sum(col(power,p)));



solve satisfy;

output [show_int(5,d) | d in PERIOD ] ++ ["\n"] 
       ++ [" \(schedule[t,d])" ++ if (d==card(PERIOD)) then "\n" else "" endif | t in GEN, d in PERIOD]++["\n-Power Production ------------\n"]++["  \(sum(col(power,p)))"|p in PERIOD]++["\n\n -Data in Tables ------------\n"]++["schedule="++show(schedule)]++["\n\n"]++["production="++show(production)]
       
