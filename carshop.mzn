int : nCars = 6;
set of int : CARS = 1..nCars;

array[CARS] of int: elecTime = [210,90,200,125,115,15];
array[CARS] of int: mechTime = [130,150,120,80,120,135];
array[CARS] of int: washTime = [20,10,10,10,20,20];

%%% Add your code here
array[CARS] of var 0..480: startE;
array[CARS] of var 0..480: endE;
array[CARS] of var 0..480: startM;
array[CARS] of var 0..480: endM;
array[CARS] of var 0..480: startW;
array[CARS] of var 0..480: endW;
var int :makespan;
int :H=3;
int :M=2;
int :P=2;
array[CARS] of int:resources=[1,1,1,1,1,1];


constraint forall(j in CARS)(startE[j] + elecTime[j] = endE[j]);
constraint forall(j in CARS)(startM[j] + mechTime[j] = endM[j]);
constraint forall(j in CARS)(startW[j] + washTime[j] = endW[j]);

constraint makespan=max(endW);

include "globals.mzn";
constraint cumulative(startE,elecTime,resources,H);
constraint cumulative(startM,mechTime,resources,M);
constraint cumulative(startW,washTime,resources,P);

constraint forall(j in CARS)(endE[j]<=startM[j]\/endM[j]<=startE[j]);
constraint forall(j in CARS)(endE[j]<=startW[j]/\endM[j]<=startW[j]);



solve minimize makespan;
output["makespan=\(makespan)\n"]++["startE=\(startE)\n"]++["startM=\(startM)\n"]++["startW=\(startW)"];
