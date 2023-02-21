import UIKit
import Foundation

// plist (propertyList) --> Dictionary yapısında data
// encode: veriyi binary formatına dönüştürmek
// decode: veriyi binary formundan istediğimiz diğer forma döndürmek

// ÖNEMLİ-I:  Swift'teki 'Codable' protocolü = Encodable Protocol + Decodable Protocol
// ÖNEMLİ-II: Codable protokolünü destekleyen modelimizde bulunan tüm değişken veri tiplerimizin de Codable protokolünü desteklemesi gerekir.


struct Note: Codable {   //Note: A model
    var title: String
    var text: String
    var timestamp: Date   //notun ne zaman oluşturulduğu bilgi
}

let newNote = Note(title: "Alışverişte Alınacaklar", text: "Domates, Soğan", timestamp: Date())   //Date(): O an


// MARK: - ENCODING
// Bir nesneyi, hafızaya kaydetmek istiyorsak onu Data formunda encode etmek zorundayız.
// Encode dosya formatlarına örnek: JSON, Plist, MP3, MP4 ...
// Bir Note nesnesinin, 'plist' formatına ENCODE edilmesi


// PropertyListEncoder(), Encodable protokolünü destekleyen herhangi bir nesneyi Data formuna encode eder.
let propertyListEncoder = PropertyListEncoder()

do {
    let encodedData = try propertyListEncoder.encode(newNote)    //.encode fonksiyonu 'throwing function' --> error fırlatabilir!
    print(encodedData)
} catch {
    print(error)    //catch blogu: 'error' adında bir değişken verir.
}

/*
'Throwing function' 'ları daha farklı ele alma yöntemi
 -- hatanın bir önemi yok, yalnızca nil olmadığı durumu arıyoruz-- :
 
 if let encodedData = try? propertyListEncoder.encode(newNote) {
    //..
 }
*/


// MARK: - DECODING

if let encodedData = try? propertyListEncoder.encode(newNote) {
    let propertListDecoder = PropertyListDecoder()
    
    //type: Hangi tür modele decode edilmesini istiyoruz
    //from: Hangi data kullanarak bu işlem yapılacak
    if let decodedNote = try? propertListDecoder.decode(Note.self, from: encodedData) {    //'Note.self' --> O sınıfın type'ı
        print(decodedNote)
        print(decodedNote.title)
        print(decodedNote.text)
        print(decodedNote.timestamp)
    }
}


// MARK: - FileManeger ile DOCUMENTs DIRECTORY KULLANIMI

// Her uygulamanın kendi 'Documents Directory' si vardır. (sandbox)
// Uygulamalar, YALNIZCA kendi klasörlerine veri yazabilir veya okuyabilir.
// Uygulamanın dışında bir veriye ulaşmak istendiğinde, bu durum mutlaka kullanıcıya bir alert ile bildirilir.
// Bir projenin birden fazla document directory'si olabilir. Fakat default olarak yalnızca 1 tane oluşturulur.
// Bu nedenle 'documentDirectory değişkenimiz' bir arraydir ve biz ilk elemanına erişmek isteriz --.first--

let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
print(documentDirectory)


// 'documentDirectory' bize bir klasör verir.
// Bu klasör içerisinde yeni bir dosya uzantısı oluşturmamız gerekiyor.
let singleNoteURL = documentDirectory.appendingPathComponent("singleNote").appendingPathExtension("plist")    // .../Documents/singleNote.plist
print(singleNoteURL)


// MARK: - ENCODE EDİLMİŞ DATA'NIN FileManager ile OLUŞTURULMUŞ URL'E KAYDEDİLMESİ (VERİYİ KAYDETME)

if let encodedData = try? propertyListEncoder.encode(newNote) {
    try? encodedData.write(to: singleNoteURL, options: .noFileProtection)     // Data'nın belirtilen bir URL'e yazılmasını sağlar.
    // .noFileProtection = var olan dosyanın üzerine yazılmasını engellemez.
}


// MARK: - VERİYİ OKUMAK

// Data(contentsOf: ) --> parametre olarak vereceğimiz URL'de bulunan datayı kullanarak initalize edilmesini sağlar.
let propertyListDecoder = PropertyListDecoder()
if let retrievedNoteData = try? Data(contentsOf: singleNoteURL) {
    
    // PropertyListDecoder kullanarak, bu Data'dan "Note OBJESİ" oluşturmam gerekli.
    if let decodedNote = try? propertyListDecoder.decode(Note.self, from: retrievedNoteData) {
        print(decodedNote)
        print(decodedNote.title)
        print(decodedNote.text)
        print(decodedNote.timestamp)
    }
}


// MARK: - ARRAY TÜRÜNDEN VERİ KAYDETMEK

let note1 = Note(title: "Bahçe İşleri", text: "Çiçekleri sulamayı unutma.", timestamp: Date())
let note2 = Note(title: "Ventence", text: "Yeni haberler yayına girecek.", timestamp: Date())
let note3 = Note(title: "Garaj İşleri", text: "Garajın içini düzenle.", timestamp: Date())
let notesArray = [note1, note2, note3]

let notesURL = documentDirectory.appendingPathComponent("notes").appendingPathExtension(".plist")   // ../notes.plist

if let encodedNotes = try? propertyListEncoder.encode(notesArray) {   //bir array encode ettik
    try? encodedNotes.write(to: notesURL, options: .noFileProtection)
}


// MARK: - ARRAY TÜRÜNDEN VERİ OKUMAK

if let notesData = try? Data(contentsOf: notesURL) {
    if let decodedNotes = try? propertyListDecoder.decode([Note].self, from: notesData) {    //[Note].self = Note arrayini decode et
        for i in decodedNotes {
            print(i)
        }
    }
}
