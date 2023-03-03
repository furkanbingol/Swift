import UIKit

// Klasik fonksiyon syntax
func sumFunc(numbers: [Int]) -> Int {
    var res = 0
    for val in numbers {
        res += val
    }
    return res
}

// CLOSURE Syntax
// Bir değişkeni, kod bloğuna eşitlemek. Ve daha sonra onu kodun farklı yerlerinde kullanmak --> Closure
// (): Closure'un parametreleri
// ->: Closure'un dönüş tipi
// Closure'larda parametrelerin ismi yoktur. Call'larken direkt istenilen veriyi yazarız.
let sumClosure = { (numbers: [Int]) -> Int in
    var res = 0
    for val in numbers {
        res += val
    }
    return res
}

let funcRes = sumFunc(numbers: [1,2,3,4,5])   // 15
let closureRes = sumClosure([1,2,3,4,5])      // 15


// Swift'te tüm değerlerin bir tipi vardır;  Int, Bool, String ...
// Closure'larında tipi vardır:  (Aldığı Parametre(ler) -> Dönüş Tipi)
// Yukarıdaki sumClosure'un tipi:  ([Int]) -> Int


// CLOSURE TİPLERİ

// MARK: - Parametresiz ve dönüşsüz
// Void: Dönüş tipinin olmamasını anlatır.
let printClosure = { () -> Void in
    print("printClosure executed.")
}
printClosure()


// MARK: - Parametreli ve dönüşsüz
let complexPrintClosure = { (string: String) -> Void in
    print("complexPrintClosure executed. String is: " + string)
}
complexPrintClosure("Furkan")


// MARK: - Parametresiz ve dönüşlü
let randomNumberClosure = { () -> Int in
    return Int.random(in: 1...100)
}
randomNumberClosure()


// MARK: - Parametreli ve dönüşlü
let complexRandomNumberClosure = { (minValue: Int, maxValue: Int) -> Int in
    return Int.random(in: minValue...maxValue)
}
complexRandomNumberClosure(21, 77)



// Closure'ların 'argüman' olarak kullanılması
let playlist = ["track3", "track1", "track2"]

let sortedPlaylist = playlist.sorted { (lhs, rhs) -> Bool in      // sorted(by: ) =  argüman olarak bir Closure bekler.
    return lhs < rhs    // soldaki daha kücük olsun
}
print(playlist)
print(sortedPlaylist)

// -------------------------------------------------------------------------------------------------------------- //

// Closure'ların Kısa Kullanımı
// Closure'ların parametre isimleri olarak '$' İŞARETİ kullanabiliriz. ($ == PARAMETRE)
// ("str1", "str2"):  $0 = "str1", $1 = "str2"

let sortedPlaylist2 = playlist.sorted { return $0 < $1 }
print(sortedPlaylist2)


// Collectionlar(array, dictionary...) üzerinde tanımla olan diğer Closure Örnekleri
// Data Transformation = '.map' closure ile yapılır.  (Date bilgisini, stringe çevirip kullanıcıya sunmak gibi)
// Filtrelemek için = '.filter' closure ile yapılır.  (Adı 'F' ile başlayanları filtrele)
// Birden çok datayı, tek bir data haline getirmek için = '.reduce' closure ile yapılır.  (Bütün arraydeki elemanları topla ve tek bir data haline getir)
// Bir array içindeki nil olan değerlerden kurtulmak için = .compactMap closure kullanırız.

// MARK: - .map
// Veri üzerinde data transformation sağlar.

let names = ["Mehmet", "Alp", "Furkan", "Mustafa"]     // Hepsinin soyismi 'Kaya' olsun istiyoruz.
var fullNames = [String]()
var fullNames2 = [String]()

fullNames = names.map({ (name) -> String in
    return name + " " + "Kaya"
})

fullNames2 = names.map { $0 + " " + "Kaya" }     // sadeleştirilmiş, daha iyi hali

print(fullNames)
print(fullNames2)


// MARK: - .filter

let numbers = [4, 8, 12, 56, 34, 78]
var numberLessThan20 = [Int]()
var numberLessThan20_2 = [Int]()

numberLessThan20 = numbers.filter({ (number) -> Bool in
    // number, array'in o an ki elemanı
    return number < 20      // bu koşul sağlanıyorsa, o number'ı al
})

numberLessThan20_2 = numbers.filter { return $0 < 20 }     // sadeleştirilmiş, daha iyi hali

print(numberLessThan20)
print(numberLessThan20_2)


// MARK: - .reduce

let numbers2 = [1, 6, 3, 5, 4, 8]

let total = numbers2.reduce(0) { currentTotal, newValue -> Int in
    return currentTotal + newValue
}

let total2 = numbers2.reduce(0, {return $0 + $1})
//let total3 = numbers2.reduce(0, {$0 + $1})    // AYNI ŞEY. return yazmasakta olurdu.

print(total)
print(total2)
