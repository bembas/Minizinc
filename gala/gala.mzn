%%% Number of Guests N            
int :N;
set of int: GUESTS  = 1..N;
set of int: POSITIONS = 1..N;
%%% Gender Array
array[GUESTS] of 1..2 : gender;
%%% Hobbies Array
array[GUESTS] of set of int: hobbies;

%%% Enemies (Part B)
enum PAIR = {first,second};
int : pR;
set of int: LIST = 1..pR;
array[LIST,PAIR] of GUESTS : furious;
%%% Decision variables 
%%% Array that demonstrates which guest is at each position
array[POSITIONS] of var GUESTS : guest_at;

%%% The gender at each position. 
array[POSITIONS] of var 1..2: table_gender;
%%% Add your code here
include "globals.mzn";

% a erotima!
constraint forall(i in 1..N-1)(gender[guest_at[i]]!=gender[guest_at[i+1]]);
constraint forall(i in 1..N-1)(gender[table_gender[i]]!=gender[table_gender[i+1]]);
constraint alldifferent(guest_at);
constraint forall(i in 1..N-1)(card(hobbies[guest_at[i]] intersect hobbies[guest_at[i+1]])>=1);
constraint card(hobbies[guest_at[1]] intersect hobbies[guest_at[N]])>=1;
% b erotima!
constraint forall(p in 1..N-1)(forall(i in 1..pR-1 )(if guest_at[p]=furious[i,first]/\guest_at[p+1]=furious[i,second] then guest_at[p]!=guest_at[p+1] else true endif ))/\forall(p in 2..N-1)(forall(i in 1..pR-1)(if guest_at[p]=furious[i,first]/\guest_at[p-1]=furious[i,second] then guest_at[p]!=guest_at[p-1] else true endif ));
constraint forall(i in LIST, j in PAIR)(furious[i,j]!=guest_at[1]/\furious[i,j]!=guest_at[N]);


solve satisfy;
output 
       ["guest_at = \(guest_at);"]
       ++ ["\ntable_gender = \(table_gender); \n" ] 
       ++ ["Furious Placement\n"]
       ++ [show_int(4,furious[i,j]) | i in LIST, j in PAIR] ++["\n"] 
       ++ [if fix(guest_at[p]) = furious[i,j] then show_int(4,p) else "" endif | i in LIST, j in PAIR, p in POSITIONS]
       ;