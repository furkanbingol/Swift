import UIKit

typealias Temperature = Double      // Temperature, Double gibi davranacak.

extension Temperature {
    
    func toCelcius() -> Temperature {
        return (self - 32 * 5/9) + 32
    }
    
    func toFahrenheit() -> Temperature {
        return (self * 9/5)
    }
    
}

private enum TemperatureEncodingStrategy {
    case fahrenheit
    case celcius
}

// A user-defined key for providing context during encoding and decoding.
extension CodingUserInfoKey {
    static let temperatureEncodingStrategy = CodingUserInfoKey.init(rawValue: "temperatureEncodingStrategy")!
    
}


struct Thermostat: Encodable {
    
    var readings: [Temperature]
    
    // encode function
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch encoder.userInfo[CodingUserInfoKey.temperatureEncodingStrategy] as? TemperatureEncodingStrategy {
        case .fahrenheit:
            try container.encode(self.readings.map{ $0.toFahrenheit() })
        case .celcius:
            try container.encode(self.readings.map{ $0.toCelcius() })
        default:
            break
            
        }
    }
}

let readings = [12.34, 23.45, 56.78]
let encoder = JSONEncoder()

encoder.userInfo[CodingUserInfoKey.temperatureEncodingStrategy] = TemperatureEncodingStrategy.celcius

let thermostat = Thermostat(readings: readings)

// Get ENCODED DATA
let data = try! encoder.encode(thermostat)

print(String(data: data, encoding: .utf8)!)
