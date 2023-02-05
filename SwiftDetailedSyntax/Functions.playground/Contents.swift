import UIKit

// func fonksiyonAdı(parametreler) -> Dönüş Tipi

// makeBreakfast(food: ["eggs", "orange juice"])
// makeBreakfast(food: ["cereal", "tea"])


//Parametresiz ve Dönüşsüz Fonksiyonlar
func displayPi() {
    print("3.14")
}

displayPi()


//Parametreli ve Dönüşsüz Fonksiyonlar
func triple(value: Int) {
    print("Triple of \(value) is \(value * 3)")
}

triple(value: 10)

func multiply(number1: Int, number2: Int) {
    print("\(number1) * \(number2) = \(number1 * number2)")
}

multiply(number1: 9, number2: 6)


//ARGUMENT LABELS in Swift
//Bu labellerı biz kendimiz veriyoruz, belli bir label sayısı/türü yok.
//Örnek labellar: to, for, from, and...

func sayHello(firstName: String) {
    let text = "Merhaba, " + firstName
    print(text)
}
sayHello(firstName: "Furkan")
//Furkan'mı Merhaba diyor, bir başkası mı Furkan'a Merhaba diyor?


func sayHello(to firstName: String) {       //sayHello(to: )
    let text = "Merhaba, " + firstName
    print(text)
}
sayHello(to: "Furkan")
//Furkan'a Merhaba diyoruz.


func sayHello(to person: String, and anotherPerson: String) {
    let text = "Merhaba, " + person + " ve " + anotherPerson
    print(text)
}
sayHello(to: "Furkan", and: "Lauren")


func sayHello(_ person: String) {    //_ sayesinde, bu fonksiyonu call ederken 'person' yazılmasını engellemiş oluyoruz --> sayHello("Furkan")
    let text = "Merhaba, " + person
    print(text)
}
sayHello("Kendra")



//Varsayılan Parametre Değerleri
func display(teamName: String, score: Int = 0) {      //Score parametresinin initial değerini 0 yapmış olduk
    let text = teamName + ": " + String(score)
    print(text)
}
display(teamName: "Galatasaray")             //Galatasaray: 0
display(teamName: "Galatasaray", score: 3)   //Galatasaray: 3



//Parametreli ve Dönüşlü Fonksiyonlar
func multiply(_ firstNumber: Int, _ secondNumber: Int) -> Int {
    return firstNumber * secondNumber
}

let res = multiply(3, 4)                         //12
print("Sonuc: " + String(multiply(res, res)))    //Sonuc: 144
