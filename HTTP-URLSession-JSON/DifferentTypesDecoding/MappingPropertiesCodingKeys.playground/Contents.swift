import UIKit

struct Address: Codable {
    var street: String
    var state: String
    var zipCode: Int
    
    // --- MAPPING Properties ---
    private enum CodingKeys: String, CodingKey {
        case street = "STREET"
        case state = "STATE"
        case zipCode = "ZIPCODE"
    }
}

struct Customer: Codable {
    var firstName: String
    var lastName: String
    var age: Int
    var address: Address?
    
    // --- MAPPING Properties ---
    private enum CodingKeys: String, CodingKey {
        case firstName = "FIRSTNAME"
        case lastName = "LASTNAME"
        case age = "AGE"
        case address = "ADDRESS"
    }
}

let json = """

{
    "FIRSTNAME": "John",
    "LASTNAME": "Doe",
    "AGE": 34,
    "ADDRESS": {
        "STREET": "1200 Richmond Ave",
        "STATE": "TX",
        "ZIPCODE": 77042
    }
}

""".data(using: .utf8)!

let decoder = JSONDecoder()
let customer = try! decoder.decode(Customer.self, from: json)

print(customer.firstName)
print(customer.lastName)
print(customer.age)
print(customer.address!.street)
print(customer.address!.state)
print(customer.address!.zipCode)
