import UIKit

//Variables & Constants

var greeting = "Hello Swift!"
var myNumber = 20

print(greeting)
print(myNumber)

var userName = "Furkan"
print(userName)
userName = "Trinity"
print(userName)

/*-----------------------------------------------------------------------*/

//CONSTANT (let)
let userBirthDate = 2001
print(userBirthDate)
//userBirthDate = 2000  -->Error! Cannot assign to value: 'userBirthDate' is a 'let' constant

let pi = 3.14
print(pi)

/*-----------------------------------------------------------------------*/

//String
var str = "Swift"
str.append("-iOS")
print(str)                  //str: Swift-iOS

str.lowercased()
print(str)                  //str: Swift-iOS
print(str.lowercased())     //printlerken swift-ios diye printler fakat str: Swift-iOS
print(str.uppercased())     //printlerken SWIFT-IOS diye printler fakat str: Swift-iOS

//NOT: Stringler, Swift dilinde IMMUTABLE(değiştirilemez)'dır!

/*-----------------------------------------------------------------------*/

//integer & double & float & Bool
let a = 50
let b = 4
let c = 7.75
var myBool = false
myBool = true

print(a / b)     //12

var aD = 50.0    //double
var bD = 4.0     //double

print(aD / bD)   //12.5

//aD = "Furkan"    --> Cannot assign value of type 'String' to type 'Double'

/*-----------------------------------------------------------------------*/

var mystr : String = "Software"
let nmbr : Int = 100
let nmbr2 : Int = Int(100.5)     //type-casting

let strNumber : String = String(20)
print(strNumber)

let myVar : String                  //declaration

//myVar.uppercased()  --> Error!

myVar = "Programming with Swift"    //initialization

print(myVar)                   //Programming with Swift
print(myVar.uppercased())      //PROGRAMMING WITH SWIFT
print(myVar)                   //Programming with Swift
