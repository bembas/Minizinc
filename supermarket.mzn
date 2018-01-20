int: ofrs = 10;
set of int: OFFERS = 0..ofrs; 
set of int: PRODUCTS = 1..7;

set of int:BUYS = 1..4;
int : max_money = 100;

array[OFFERS] of set of int : package = array1d(OFFERS,[{},{1,2,3},{4,7},{3,6},{1,4,5},{3,4,7},{1,2,5},{4,6},{3,7},{3,7,5},{2,3}]);
array[OFFERS] of  int: package_price  =  array1d(OFFERS,[0,10,5,15,20,23,40,12,45,54,20]);
array[OFFERS] of int: package_quality = array1d(OFFERS,[0,5,2,3,2,3,1,4,5,6,5]);

var int :quality;
var int :price;
array[BUYS] of var OFFERS:index;
include "globals.mzn";



constraint forall (i,j in BUYS  where i<j)(disjoint(package[index[i]],package[index[j]]));

constraint price=sum(i in BUYS)(package_price[index[i]]);
constraint quality=sum(i in BUYS)(package_quality[index[i]]);
constraint price<=max_money;
constraint array_union([package[index[i]]|i in BUYS])=PRODUCTS;

solve maximize quality;
output["\(package[index[i]]) " | i in BUYS]++["\nprice = \(price)"] ++
["\nquality = \(quality)"];