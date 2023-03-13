import UIKit

struct User: Decodable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var address: Address
    var phone: String
    var website: String
    var company: Company
}

struct Address: Decodable {
    var street: String
    var suite: String
    var city: String
    var zipCode: String
    var geo: Geo
    
    private enum CodingKeys: String, CodingKey {
        case street
        case suite
        case city
        case zipCode = "zipcode"
        case geo
    }
}

struct Geo: Decodable {
    var latitude: String
    var longitude: String
    
    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}

struct Company: Decodable {
    var name: String
    var catchPhrase: String
    var bs: String
}



let url = URL(string: "https://jsonplaceholder.typicode.com/users") ?? nil

if url == nil {
    print("URL error!")
}
else {
    // FETCING Data from API with URLSession.shared.dataTask()
    
    let task = URLSession.shared.dataTask(with: url!) { data, response, error in
        guard let data = data, error == nil else { return }
        
        if let userArray = try? JSONDecoder().decode([User].self, from: data) {
            print(userArray[0].name)
            print(userArray[1].address.zipCode)
            print(userArray[2].address.geo.longitude)
            print(userArray[3].username)
            print(userArray[4].website)
        } else {
            print("Decoding error!")
        }
    }

    task.resume()
}
