import UIKit

enum AddressType: String, Codable {
    case apartment = "apartment"
    case house = "house"
    case condo = "condo"
    case townHouse = "townHouse"
}

struct Geo: Codable {
    var latitude: Double
    var longitude: Double

}

struct Address: Codable {
    var street: String
    var city: String
    var state: String
    var geo: Geo
    var addressType: AddressType
    
}

struct Customer: Codable {
    var firstName: String
    var lastName: String
    var address: Address
    
}

struct CustomerResponse: Codable {
    var customers: [Customer]

    private enum CodingKeys: String, CodingKey {
        case customers = "Customers"
    }
}


let json = """
{
    "Customers": [
        {
            "firstName": "John",
            "lastName": "Doe",
            "address": {
                "street": "1200 Richmod Ave",
                "city": "Houston",
                "state": "TX",
                "geo": {
                    "latitude": 34.56,
                    "longitude": 35.65
                },
                "addressType": "house"
            }
        }
    ]
}
""".data(using: .utf8)!

let customersResponse = try! JSONDecoder().decode(CustomerResponse.self, from: json)

print(customersResponse.customers[0].address.addressType)
