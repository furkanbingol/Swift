import UIKit

// Enum isimleri büyük harfle başlar, case isimleri küçük harfle başlar.
enum Yon {
    case kuzey
    case guney
    case dogu
    case bati
}

var benimYonum = Yon.kuzey
let onunYonu: Yon = .bati
print(benimYonum)
print(onunYonu)

benimYonum = .bati
print(benimYonum)


//Enum ile kullandığımız switch-case'lerde default case'e GEREK YOK.
switch benimYonum {
case .kuzey:
    print("Kuzey'e yöneldim")
case .guney:
    print("Guney'e yöneldim")
case .dogu:
    print("Dogu'ya yöneldim")
case .bati:
    print("Bati'ya yöneldim")
}


struct Film {
    var isim: String
    var cikisYili: Int
    var tür: String
}

let film1 = Film(isim: "Parasite", cikisYili: 2019, tür: "drama")
// Problem: 'tür', bir standarda sahip değil. "Drama" , "drama" , "rama" , "dram" gibi farklı ve bağımsız şeyler problem yaratırdı.
// 'tür' Enum türünden bir değişken olmalı!


// Enum ile TYPE SAFETY
enum MovieCategory {
    case action
    case drama
    case documentary
    case crime
    case biography
    case comedy
}

struct Movie {
    var name: String
    var releaseYear: Int
    var genre: MovieCategory
}

let movie1 = Movie(name: "The Matrix", releaseYear: 1999, genre: .action)
print("Movie: \(movie1.name) and genre's: \(movie1.genre)")


/*
  --- NOT ---
  Bir yerde enum var ise, case'lerini if yerine "switch" ile kontrol etmeliyiz. Bu şekilde, ileride enum'a
  yeni bir case eklenmesi durumunda compiler, switch'in bulunduğu satırda hata verecektir. Bu hata, enum'un
  tüm case'lerini kontrol etmediğimizi belirtir. Bu şekilde yeni gelen case'leri kontrol etmeyi atlamamış oluruz.
*/
