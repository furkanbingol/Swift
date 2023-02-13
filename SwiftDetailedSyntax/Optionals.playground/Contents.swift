import UIKit

//Optionals --> ?, !

//değerinin ilerde gelme ihtimali var
var age: Int?      //Henüz memory'de değil. Değeri olursa memoryde tutulacak


//nil
var test: String? = ""       //Memory'de yer açılmış ve kullanıma hazır
var test2: String? = nil     //Memory'de hiçbir yeri yok, henüz kullanılamaz --> nil: Initialize edilmemiş olmak


// ? --> Değer olabilir(String, Int, Bool etc.)  veya  olmayabilir(nil).
struct Book {
    var name: String              //nil olamaz
    var publicationYear: Int?     //nil olma ihtimali var
}

let book1 = Book(name: "Book 1", publicationYear: 1997)
let book2 = Book(name: "Book 2", publicationYear: 1998)
let book3 = Book(name: "Book 3", publicationYear: 1999)

//Henüz yayınlanmamış bir kitap?
let book4 = Book(name: "Book4")
let book5 = Book(name: "Book5", publicationYear: nil)


var serverResponseCode = 404           //nil olma ihtimali yok, değişkenin tipi: Int
//var serverResponseCode2 = nil        //Bir değerin tipini belirtmeden, değerini "nil" YAPAMAYIZ!

var serverResponseCode3: Int? = 404    //nil olma ihtimali var, değişkenin tipi: Int?
var serverResponseCode4: Int? = nil


//Optional olan değerler ile çalışmak
var publicationYear: Int? = 2010

if publicationYear != nil {
    print(publicationYear!)         // ! --> force-unwrap operator = 'nil' olabilecek değerleri zorlayarak çıkartır.
}                                   // ! --> Asla nil olma ihtimali yok, eğer olursa ve nil'i checklemediysek kod patlar.

//if let
if let actualYear = publicationYear {    //'publicationYear' nil değilse, onun değerini '!' ile unwrap eder ve 'actualYear' olarak sunar.
    print(actualYear)
    //publicationYear tipi: Int?
    //actualYear tipi:      Int
}

if let year = book2.publicationYear {
    print("Book2's publiaction year is \(year)")
} else {
    //book2.publicationYear = nil ise...
}


//Functions & Optionals
let string = "1234a"
let possibleNumber = Int(string)                    //possibleNumber tipi: Int?
//Çünkü her string, bir tamsayı ifade etmeyebilir.
//Çevirirse sayı gelir, çeviremezse "nil" gelir.

func printFullName(firstName: String, middleName: String?, lastName: String) {   //herkesin middleName'i olmayabilir --> String?
    print(firstName)
    print(lastName)
    if let midName = middleName {
        print(midName)
    }
}

func textFromURL(url: URL) -> String? {   //Bir websitesinin içeriğini metin olarak döndürür, eğer websitesi VAR İSE
    return nil
}

//-----------------------------------------------------------------------------------------------------------------------------

//Failable Initializers (Initialize edilemeyen nesneler)
struct Cocuk {
    var name: String
    var monthsOld: Int
    
    init?(name: String, monthsOld: Int) {        //ÖNEMLİ: initializers'ı Optional yaptık.
        if monthsOld < 12 || monthsOld > 36 {
            return nil
        }
        self.name = name
        self.monthsOld = monthsOld
    }
}

let c1 = Cocuk(name: "Ad1", monthsOld: 5)     //c1 nesnesi --> nil (initialize edilemedi c1)
let c2 = Cocuk(name: "Ad2", monthsOld: 20)
//c1 ve c2'nin tipi: Cocuk?

if let cocuk = c1 {
    //nil değilse gir
    print("c1 nesnesi oluştu, name: \(cocuk.name), monthsOld: \(cocuk.monthsOld)")
} else {
    //c1 nesnesi nil ise, oluşmadıysa gir
    print("c1 nesnesi oluşamadı")
}

//-----------------------------------------------------------------------------------------------------------------------------

//Optional Chaining  --> if let kullanmadan zincirleme kullanım: xyz?.abc?.k

struct Address {
    var buildingNumber: String
    var streetName: String
    var apartmentNumber: String?
}

struct Residence {
    var address: Address?        //oladabilir, olmayadabilir
}

struct Person {
    var age: Int
    var residence: Residence?    //oladabilir, olmayadabilir
}

let person = Person(age: 24, residence: nil)

//UZUN YOL
if let res = person.residence {
    if let address = res.address {
        if let apartNumber = address.apartmentNumber {
            print("Kişi \(apartNumber) numaralı apartmanda yaşıyor.")
        }
    }
}

//KISA YOL (Optional Chaining)
if let apNumber = person.residence?.address?.apartmentNumber {   //Zincirin kırılmaması için TÜM optional değerlerden geçmesi gerekiyor.
    print("Kişi \(apNumber) numaralı apartmanda yaşıyor.")
}

