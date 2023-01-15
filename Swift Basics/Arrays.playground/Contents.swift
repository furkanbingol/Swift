import UIKit

//String dizisi
var movies =  ["Matrix", "Interstellar", "Forrest Gump", "Catch me If you can"]

//Any dizisi
var movies2 = ["Matrix", "Interstellar", "Forrest Gump", "Catch me If you can", 5, 10, 15] as [Any]
//Hem String koyduk, hem integer (farklı farklı veri tipleri) --> as [Any] sayesinde
//as  --> casting
//any --> any object

print(movies2[0])
print(movies2[1])
print(movies2[2])
print(movies2[3])
print(movies2[4])
print(movies2[5])
print(movies2[6])
//print(movies2[0].uppercased())  //Value of type 'Any' has no member 'uppercased'


print(movies[0].uppercased())   //MATRIX
print(movies.count)             //eleman sayısı: 4
print(movies2.count)            //eleman sayısı: 7

print(movies[movies.count - 2])

movies.sort()       //Alfabetik sortladı stringleri
print(movies[0])
print(movies[1])
print(movies[2])
print(movies[3])


var numberArray = [1,2,5,4]
numberArray.sort()
print(numberArray[0])
print(numberArray[1])
print(numberArray[2])
print(numberArray[3])
//1 2 4 5
