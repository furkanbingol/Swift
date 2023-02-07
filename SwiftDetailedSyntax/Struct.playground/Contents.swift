import UIKit

//Bir struct içinde neler var?
//1- Değişkenler ve sabitler (Property)
//2- Initializers
//3- Methods
//4- enum'lar, başka struct'lar (OPSİYONEL)

struct People {
    var firstName: String
    
    func sayHello() {
        print("Hi, my name is \(firstName)")
    }
}

//People türünden bir INSTANCE(nesne) oluşturmak
let human1 = People(firstName: "Furkan")      //Initializers, structlarda otomatik tanımlanır!
print(human1.firstName)
human1.sayHello()


enum Beden {       //Beden ENUM yapısı
    case xsmall
    case small
    case medium
    case large
}
 
enum Renk {        //Renk ENUM yapısı
    case kırmızı
    case mavi
    case yeşil
    case beyaz
}
 
struct Tshirt {
    var beden: Beden
    var renk: Renk
}
 
let tshirt1 = Tshirt(beden: .large, renk: .yeşil)
let tshirt2 = Tshirt(beden: .xsmall, renk: .beyaz)


struct Car {
    var make: String
    var model: String
    var year: Int
    var topSpeed: Int
    
    func startEngine() {
        print("Engine started! Make: \(make), Model: \(model), Year: \(year), Maximum Speed: \(topSpeed)")
    }
    
    func drive() {
        print("The car is being driven! Make: \(make), Model: \(model), Year: \(year), Maximum Speed: \(topSpeed)")
    }
    
    func park() {
        print("The car parked! Make: \(make), Model: \(model), Year: \(year), Maximum Speed: \(topSpeed)")
    }
}

let car1 = Car(make: "Honda", model: "Civic", year: 2010, topSpeed: 180)
let car2 = Car(make: "Ford", model: "Mustang", year: 2020, topSpeed: 280)

car1.startEngine()
car1.drive()
car2.startEngine()
car2.park()

//NOT: String, Int, Double, Bool ... -> Bunların hepsi Swift'te bir STRUCT'tır.

//Initializers(Constructor) ==> Structlarda "otomatik" olarak tanımlanır --> Memberwise Initializer

var string = String.init()     //default initializers of String --> ""
var integer = Int.init()       //default initializers of Int    --> 0
var bool = Bool.init()         //default initializers of Bool   --> false

//.init() == ()
var int1 = Int()          //0
var str1 = String()       //""
var str2 = String.init("Ahmet")
var str3 = String("Ahmet")
print(str2 == str3)       //true


//Initializers | (Default Values)
struct Odometer {
    var count: Int = 0
}

let odometer1 = Odometer()             //odometer1.count = 0
let odometer2 = Odometer(count: 10)    //odometer2.count = 10


struct İnsan {
    var ad: String = ""
}

// Hatalı bir varsayılan değer kullanımı. Bu, adı "" olan bir insan oluşturmaya neden olabilir!
let insan1 = İnsan()


//Custom Initializers
struct Temperature {
    var celcius: Double
    
    //Eğer kendi initializerlar'ımızı yazarsak, Swift'in sağladığı DEFAULT initializer'a ARTIK ERİŞEMEYİZ.
    init(celcius: Double) {       //initializer == constructor
        self.celcius = celcius
    }
    
    init(fahrenheit: Double) {
        self.celcius = (fahrenheit - 32) / 1.8
    }
    
    init(kelvin: Double) {
        self.celcius = kelvin - 273.15
    }
}

let temp1 = Temperature(celcius: 32)
let temp2 = Temperature(fahrenheit: 87)
let temp3 = Temperature(kelvin: 273.15)
print(temp1.celcius)
print(temp2.celcius)
print(temp3.celcius)


//Instance Methods (Nesne Methodları)
struct Size {
    var width: Double
    var height: Double
    
    func area() -> Double {
        return width * height
    }
}

let size1 = Size(width: 12, height: 14.65)
let area1 = size1.area()
print("Area of size1: " + String(area1))


//Mutating Functions
struct KilometreSayaci {
    var deger: Int = 0         //Default value is 0
    
    mutating func artir() {    //Fonksiyon, Property'i değiştiriyorsa 'mutating' keywordü gerekli!
        deger += 1
    }
    
    mutating func artir(miktar : Int) {
        deger += miktar
    }
    
    mutating func reset() {
        deger = 0
    }
}

var sayac = KilometreSayaci()
sayac.artir()
print(sayac.deger)           //1
sayac.artir(miktar: 19)
print(sayac.deger)           //20
sayac.reset()
print(sayac.deger)           //0


//Computed Property (Hesaplanan Özellikler)
//Get-only

struct Sicaklik {
    var celcius: Double
    
    //Get-only property
    var fahrenheit: Double {       //computed property (celcius her değiştiğinde, fahrenheit ve kelvin değişkeni de DEĞİŞECEK)
        return celcius * 1.8 + 32
    }
    
    //Get-only property
    var kelvin: Double {           //computed property
        return celcius + 273.15
    }
}

var sicaklik1 = Sicaklik(celcius: 24)
print(sicaklik1.fahrenheit)
print(sicaklik1.kelvin)

//sicaklik1.fahrenheit = 150    //error: cannot assign to property: 'fahrenheit' is a get-only property

sicaklik1.celcius = 32
print(sicaklik1.fahrenheit)
print(sicaklik1.kelvin)



//Property Observers (Özellik Gözlemleyicileri)

//1- willSet  --> değişkenin değeri değişmek üzere, henüz değişmedi
//2- didSet   --> değişkenin değeri değişti

struct AdimSayar {
    var adimSayisi: Int = 0 {
        willSet {
            //newValue --> Yeni gelecek olan değer
            print("adimSayisi, birazdan \(newValue) olacak.")
        }
        didSet {
            //oldValue --> Yeni değer gelmeden önceki değer
            if adimSayisi > oldValue {
                print("\(adimSayisi - oldValue) adım atılmış!")
            } else {
                print("Geri gidilmiş!")
            }
        }
    }
}

var adimSayar1 = AdimSayar()
adimSayar1.adimSayisi = 3
adimSayar1.adimSayisi = 178



//Type Methods and Properties (static)
// Instance --> Object
// Type     --> Veri Tipi (Struct)

struct OndalikliSayi {
    static let pi: Double = 3.14
    
}

print(OndalikliSayi.pi)  //Nesne oluşturmadan, struct(type) üzerinden eriştik --> "static" sayesinde

//Fonksiyonlarda 'static' olabilir
let enKucukSayi = Double.minimum(12, 34.9)      //Double structındaki, "minimum" fonksiyonu static'tir!
print(enKucukSayi)



//Struct --> VALUE Copy
//Class  --> REFERENCE Copy

var someSize = Size(width: 200, height: 400)
var anotherSize = someSize     //value passing(Size is 'struct')

print("anotherSize.width: \(anotherSize.width)")
print("anotherSize.height: \(anotherSize.height)")
print("--------------------------------")

anotherSize.width = 100    //someSize.width değişmedi
anotherSize.height = 500   //someSize.height değişmedi

print("anotherSize.width: \(anotherSize.width)")
print("anotherSize.height: \(anotherSize.height)")
print("someSize.width: \(someSize.width)")
print("someSize.height: \(someSize.height)")
