import UIKit

// Protocol(Swift) == Abstract Class(Java)

/*
 --- Protocol ---
 Protocol, bir dizi fonksiyon ve değişkenlerden oluşan bir şablon(blueprint)'dur.
 Bir protocolü, class veya struct conform edebilir/destekleyebilir.
 
 Swift'te var olan bazı protocoller:
 
 -> CustomStringConvertible    (Kendi objelerimizi nasıl yazdıralım print ile -> onu belirleyen protocol. Java'daki toString() methodu gibi)
 -> Equatable    (iki objenin eşit olup olmadığını(bazı özelliklere göre) kıyaslayan protocol)
 -> Comparable   (aynı türden data'nın, nasıl 'SORT' edilebileceğini belirleyen protocol)
 -> Codable      (data'mızı-> dictionary(key:value) şekline getirmemizi sağlayan protocol)
 */

// ------------------------------------------------------------------------------------------------------------------------------------ //

// 'CustomStringConvertible' Protocolü
struct Ayakkabi {
    var color: String
    var size: Int
}

let ayakkabi1 = Ayakkabi(color: "Siyah", size: 42)
print(ayakkabi1)         //prints --> Ayakkabi(color: "Siyah", size: 42) | xcode'da ise --> nesnenin 'memory adresini' printler


struct Shoe: CustomStringConvertible {
    var color: String
    var size: Int
    
    var description: String {    //read-only property, CustomStringConvertible protocolünden gelen değişken
        return "color: \(color), size: \(size)"
    }
}

let shoe1 = Shoe(color: "Black", size: 41)
print(shoe1.description)     //prints -->  color: Black, size: 41
print(shoe1)                 //prints -->  color: Black, size: 41

// ------------------------------------------------------------------------------------------------------------------------------------ //

// 'Equatable' Protocolü (==)
struct Employee: Equatable {
    var firstName: String
    var lastName: String
    var jobTitle: String
    var phoneNumber: String
    
    //Equatable protocolündeki '== metodunu' override ettik
    static func == (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.phoneNumber == rhs.phoneNumber
    }

}

struct Company {
    var name: String
    var employees: [Employee]
}

let currentEmployee = Employee(firstName: "Furkan", lastName: "Bingöl", jobTitle: "iOS Developer", phoneNumber: "")
var selectedEmployee = Employee(firstName: "ABC", lastName: "DEF", jobTitle: "Content Director", phoneNumber: "")

// if currentEmployee == selectedEmployee     //Error! Binary operator '==' cannot be applied to two 'Employee' operands
// Bu hatayı çözmek için 'Equatable' protocolünü, Employee structında conform etmeliyiz

if currentEmployee == selectedEmployee {
    print("Both are the same employee.")
} else {
    print("They aren't the same employee.")
}

// ------------------------------------------------------------------------------------------------------------------------------------ //

// 'Comparable' Protocolü
struct Employee2: Equatable, Comparable {
    var firstName: String
    var lastName: String
    var jobTitle: String
    var phoneNumber: String
    
    //Comparable protocolündeki '< metodunu' override ettik
    static func < (lhs: Employee2, rhs: Employee2) -> Bool {
        return lhs.lastName < rhs.lastName        //'soyisme' göre küçükten büyüge sıralama
    }
    
    //Equatable protocolündeki '== metodunu' override ettik
    static func == (lhs: Employee2, rhs: Employee2) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.phoneNumber == rhs.phoneNumber
    }

}

let employee1 = Employee2(firstName: "Mehmet", lastName: "lname1", jobTitle: "title1", phoneNumber: "phone1")
let employee2 = Employee2(firstName: "Ahmet", lastName: "lname2", jobTitle: "title2", phoneNumber: "phone2")
let employee3 = Employee2(firstName: "Kerem", lastName: "lname3", jobTitle: "title3", phoneNumber: "phone3")
let employee4 = Employee2(firstName: "Furkan", lastName: "lname4", jobTitle: "title4", phoneNumber: "phone4")
let employee5 = Employee2(firstName: "Ali", lastName: "lname5", jobTitle: "title5", phoneNumber: "phone5")

let employees = [employee2, employee1, employee4, employee5, employee3]

let sortedEmployees1 = employees.sorted(by: <)     // sorted(by: ) --> Array'ler üzerinde çalışan bir sıralama fonksiyonu
let sortedEmployees2 = employees.sorted(by: >)

print("employees")
for emp in employees {
    print(emp)
}

print("sortedEmployees1")
for emp in sortedEmployees1 {
    print(emp)
}

print("sortedEmployees2")
for emp in sortedEmployees2 {
    print(emp)
}

// ------------------------------------------------------------------------------------------------------------------------------------ //

// 'Codable' Protocolü --> Bilginin 'Dictionary' formuna geçirilmesi (key-value)
struct Employee3: Equatable, Comparable, Codable {
    var firstName: String
    var lastName: String
    var jobTitle: String
    var phoneNumber: String
    
    //Comparable protocolündeki '< metodunu' override ettik
    static func < (lhs: Employee3, rhs: Employee3) -> Bool {
        return lhs.lastName < rhs.lastName        //'soyisme' göre küçükten büyüge sıralama
    }
    
    //Equatable protocolündeki '== metodunu' override ettik
    static func == (lhs: Employee3, rhs: Employee3) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.phoneNumber == rhs.phoneNumber
    }

}

let bestEmployee = Employee3(firstName: "Ben", lastName: "Atkins", jobTitle: "Front Desk", phoneNumber: "")

// Codable protokolünü destekleyen bir veri modelinden, 'Dictionary' formunda veri oluşturabilmek için;
// 'JSONEncoder' adını verdiğimiz bir Class kullanılır.
let encoder = JSONEncoder()

let jsonData = try! encoder.encode(bestEmployee)
let jsonString = String(data: jsonData, encoding: .utf8)

print(jsonString!)     //{"firstName":"Ben","lastName":"Atkins","jobTitle":"Front Desk","phoneNumber":""} --> Dictionary

// ------------------------------------------------------------------------------------------------------------------------------------ //

// KENDİ Protocolümüzü Oluşturmak
// Protocoller, bir değişkenin değerini veya fonksiyonun ne yaptığını belirtmez. Yalnızca isim ve tür belirtirler.
// { get }     -> Yalnızca değeri okunabilir
// { get set } -> Değeri hem okunabilir, hem yazılabilir.

protocol FullyNamed {
    var fullName: String { get }    //get-only
    
    func sayFullName()
}


struct Person: FullyNamed {
    var firstName: String
    var lastName: String
    
    var fullName: String {       //get-only property
        return firstName + " " + lastName
    }
    
    func sayFullName() {
        print(fullName)
    }
}

let p1 = Person(firstName: "Furkan", lastName: "Bingöl")
print(p1.fullName)     //Furkan Bingöl
p1.sayFullName()       //Furkan Bingöl
