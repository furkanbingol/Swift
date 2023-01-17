import UIKit

var name : String = "James"
print(name.uppercased())

var name2 : String
//print(name2.uppercased())   //ERROR! Variable 'name2' used before being initialized

var name3 : String?           //String optional, ya olur ya olmaz
print(name3?.uppercased())    //?: bulursan yap, bulamazsan yapma hata da verme
//prints --> nil (bulamadı cünkü)

//print(name3!.uppercased())    //!: name3 KESİN var
//name3 initialize edilmediği için kod FATAL ERROR verdi.


//optionals :  ? vs !

var age = "5"
var age2 = "Furkan"

var myIntAge = (Int(age) ?? 1) * 5   //Int(age) doğru çalışmazsa, yani age String'i Int'e çevrilemezse, DEFAULT olarak 1 ata. Bunu sağlayan şey:  ??
print(myIntAge)   //25

myIntAge = (Int(age2) ?? 1) * 5     //age2 Int'e çevrilemez, default olarak 1 atadık.
print(myIntAge)   //5


//if let
if let myNumber = Int(age) {  //String'den Int'e bu değişim sağlanıyorsa, sonucu myNumber'a ata ve alttaki işlemleri yap
    print(myNumber * 5)  //25
}
else{
    print("Wrong input!")
}


if let myNumber = Int(age2) {
    print(myNumber * 5)  //Bu bloğa girmez. Çünkü age2, Int'e cast edilebilecek bir değere sahip değil!
}
else{
    print("Wrong input!")
}
