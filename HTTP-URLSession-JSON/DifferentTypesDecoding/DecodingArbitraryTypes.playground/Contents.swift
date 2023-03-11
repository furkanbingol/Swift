import UIKit

struct AnyDecodable: Decodable {
    
    let value: Any
    
    // <T> : which will take in a particular type of ANY TYPE
    init <T> (_ value: T?) {
        self.value = value ?? ()
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        
        if let string = try? container.decode(String.self) {
            self.init(string)
        } else if let int = try? container.decode(Int.self) {
            self.init(int)
        } else {
            self.init(())
        }
        
    }
}

let json = """

{
    "foo": "Hello",
    "bar": 123
}

""".data(using: .utf8)!

// let dictionary = try! JSONDecoder().decode([String : Any].self, from: json)
// Error. Type 'Any' cannot conform to 'Decodable'


// After we are creating 'AnyDecodable' struct:
let dictionary = try! JSONDecoder().decode([String : AnyDecodable].self, from: json)
print(dictionary)
print(dictionary["foo"]!.value)
print(dictionary["bar"]!.value)
