%%% Allign Problem
array[int] of int : list1 = [2,3,4,10,22,11,17]; 
array[int] of int : list2 = [1,2,3,4,10,22,11,11,10,24]; 
array[int] of int : list3 = [2,3,4,5,10,23,10,22,11,17];

include "globals.mzn";
set of int :lists=1..3;
array[lists] of var int:indices;
array[lists] of var int:values;

var int :sum;
constraint forall(i in lists)((list1[indices[1]+i-1])=(list2[indices[2]+i-1])/\(list2[indices[2]+i-1])=(list3[indices[3]+i-1]));
constraint sum= sum(i in lists)(list1[indices[1]+i-1]);
constraint values = [list1[indices[1]+i-1]|i in lists];

solve maximize sum;
output ["values = \(values)"]++["\nindices = \(indices)"]++["\nsum = \(sum)"];