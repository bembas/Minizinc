
 nFl = 7; 
FLOOR = {a1,a2,a3,a4,a5,a6,a7};
buildWrks = [12,12,10,11,12,14,14];
buildDur = [12,5,10,5,5,10,5];
elecWrks = [10,5,7,3,3,2,1];
elecDur = [10,30,20,25,40,15,25];
plumbingWrks = [4,3,2,5,3,4,3];
plumbingDur = [8,11,18,14,14,13,9];
finishWrks = [3,4,4,6,5,4,4];
finishDur = [10,25,23,10,9,3,13];

int :nFl;
enum FLOOR;
array[FLOOR] of int :buildWrks; 
array[FLOOR] of int :buildDur;
array[FLOOR] of int :elecWrks;
array[FLOOR] of int :elecDur;
array[FLOOR] of int :plumbingWrks;
array[FLOOR] of int :plumbingDur ;
array[FLOOR] of int :finishWrks;
array[FLOOR] of int :finishDur; 
include "globals.mzn";

set of int:period=50..140;
array[FLOOR] of var period:startB;
array[FLOOR] of var period:endB;
array[FLOOR] of var period:startE;
array[FLOOR] of var period:endE;
array[FLOOR] of var period:startP;
array[FLOOR] of var period:endP;
array[FLOOR] of var period:startF;
array[FLOOR] of var period:endF;

var int:builders;
var int:electricians;
var int:plumbers;

constraint forall(f in FLOOR)(startB[f]+buildDur[f]=endB[f]);
constraint forall(f in FLOOR)(startP[f]+plumbingDur[f]=endP[f]);
constraint forall(f in FLOOR)(startE[f]+elecDur[f]=endE[f]);
constraint forall(f in FLOOR)(startF[f]+finishDur[f]=endF[f]);


constraint cumulative(startE,elecDur,elecWrks,electricians);
constraint cumulative(startP,plumbingDur,plumbingWrks,plumbers);
constraint cumulative(startF++startB,finishDur++buildDur,finishWrks++buildWrks,builders);



constraint forall(i,j in FLOOR where i<j)(startB[i]<startB[j]);
constraint forall(i in FLOOR)(endB[i]<=startE[i]);
constraint forall(i in FLOOR)(endB[i]<=startP[i]);
constraint forall(i in FLOOR)(endE[i]<=startF[i]); 
constraint forall(i in FLOOR)(endP[i]<=startF[i]);


var int:ergazomenoi=builders+electricians+plumbers;
  
solve minimize ergazomenoi;
 
output["startB=",show(startB),"\n"]++["startE=",show(startE),"\n"]++["startP=",(show(startP)),"\n"]++["startF=",show(startF),"\n"]++["builders=\(builders)\n"]++["electricians=\(electricians)\n"]++["plumbers=\(plumbers)"];