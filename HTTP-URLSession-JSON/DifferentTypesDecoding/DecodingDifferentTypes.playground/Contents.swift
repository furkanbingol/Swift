import UIKit

struct Place: Decodable {
    var latitude: Double
    var longitude: Double
    
    // Mapping properties
    private enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
    }
    
    // Decoder tarafından init edilirken kullanılacak initializers
    init(from decoder: Decoder) throws {
        
        if let container = try? decoder.container(keyedBy: CodingKeys.self) {
            self.latitude = try container.decode(Double.self, forKey: .latitude)
            self.longitude = try container.decode(Double.self, forKey: .longitude)
        }
        else if var container = try? decoder.unkeyedContainer() {       // Kullandığımız şey .unkeyedContainer()
            self.latitude = try container.decode(Double.self)
            self.longitude = try container.decode(Double.self)
        }
        else if let container = try? decoder.singleValueContainer() {   // Sadece string veya diğer singleValue'lar olarak sonucu alırsak, bu kısımdaki gibi decode edilecek
            let string = try container.decode(String.self)
            let values = string.split(separator: ",")      // split'le virgüle(,) göre ayırdık.
            
            guard values.count == 2 else {
                let context = DecodingError.Context.init(codingPath: decoder.codingPath,
                                                         debugDescription: "Unable to decode coordinates!")
                throw DecodingError.dataCorrupted(context)
            }
            
            self.latitude = Double(values[0])!
            self.longitude = Double(values[1])!
        }
        else {
            let context = DecodingError.Context.init(codingPath: decoder.codingPath,
                                                     debugDescription: "Unable to decode coordinates!")
            throw DecodingError.dataCorrupted(context)
        }
        
    }
}

let payload1 = """

{
    "coordinates": [
        {
            "latitude": 37.332,
            "longitude": -122.011
        }
    ]
}

""".data(using: .utf8)!

let placesDictionary1 = try! JSONDecoder().decode([String : [Place]].self, from: payload1)
let places1 = placesDictionary1["coordinates"]!
print(places1[0].latitude)
print(places1[0].longitude)


// --------------------------------------------------------------------------------------------- //


let payload2 = """

{
    "coordinates": [
        [37.332,-122.011]
    ]
}

""".data(using: .utf8)!

// Bu yöntem bize sonucu Double Matrix olarak verir.
// Bu Double Matrix'ten modele dökmek biraz daha uğraştırır.
// Biz bunu DİREKT OLARAK modele dökmek istiyoruz.
/*
let placesDictionary2 = try! JSONDecoder().decode([String : [[Double]]].self, from: payload2)
let places2 = placesDictionary2["coordinates"]!
print(places2[0][0])
print(places2[0][1])
*/

let placesDictionary2 = try! JSONDecoder().decode([String : [Place]].self, from: payload2)
let places2 = placesDictionary2["coordinates"]!
print(places2[0].latitude)
print(places2[0].longitude)


// --------------------------------------------------------------------------------------------- //


let payload3 = """

{
    "coordinates": [
        "37.332,-122.011"
    ]
}

""".data(using: .utf8)!

let placesDictionary3 = try! JSONDecoder().decode([String : [Place]].self, from: payload3)
let places3 = placesDictionary3["coordinates"]!
print(places3[0].latitude)
print(places3[0].longitude)
