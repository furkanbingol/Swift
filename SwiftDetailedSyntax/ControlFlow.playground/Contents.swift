import UIKit

//If
let x = 20

if(x < 0) {
    print("-")
} else if(x <= 10) {
    print("0 <= x <= 10")
} else if(x <= 20) {
    print("10 < x <= 20")
} else {
    print("x > 20")
}

let number = 100
let isSmallNumber = (number < 120)
print(isSmallNumber)   //true


//Ternary Operator
let k = 20
var myVar = (k > 10 ? "k > 10" : "k <= 10")
print(myVar)  //k > 10


//Switch Case
let wheel = 2

switch wheel {
case 1:
    print("One Wheel")
case 2:
    print("Two Wheel")
case 3:
    print("Three Wheel")
case 4:
    print("Four Wheel")
default:     //Switch-Case'de 'default case' ZORUNLU!
    break
}


let char = "e"

switch char {
case "a", "e", "ı", "i", "o", "ö", "u", "ü":
    print("Sesli Harf")
default:
    print("Sessiz Harf")
}



//x...y --> x dahil ve y dahil
//x..<y --> x dahil ama y dahil değil

let distance = 130

switch distance {
case 100...110:
    print("100 <= distance <= 110")
case 111...120:
    print("111 <= distance <= 120")
case 121..<131:
    print("121 <= distance < 131")
default:
    print("Other cases!")
}
