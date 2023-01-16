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

/*--------------------------------------------------------------------*/

//Set
//Set : Unordered collection and Unique elements

var mySet : Set = [1,2,3,4,5,5,5]
//Set'lerde indexing yoktur. Her eleman bir set'te BİR kez bulunur.

print(mySet)

var mySet2 : Set = [1,1,1,1,1,2,6,6,6,6]  //--> 1,2,6 elemanları mySet2 set'inde bulunur.
print(mySet2)

//int array --> set
var intArr = [1,1,1,1,1,2,2,2,3,3,3,4]
var setArr = Set(intArr)
print(intArr)
print(setArr)

//Set'leri birleştirme
var mySet3 = mySet.union(mySet2)
print(mySet3)    //1,2,3,4,5,6 içerir

/*--------------------------------------------------------------------*/

//Dictionary (Java'daki 'HashMap' mantığı)
//key-value pairing

var Directors = ["Pulp Fiction" : "Tarantino", "Lock, Stock" : "Guy Ritchie", "The Dark Knight" : "Christopher Nolan"]

Directors["Pulp Fiction"]        //"Tarantino"
Directors["The Dark Knight"]     //"Christopher Nolan"
Directors["Abc"]       //nil = In Swift, NULL and nil are equal to each other, but nil is an object value while NULL is a generic pointer value ((void*)0, to be specific)

Directors["Pulp Fiction"] = "Quentin Tarantino"
Directors["Pulp Fiction"]   //"Quentin Tarantino"

print(Directors)

Directors["Abc"] = "xyz"
print(Directors)

var myDict = ["Run" : 100, "Swim" : 200, "Basketball" : 300]
print(myDict)
print(myDict.count)  //3
