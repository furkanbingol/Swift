import UIKit

struct Geo: Codable {
    var latitude: Double
    var longitude: Double
    
}

struct Address: Codable {
    var street: String
    var city: String
    var state: String
    var geo: Geo
    
}

struct Customer: Codable {
    var firstName: String
    var lastName: String
    var address: Address
    
}

struct CustomerResponse: Codable {
    var customers: [Customer]
    
    private enum CodingKeys: String, CodingKey {
        case customers = "customerss"
    }
}


// a Nested Object
// [String: [Customer]]
let json = """

{
    "customerss": [
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
                }
            }
        }
    ]

}

""".data(using: .utf8)!

let customersResponse = try! JSONDecoder().decode(CustomerResponse.self, from: json)

print(customersResponse.customers[0].firstName)
print(customersResponse.customers[0].lastName)
print(customersResponse.customers[0].address.street)
print(customersResponse.customers[0].address.city)
print(customersResponse.customers[0].address.state)
print(customersResponse.customers[0].address.geo.latitude)
print(customersResponse.customers[0].address.geo.longitude)
