import UIKit

/*
Class'ların Struct(Value Type)'lardan FARKI:
    1- Inheritance
         :Super Class
         :Sub Class
    2- REFERENCE Type
 

Structlar, classlara göre daha Lightweight & Performant'lardır.
*/


//Class'larda otomatik initializers yoktur. Kendimiz initializers yazmak zorundayız VEYA initial value vermeliyiz.
class Person {
    var firstName = ""
    var secondName = String()
    var street = String.init()
}

class Person2 {
    var firstName: String
    var secondName: String
    var street: String
    
    init(firstName: String, secondName: String, street: String) {
        self.firstName = firstName
        self.secondName = secondName
        self.street = street
    }
}

let human1 = Person()
let human2 = Person2(firstName: "Furkan", secondName: "Bingöl", street: "ABC")
print(human1.firstName)   //initial value -> ""
print(human2.firstName)   //Furkan


//Inheritance
class Vehicle {
    var currentSpeed = 0.0
    
    var description: String {   //get-only property
        return "Araç, saatte \(currentSpeed) km hız ile hareket ediyor."
    }
    
    func makeNoise() {
        //Herhangi bir aracın ne tür bir sese sahip olduğunu bilmediğimiz için
        //bu fonksiyonun içini boş bırakıyoruz.
        //Subclasslar, bu classtaki bu fonksiyonu "OVERRIDE" edecekler.
    }
}

let someVehicle = Vehicle()
print("Vehicle: " + someVehicle.description)


//Subclass oluşturmak
class Bicycle: Vehicle {     //Subclass: Bicycle, Parent: Vehicle
    var hasBasket = false
    
}

let bicycle1 = Bicycle()
bicycle1.hasBasket = true
bicycle1.currentSpeed = 12
print("Bicycle: " + bicycle1.description)


class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
    
}

let tandem1 = Tandem()
tandem1.hasBasket = true
tandem1.currentNumberOfPassengers = 2
tandem1.currentSpeed = 7
print("Tandem: " + tandem1.description)


//Override Example
class Train: Vehicle {
    
    //method override
    override func makeNoise() {
        print("Choo choo!")
    }
}

let train1 = Train()
train1.makeNoise()


class Car: Vehicle {
    var gear = 1
    
    //property override
    override var description: String {
        return (super.description + " Ve vitesi: \(gear)")    //super --> Parent Class'a erişmemize olanak sağlar
    }
}

let car1 = Car()
car1.currentSpeed = 60
car1.gear = 3
print("Car: " + car1.description)


//Override Initializer
class Insan {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Ogrenci: Insan {
    var favLesson: String
    
    init(name: String, favLesson: String) {
        self.favLesson = favLesson
        super.init(name: name)       //Parent'in initializerına eriştik
    }
}

let ogr1 = Ogrenci(name: "Furkan", favLesson: "Math")
print("ogr1.name: " + ogr1.name)
print("ogr2.favLesson: " + ogr1.favLesson)
print("--------------------------------------")

//Classes are REFERENCE Type, Structs are VALUE Type
let ogr2 = ogr1
print("ogr2.name: " + ogr2.name)
print("ogr2.favLesson: " + ogr2.favLesson)

ogr2.name = "Lauress"            //ogr1.name'de degisti
ogr2.favLesson = "Physics"       //ogr1.favLesson'da degisti

print("ogr1.name: " + ogr1.name)
print("ogr1.favLesson: " + ogr1.favLesson)

