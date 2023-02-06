import UIKit

let merhaba = "Merhaba"
var greeting = "Hello"

//Uzun bir metni, String'e aktarmak istersek """ kullanıyoruz
let dialog = """
Dialog Basladı
Soru: Bu benim sorum
Cevap: Bu da call center cevabı
Dialog Bitmistir
"""

print(dialog)

//String içinde çift tırnak("") kullanmak istersek
let text = "Kodlama dünyasında \"Merhaba Dünya\" çok kez kullanılır."
print(text)


var myStr = ""        //Empty String
if(myStr.isEmpty) {
    print("String is empty!")
}

let a = "a"               //String
let b: Character = "b"    //Character


//Interpolation(String Concatenation)
let str1 = "Hi"
let str2 = "Furkan!"
let finalStr = str1 + " " + str2
print(finalStr)

let name = "Lana"
let age = "22"
print("Hello, I'am \(name) and I'am \(age) years old.")


//String Equations

//==  (String Kıyaslaması)
print("Furkan" == "Furkan")    //true
print("Furkan" == "furkan")    //false


//Lowercased & Uppercased
let nameStr = "Keira"
if (nameStr.lowercased() == "keiRA".lowercased()) {
    print("They are equal strings!")
}

nameStr.lowercased()
print(nameStr)       //prints "Keira\n"

//Prefix & Suffix
let text1 = "Hello, World!!"
if(text1.hasPrefix("Hel")) {     //prefix: ön ek
    print("In prefix!")
} else {
    print("Not in prefix!")
}

if(text1.hasSuffix(".")) {       //suffix: son ek
    print("In suffix!")
} else {
    print("Not in suffix!")
}

//Contains
let introduceText = "Merhaba Kevin, benim adım Furkan."
if(introduceText.contains("benim adım")) {
    print("IN!")
} else {
    print("NOT IN!")
}

//count
let strstr = "abcdef"
print(strstr.count)   //6

// index(before: )
// insert(_: , at: )
// remove(at: )
