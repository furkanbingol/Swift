import UIKit

var nmbr = 1

//While
while(nmbr <= 10){
    print(nmbr)
    nmbr += 1
}

if(nmbr == 11){
    print("If' e girdi")
}


//For
var intArr = [3,1,0,-6,10,100,-40]

print("-----Dizi-----")
for i in intArr{
    print(i)
}

var sum = 0
for i in intArr{
    sum += i
}
print(sum)

for j in 1 ... 10 {
    print(j * 10)
}
