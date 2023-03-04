import UIKit

// Extensions
// Var olan bir class'ı veya struct'ı genişletebiliriz. Yeni propertyler, fonksiyonlar ekleyebiliriz.

// instance property'lere nesne oluşturduktan sonra ulaşabiliriz.
// type property'lere o verinin TYPE'I ile direkt olarak ulaşabiliriz. (static yapmalıyız)


// Extension ile Computed Property eklemek
extension UIColor {
    
    static var favoriteColor: UIColor {    // get-only
        return UIColor(red: 0.23, green: 0.12, blue: 0.8, alpha: 1)
    }
}

var myAppColor = UIColor.favoriteColor     // Artık UIColor class'ı üzerinde, yeni bir özelliğimiz var. Bunu extension ile sağladık.


// Tekil kelimeleri çoğul hale getirmek istiyoruz. Fakat String üzerinde bu işi yapabilecek bir fonksiyon(in-built) bulunmuyor.
// "Elma".pluralized() --> "Elmalar"
// instance method eklemeliyiz, String üzerine.

extension String {
    
    mutating func pluralized() -> String {
        // Kompleks bir fonksiyon. Yaptığı iş ise var olan String değerini çoğul hale getirmek.
        return ""
    }
}


// Kodumuzu organize etmek için Extension Kullanımı
class Restaurant {
    // var name: String
    // var menuItems: [MenuItem]
    // var servers: [Employee]
    // var cookingStaff: [Employee]
    // var customers: [Customer]
}

// Restaurant Methods
extension Restaurant {
    // TÜM FONKSİYONLARI buraya yazabiliriz. Bu sayede düzen sağlamış oluruz.
    // Propertyler asıl class'ta, fonksiyonlar ise extensionda olmuş olur ve bu sayede organize etmiş oluruz.
    
    // func add(menuItem: MenuItem)
    // func remove(menuItem: MenuItem)
    // func welcome(guest: Customer)
    // func serve(item: MenuItem, to guest: Customer)
}



// Extensionlar, protocollerle ÇOK kullanılır --- ÇOK ÖNEMLİ

// Extension kullanmadan ÖRNEK
struct Employee: Equatable, Codable, Comparable {
    var firstName: String
    var lastName: String
    var jobTitle: String
    var phoneNumber: String
    
    func fullName() -> String {
        return firstName + " " + lastName
    }
    
    
    static func < (lhs: Employee, rhs: Employee) -> Bool {      // Comparable Protocol stub
        return lhs.firstName < rhs.firstName && lhs.lastName < rhs.lastName
    }
    
    static func == (lhs: Employee, rhs: Employee) -> Bool {     // Equatable protocol stub
        return lhs.firstName == rhs.firstName &&
                lhs.lastName == rhs.lastName &&
                lhs.jobTitle == rhs.jobTitle &&
                lhs.phoneNumber == rhs.phoneNumber
    }
}


// Extension kullanarak ÖRNEK
struct Employee2 {
    var firstName: String
    var lastName: String
    var jobTitle: String
    var phoneNumber: String
    
    func fullName() -> String {
        return firstName + " " + lastName
    }
}

extension Employee2: Equatable, Codable, Comparable {
    // Protocolleri, EXTENSIONDA conform ettirdik.
    
    static func < (lhs: Employee2, rhs: Employee2) -> Bool {    // Comparable Protocol stub
        return lhs.firstName < rhs.firstName && lhs.lastName < rhs.lastName
    }
    
    static func == (lhs: Employee2, rhs: Employee2) -> Bool {     // Equatable protocol stub
        return lhs.firstName == rhs.firstName &&
                lhs.lastName == rhs.lastName &&
                lhs.jobTitle == rhs.jobTitle &&
                lhs.phoneNumber == rhs.phoneNumber
    }
}
