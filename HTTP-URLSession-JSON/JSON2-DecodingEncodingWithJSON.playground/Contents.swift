import UIKit

// DECODING JSON to a Model
struct Customer: Decodable {
    var firstName: String
    var lastName: String
    var age: Int

}

let json = """

{
    "firstName": "John",
    "lastName": "Doe",
    "age": 34
}

""".data(using: .utf8)!

// (Customer) represent a class, but (Customer.self) represent the TYPE.
// JSONDecoder & JSONEncoder needs to know the 'TYPE' of the class.

let customer1 = try! JSONDecoder().decode(Customer.self, from: json)   // ONE-LINE CODE for decoding data to a model
print(customer1)

// ------------------------------------------------------------------------------------------------------------------- //

// ENCODING a Model to JSON
struct Customer2: Codable {
    var firstName: String
    var lastName: String
    var age: Int

}

let customer2 = Customer2(firstName: "Furkan", lastName: "Bingöl", age: 22)
let encodedData = try JSONEncoder().encode(customer2)   // encodedData's type: Data
print(encodedData)        // prints 52 bytes

let customer2String = String(data: encodedData, encoding: .utf8)!
print(customer2String)    // prints {"firstName":"Furkan","age":22,"lastName":"Bingöl"}

// ------------------------------------------------------------------------------------------------------------------- //

// DECODING JSON - decoding Arrays -

struct Place: Codable {
    var name: String
    var latitude: Double
    var longitude: Double
    var visited: Bool
    
    /*   Bu CodingKeys enum'ının sağ tarafı, JSON tarafındaki karşılıklar. Eğer farklı bir isimdeyse bu enum'a ihtiyaç duyacağız.
    
     private enum CodingKeys: String, CodingKey {
        case name = "name"
        case latitude = "latitude"
        case longitude = "longitude"
        case visited = "visited"
    }
    */
}

let json2 = """
[
    {
       "name": "Costa Rica",
        "latitude": 23.45,
        "longitude": 45.23,
        "visited": true
    },
    {
       "name": "Puerto Rico",
        "latitude": 23,
        "longitude": 45,
        "visited": true
    },
    {
       "name": "Mexico City",
        "latitude": 23,
        "longitude": 45,
        "visited": true
    }
    ,
    {
       "name": "Iceland",
        "latitude": 23,
        "longitude": 45,
        "visited": false
    }
]
""".data(using: .utf8)!

let places = try! JSONDecoder().decode([Place].self, from: json2)    // [Place].self == Place dizisinin TYPE'ı

for place in places {
    print(place)
}
