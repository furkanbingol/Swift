import UIKit

class Car: Decodable {
    var make: String = ""
    var model: String = ""
    
    init() {
        
    }
}

class ElectricCar: Car {
    var range: Double = 0.0
    var haveAutoPilot: Bool = false
    
    // Mapping Properties
    private enum CodingKeys: String, CodingKey {
        case range = "range"
        case haveAutoPilot = "haveAutoPilot"
    }
    
    // Required for subclass(inherited types) Parsing in JSON
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.range = try container.decode(Double.self, forKey: .range)
        self.haveAutoPilot = try container.decode(Bool.self, forKey: .haveAutoPilot)
        
        try super.init(from: decoder)
    }
}

let json = """

{
    "make": "Tesla",
    "model": "Model X",
    "range": 400,
    "haveAutoPilot": true
}

""".data(using: .utf8)!

let electricCar = try! JSONDecoder().decode(ElectricCar.self, from: json)
print(electricCar.make)
print(electricCar.model)
print(electricCar.range)
print(electricCar.haveAutoPilot)
