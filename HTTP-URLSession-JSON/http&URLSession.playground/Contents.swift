import UIKit
import Foundation

// URL:   Uniform Resource Locator
// http:  Hyper Text Transfer Protocol
// https: Hyper Text Transfer Protocol Secure

// https://                     --> htpp protocolü && s: ssl certificate, secure
// https://apple.com            --> apple.com = domain && apple = hostname
// https://appstore.apple.com   --> appstore  = subdomain
// https://appstore.apple.com/us/app/keynote/id409867   --> /us/app/keynote/id409867 = path
// https://appstore.apple.com/us/app/keynote/id409867?mt=12&id=13   --> ?mt=12&id=13 = query
// ? ile başlayan kısım query-sorgu- kısmıdır.

// -------------------------------------------------------------------------------------------------- //

// Network Request
// 1- Type
// 2- Headers
// 3- Body

// *** Request Type (HTTP Method) ***
// get, post : (en çok kullanılan request tipleridir)
// GET  --> Sunucudan bilgi almak için kullanılır.
// POST --> Sunucuya bilgi göndermek için kullanılır.


// *** Headers ***
// Aslında bir dictionary. (Key, Value)
// Body'de yer alan bilginin hangi formatta olduğunu belirtir. (Örn: JSON, XML..)
// Tarayıcı hakkında bilgiler de içerebilir.


// *** Body ***
// Sunucu ve sorgunun oluşturulduğu bilgisayar arasındaki VERİ ALIŞVERİŞİ, body üzerinden sağlanır.
// Body'de yer alan bilginin hangi formatta olduğunu ise 'Header' belirtir.
// Örn: Bir websitesini yüklediğimizde, Header'da veri tipi HTML olacaktır. Body'de ise bir HTML dosyası yer alacaktır.
// Bir iPhone uygulamasının atacağı post request ise Body alanında muhtemelen bir JSON veya XML türünden data içerecektir.

// NOT: Body'de yer alan bilginin formatı sabit değildir. Sorguya ve sunucuya göre değişkenlik gösterir.

// -------------------------------------------------------------------------------------------------- //

// MARK: - Bir URL Oluşturmak
let url = URL(string: "https://apple.com")!

//print(url.scheme!)    // protocolü verir -> https
//print(url.host()!)    // host'u verir    -> apple.com
//print(url.query!)     // Henüz query belirtmedik -> nil


// MARK: - Network Request'lerin Oluşturulması ve Çalıştırılması

// Data Task ile Request Oluşturmak
let task = URLSession.shared.dataTask(with: url) { data, response , error in
    // .dataTask = ASENKRON İŞLEM başlatır. Network Requestler, Main Queue'da/Main Thread'de çalışan bir işlem değildir.
    //print(data as NSData)   // data as NSData: Bize data hakkında daha detaylı bilgi verir. Fakat byte olarak verir, okunması güç
    if let data = data {
        if let string = String(data: data, encoding: .utf8) {
            //print(string)
        }
    }
}

//task.resume()    // Oluşturulan request'in çalıştırılması


// MARK: - API'lar ile Çalışmak (Application Programming Interface)

extension URL {
    
    // Dictionary olarak alınan parametrelerin, URL'in sonuna eklenmesini sağlayacak bir fonksiyon
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true )         // self: URL'in kendisi
        
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1) }    // $0.0 = key | $0.1 = value
        return components?.url
    }
    
}

let apodUrl = URL(string: "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY")!

let apiTask = URLSession.shared.dataTask(with: apodUrl) { data, response, error in
    if let data = data {
        if let string = String(data: data, encoding: .utf8) {
            //print(string)
        }
    }
}

apiTask.resume()   // Oluşturulan request'in çalıştırılması


// MARK: - Query kullanımı ile API Sorguları
let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!

let query: [String : String] = [     // sorgularımız
    "api_key": "DEMO_KEY",
    "date": "2011-07-13"
]

let queryURL = baseURL.withQueries(query)!
let queryTask = URLSession.shared.dataTask(with: queryURL) { data, response, error in
    if let data = data {
        if let string = String(data: data, encoding: .utf8) {
            print(string)
        }
    }
}

queryTask.resume()   // Oluşturulan request'in çalıştırılması
