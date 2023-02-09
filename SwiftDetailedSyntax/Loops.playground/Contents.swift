import UIKit

//...  -> Kapalı Aralık
//..<  -> Açık Aralık
//..>  -> Açık Aralık

//For (for-in)
for i in 1...5 {
    print("Number: \(i)")
}

for _ in 1...3 {
    print("Hi")
}

var smallAlphabet = ["A", "B", "C", "D", "E", "F", "G", "H"]
for ch in smallAlphabet {
    print(ch)
}

//STRINGLER'de aslında bir COLLECTION'dur --> Char Array'i
for letter in "Furkan" {
    print(letter)
}

//array.enumerated() -> [(index, değer)] (tuple) == O indexin hangi index olduğunu anlayabiliyoruz
for (index, letter) in "Kevin".enumerated() {
    print("index: \(index) , value: \(letter)")
}

var vehicles = ["bicycle": 3, "scooter": 2, "car": 4]    //Dictionary
for (name, count) in vehicles {
    print("name: \(name) , value: \(count)")
}
//NOT: Dictionary'ler ASLA sıralı değildir. Çünkü arkaplanında hash function yapısı vardır.


//While
var numberOfLives = 3

while (numberOfLives != 0) {
    print("Living!");
    numberOfLives -= 1
}

