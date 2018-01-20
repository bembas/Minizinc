enum TASK = {A,B,C,D};
include "globals.mzn";
array[TASK] of int:cpuload=[60,30,50,40];
array[TASK] of int:duration=[2,1,2,5];
int : max_d = sum(duration);
set of int : TIME = 0..max_d;
var int: totalTime;
array[TASK] of var TIME: start;
array[TASK] of var TIME: end;

constraint forall(j in TASK)(start[j] + duration[j] = end[j]);
constraint cumulative(start,duration,cpuload,100);
constraint totalTime=max(end);


solve minimize totalTime;
output ["start ="]++[show(start)]++["\n"]
     ++["totalTime = \(totalTime)"];