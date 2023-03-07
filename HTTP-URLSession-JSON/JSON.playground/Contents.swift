import UIKit
import Foundation

// JSON = JavaScript Object Notation
// JSON Temelleri

// Basit bir JSON Örneği:
/*
 {
    "name": "Furkan",
    "favorite_movie": {
        "title": "Minions",
        "release_year": "2017"
    }
 }
 */

// Swift'te JSON
// { }  -> Dictionary (Key:Value)
// [ ]  -> Array
// " "  -> String
// Sayılar ve Bool değerler, " " ile BELİRTİLMEZ. (Örn: 12, true)

// JSON Array'leri
/*
 {
    "movies": [
        {
            "title": "Finding Dory",
            "release_year": "2016
        },
        {
            "title": "Inside Out",
            "release_year": "2015
        }
    ]
 }
 */

// JSON -> Aslında [String : Any]

// ------------------------------------------------------------------------------- //

// MARK: - JSON'dan Swift Veri Modellerine Dönüşüm

extension URL {
    
    // Dictionary olarak alınan parametrelerin, URL'in sonuna eklenmesini sağlayacak fonksiyon
    func withQueries(_ queries: [String : String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)    // self: URL'in kendisi
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1) }
        
        return components?.url
    }
}

let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!

let query : [String : String] = [
    "api_key" : "DEMO_KEY",
    "date" : "2011-07-13"
]

let queryURL = baseURL.withQueries(query)!
let queryTask = URLSession.shared.dataTask(with: queryURL) { (data, _, error) in
    let jsonDecoder = JSONDecoder()
    
    if let data = data {
        // do try catch kullanmadan "try?" kullanabiliriz, KISA YOL olarak.
        // Bunun dezavantajı: Hata olduğu zaman, hatanın ne tür bir hata olduğunu bilemeyiz.
        if let responseDictionary = try? jsonDecoder.decode([String : String].self, from: data) {
            // print(responseDictionary)   // dictionary olarak veriyi elde ettik.
            // Dictionary'ler CODABLE bloğunu desteklediği için JSON'dan veriyi çevirebildik.
            // Eğer özel bir veri tipine dönüşüm istiyorsak, o veri tipinin 'Codable' protocolünü conform etmesi gerekir.
        }
    }
}

queryTask.resume()


// MARK: - JSON'dan Özel Veri Tiplerine Dönüşüm
// Eğer özel bir veri tipine dönüşüm istiyorsak, o veri tipinin 'Codable' protocolünü conform etmesi gerekir.

// API'dan gelen Data'nın JSON Formatı
/*
 "date": "2017-03-21",
 "explanation": "Açıklama metni",
 "hdurl": "Yüksek çözünürlükte olan görselin URL'i",
 "media_type": "image",
 "service_version": "API'ın versiyonu. (Örn: v1)",
 "title": "Başlık",
 "url": "Görselin standart URL'i"
 */

struct PhotoInfo: Codable, Equatable {
    var title: String
    var description: String
    var url: URL
    var copyright: String?
    
    // Hazır bir enum - Eğer tanımlamış olduğumuz değişkenlerin isimleri, JSON'daki key'lerden farklı ise
    // o zaman CodingKeys enum'ını tanımlayarak her bir değişkenimizin JSON karşılığındaki adını belirtmemiz gerekiyor.
    enum CodingKeys: String, CodingKey {
        case title = "title"      // sağ tarafındaki kısım, JSON karşılığı olacak.
        case description = "explanation"
        case url = "url"
        case copyright = "copyright"
    }
    
}

let jsonQueryTask = URLSession.shared.dataTask(with: queryURL) { (data, _, error) in
    let jsonDecoder = JSONDecoder()
    
    if let data = data {
        do {
            // PhotoInfo veri tipimiz Codable protocolünü destekliyor --> PhotoInfo.self 'e dönüştürecek JSON'daki bilgileri.
            let photoInfoObject = try jsonDecoder.decode(PhotoInfo.self, from: data)     // jsonDecoder.decode() ile JSON'daki veriyi decode ettik.
            let title = photoInfoObject.title
            let url = photoInfoObject.url
            print(title)
            print(url)
        } catch {
            print(error)
        }
    }
}

jsonQueryTask.resume()

// ------------------------------------------------------------------------------- //

// Network kodlarının bir fonksiyona taşınması
// Completion Handler
// escaping Function'lar, closure ile sonuç döndürür.

func fetchPhotoInfo(completion: @escaping (PhotoInfo) -> Void) {     // escaping: () -> Void, bu kod senkron değil asenkron çalışacak. Yani belli bir "t zaman sonra". Bunu compiler'a belirtmek için @escaping yazıyoruz.
    let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
    
    let query : [String : String] = [
        "api_key" : "DEMO_KEY",
        "date" : "2011-07-13"
    ]
    
    let queryURL = baseURL.withQueries(query)!
    
    // Fonksiyonumuz Main Queue'da çalışıyor. Fakat Network işlemleri Main Queue'de çalışmaz. Yani asenkron çalışır. Bu yüzden return ederken hata alırız.
    // Completion Handler(data, _, error) içinde bir şey döndüremeyiz.
    let dataTask = URLSession.shared.dataTask(with: queryURL) { (data, _, error) in
        let jsonDecoder = JSONDecoder()
        
        if let data = data {
            if let photoInfoObject = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
                completion(photoInfoObject)
                }
            }
        }
    dataTask.resume()
}

// Completion Handler'a sahip bir fonksiyonun kullanımı:
fetchPhotoInfo { photoInfo in
    // T zamanında çalışacak bir kod bloğu-closure-.. (ASENKRON)
    print(photoInfo)
}


// Yukarıdaki fetchPhotoInfo fonksiyonunu, başka bir Class içerisine almak...
class NetworkController {
    
    func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void) {     // escaping: () -> Void, bu kod senkron değil asenkron çalışacak. Yani belli bir "t zaman sonra". Bunu compiler'a belirtmek için @escaping yazıyoruz.
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
        
        let query : [String : String] = [
            "api_key" : "DEMO_KEY",
            "date" : "2011-07-13"
        ]
        
        let queryURL = baseURL.withQueries(query)!
        
        // Fonksiyonumuz Main Queue'da çalışıyor. Fakat Network işlemleri Main Queue'de çalışmaz. Yani asenkron çalışır. Bu yüzden return ederken hata alırız.
        // Completion Handler(data, _, error) içinde bir şey döndüremeyiz.
        let dataTask = URLSession.shared.dataTask(with: queryURL) { (data, _, error) in
            let jsonDecoder = JSONDecoder()
            
            if let data = data, let photoInfoObject = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
                completion(photoInfoObject)
            } else {
                completion(nil)
            }
        }
        dataTask.resume()
    }
}

let networkController = NetworkController()
networkController.fetchPhotoInfo { photoInfo in
    guard let photoInfo = photoInfo else { return }
    print(photoInfo.title)
}
