import UIKit

//Type Casting

//as? Int --> Int olarak cast edebiliyor muyum?
//as! Int --> FORCE CAST, zorla cast et. Eğer edemezse Int'e uygulama çöker.

class Animal { }
class Cat: Animal { }
class Dog: Animal { }
class Bird: Animal { }

//Eğer bir Array'de birden farklı veri tipi varsa, o Array'in tipi --> Any
var array: [Any] = [5, "Furkan", false, 4.78, Dog()]   //Any tipinde array

if let firstItem = array[0] as? Int {   //ilk elemanı Int olarak cast edebiliyor muyum?
    print("Ilk eleman Int türündendir ve değeri 'firstItem' a atanmıştır. firstItem: \(firstItem)")
}
