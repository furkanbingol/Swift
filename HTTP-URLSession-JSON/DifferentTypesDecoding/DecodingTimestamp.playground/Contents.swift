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
    var dateCreated: Date
    
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
            "dateCreated": "05/09/2018",
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

extension DateFormatter {
    
    static let myDateFormat: DateFormatter = {   // closure
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyy"      // Month/Day/Year
        return formatter
    }()
}

let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .formatted(DateFormatter.myDateFormat)

let customersResponse = try! decoder.decode(CustomerResponse.self, from: json)
print(customersResponse.customers[0].dateCreated)
