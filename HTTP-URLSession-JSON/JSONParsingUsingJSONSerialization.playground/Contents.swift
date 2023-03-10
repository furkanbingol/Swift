import UIKit
import Foundation

// MODEL
struct Customer {
    var firstName: String
    var lastName: String
    var age: Int
    
}

// Bu initializer'ı extensiona aldık. Eğer direkt, Customer üzerinde bu init'i kullansaydık, default init yerine "OVERRIDE" edilecekti.
// Biz bunu istemediğimiz için ayrı bir extensionda, yeni initializersını tanımladık.
extension Customer {
    // init? = Nesne oluşmayadabilir, yani nil'de olabilir. Optional.
    init?(dictionary: [String:Any]) {
        guard let firstName = dictionary["firstName"] as? String,
              let lastName = dictionary["lastName"] as? String,
              let age = dictionary["age"] as? Int
        else { return nil }
        
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
}


// Before Swift 4, developers used 'JSONSerialization' for JSON Parsing.
// OLD WAY for JSON Parsing.
let json = """
[
    {
        "firstName": "John",
        "lastName": "Doe",
        "age": 34
    },
    {
        "firstName": "Kevin",
        "lastName": "Amy",
        "age": 25
    },
    {
        "firstName": "Furkan",
        "lastName": "Bingöl",
        "age": 22
    }
]

""".data(using: .utf8)!

// Birden fazla nesneyi Serialize etmek istersek.
let customerDictionaries = try? JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [[String:Any]]

let customers = customerDictionaries?.compactMap({ dictionary in      // compactMap: nil değerleri almaz.
    return Customer(dictionary: dictionary)
})

for customer in customers! {
    print(customer)
}


// Tek bir nesneyi Serialize etmek istersek.
/*
if let dictionary = try! JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String:Any] {
    if let customer = Customer(dictionary: dictionary) {
        print(customer)
    }
}
*/
