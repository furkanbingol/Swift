import UIKit

//Constants
let name = "Furkan"
print(name)
//name = "Kevin"     //Cannot assign to value: 'name' is a 'let' constant


//Variables
var height = 170
print(height)
height += 10
print(height)

let defaultScore = 100    //constant
var player1Score = defaultScore
var player2Score = defaultScore

print(player1Score)
print(player2Score)

player1Score += 100
print(player1Score)

//let, var'a göre MEMORY'de DAHA AZ YER KAPLAR.


struct Insan {
    let firstName : String
    let lastName : String
    
    func sayHello() {
        print("Hello! My name is \(firstName) \(lastName)")
    }
}

let insan = Insan(firstName: "Furkan", lastName: "Bingöl")
print(insan.firstName)
print(insan.lastName)
insan.sayHello()


var number = 3.14
var isOpen = true


let looongNumber = 1000000000000
let goodLooongNumber = 1_000_000_000_000
print(looongNumber)
print(goodLooongNumber)


var cityName : String = "San Francisco"
var pi : Double = 3.14
print(cityName)
print(pi)


let sayi1 = 3              //Int
let sayi2 : Double = 3     //Double


let username : String
username = "Leonardo"
print(username)
