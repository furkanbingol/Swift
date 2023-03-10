import UIKit

struct Place: Codable {
    var name: String
    var latitude: Double
    var longitude: Double
    
}

// Key: String , Value: Array
let json = """
{
    
    "places": [
        {
            "name": "Costa Rica",
            "latitude": 34.56,
            "longitude": 65.67
        },
        {
            "name": "Boston",
            "latitude": 134.56,
            "longitude": 265.67
        }
    ]

}
""".data(using: .utf8)!

let placesDictionary = try! JSONDecoder().decode([String : [Place]].self, from: json)
//print(placesDictionary)      // şu an dictionary halde

let places = placesDictionary["places"]!
print(places)     // şu an array halinde

print(places[0].name)
print(places[0].latitude)
print(places[0].longitude)
print(places[1].name)
print(places[1].latitude)
print(places[1].longitude)
