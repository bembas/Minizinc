%%% Vectors

int : vlen;
set of int : LEN  = 1..vlen;
set of int : VECS = 1..2;
array[VECS,LEN] of int : vector;

%%% Add your code here
include "globals.mzn";
var int:sumTotal;
array[LEN] of var int :indices;
array[LEN] of var int:vector1;
array[LEN] of var int:vector2;
constraint vector1=[vector[1,i]|i in LEN];
constraint vector2=[vector[2,i]|i in LEN];

constraint sumTotal=sum(i in LEN)(vector[1, i] * vector[2, indices[i]] * abs(i - indices[i]));
constraint all_different(indices);
solve minimize sumTotal;

output ["vector1=\(vector1)"]++["\nvector2=\(vector2)"]++["\nsumTotal=\(sumTotal)"]
