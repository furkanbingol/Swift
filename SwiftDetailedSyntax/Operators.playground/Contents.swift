import UIKit

// Atama-Assignment- Operatorü (=)
var greeting = "Hello, playground"


// +, -, *, /
var score1 = 3 * 8
var score2 = 100 / 2
var totalScore = score1 + score2


//TYPE SAFETY in Swift
let totalDistance = 36.78    //Double
var distanceTraveled = 12    //Int
var remainingDistance = totalDistance - Double(distanceTraveled)


let number1 = 11.0
let number2 = 4.0
let number3 = number1 / number2


//Compound Assignment (+=, -=, *=, /=)
var n1 = 10
n1 += 5
print(n1)


//Type Casting
let pi = 3.14
var x = 2
var y = 3
var z = 4
print(Double(x) + Double(y) + Double(z) + pi)
//Dönüşüm, yalnızca yazıldığı satır için geçerlidir. x,y,z hala Int
