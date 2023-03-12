import UIKit

let json: Data = """

{
    "id": 1,
    "name": "Leanne Graham",
    "username": "Bret",
    "email": "Sincere@april.biz",
    "address": {
        "street": "Kulas Light",
        "suite": "Apt. 556",
        "city": "Gwenborough",
        "zipcode": "92998-3874"
    }
}

""".data(using: .utf8)!

struct User: Decodable {
    var id: Int
    var name: String
    var userName: String
    var email: String
    
    var street: String
    var suite: String
    var city: String
    var zipCode: String
    
    // Mapping user properties
    private enum UserKeys: String, CodingKey {
        case id
        case name
        case userName = "username"
        case email
        case address
    }
    
    // Mapping address properties
    private enum AddressKeys: String, CodingKey {
        case street
        case suite
        case city
        case zipCode = "zipcode"
    }
    
    // Initializer from decoder!
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.userName = try container.decode(String.self, forKey: .userName)
        self.email = try container.decode(String.self, forKey: .email)
        
        // .nestedContainer kullandık. Ayrı bir struct(Address) oluşturmadan yaptık.
        let addressContainer = try container.nestedContainer(keyedBy: AddressKeys.self, forKey: .address)
        
        self.street = try addressContainer.decode(String.self, forKey: .street)
        self.suite = try addressContainer.decode(String.self, forKey: .suite)
        self.city = try addressContainer.decode(String.self, forKey: .city)
        self.zipCode = try addressContainer.decode(String.self, forKey: .zipCode)
    }
}

if let user = try? JSONDecoder().decode(User.self, from: json) {
    print(user)
    print(user.id)
    print(user.name)
    print(user.userName)
    print(user.email)
    print(user.street)
    print(user.suite)
    print(user.city)
    print(user.zipCode)
}
