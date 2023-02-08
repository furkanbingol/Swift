import UIKit

//ARRAY
//Array elemanlarının hepsi aynı türden olmalı
//FAKAT Swift'te: 'Any' tipinde array tanımlarsak, aynı dizinin içine farklı farklı veri tipleri koyabiliriz.
//Not: 'let' ile tanımlanan bir diziye eleman eklenemez, eleman çıkartılamaz ve eleman güncellenemez.

var names: [String] = ["Furkan", "Kevin", "Leonardo", "Susan"]
var names2  = ["name1", "name2", "name3"]
var numbers = [1,2,3,4,5]
var bools = [true, false, false]
var mixedArray: [Any] = [123, "abc", true]

//.contains
print(names.contains("Furkan"))    //true

//.count
print(names.count)     //4

//.append --> Dizinin sonuna eleman ekler
names.append("Mike")   //["Furkan", "Kevin", "Leonardo", "Susan", "Mike"]
print(names.count)     //5

//.insert --> Dizinin istenilen indexine eleman ekler
names.insert("Gigi", at: 2)
print(names)   //["Furkan", "Kevin", "Gigi", "Leonardo", "Susan", "Mike"]

//.remove
let deletedName = names.remove(at: 4)    //.remove =  hem siler, hemde silinen elemanı döndürür.
print(deletedName)   //"Susan"
print(names)         //["Furkan", "Kevin", "Gigi", "Leonardo", "Mike"]

//.removeLast() --> sadece 'sonuncu elemanı' silmek için (alternatif)
names.removeLast()
print(names)         //["Furkan", "Kevin", "Gigi", "Leonardo"]

//.removeAll()  --> Diziden tüm elemanları siler
names.removeAll()
print(names.count)   //0

var followers = [String]()             //Empty array  --> BEST
var followers2: [String] = []          //Empty array
var followers3: Array<String> = []     //Empty array


var arr = [Int](repeating: 0, count: 100)    //100 elemanlı, her elemanı 0 olan array


//Birden çok dizinin bir araya gelerek oluşturulan diziler
let numbers1 = [1,3,5,7,9]
let numbers2 = [0,2,4,6,8]
var allNumbers = numbers1 + numbers2

print(allNumbers)   //[1, 3, 5, 7, 9, 0, 2, 4, 6, 8]
allNumbers.sort()
print(allNumbers)   //[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]


//Çok boyutlu Arrayler
let gameBoard: [[String]] = [["X", "O", "X"], ["O", "O", "X"], ["X", "X", "O"]]   //3x3

print(gameBoard[0].count)  //3
print(gameBoard[1].count)  //3
print(gameBoard[2][1])     //"X"



//DICTIONARY
//[key1: value1, key2: value2, key3: value3, ...]

var scores = ["Galatasaray": 89, "Beşiktaş": 87, "Fenerbahçe": 88]    //[String : Int]

var myDict = [String : Int]()               //Empty Dictionary  --> BEST
var myDict2 = Dictionary<String, Int>()     //Empty Dictionary
var myDict3: [String : Int] = [:]           //Empty Dictionary

//Random sırayla verir
print(scores.keys)     //"Fenerbahçe", "Galatasaray", "Beşiktaş"]
print(scores.values)   //88, 89, 87


scores["Galatasaray"] = 90     //update

//Değer güncellerken eski değerine ulamak
let galatasarayOldValue = scores.updateValue(91, forKey: "Galatasaray")
print(galatasarayOldValue!)     //90
print(scores["Galatasaray"]!)   //91

