//
//  NetworkController.swift
//  SpacePictureOfTheDay
//
//  Created by Furkan Bingöl on 7.03.2023.
//

import Foundation
import UIKit

class NetworkController {
    
    // @escaping: () -> Void, bu kod senkron değil, ASENKRON çalışacak. Yani belli bir "t zaman sonra". Bunu compiler'a belirtmek için @escaping yazıyoruz.
    func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void) {
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
        
        let query : [String : String] = [
            "api_key" : "DEMO_KEY",
            "date" : "2011-07-13"
        ]
        
        let queryURL = baseURL.withQueries(query)!
        
        // Fonksiyonumuz Main Queue'da çalışıyor. Fakat Network işlemleri Main Queue'de çalışmaz. Yani asenkron çalışır. Bu yüzden return ederken hata alırız.
        // dataTask'in Completion Handlerının(data, _, error) içinde bir şey döndüremeyiz.
        // Bu yüzden completion handleri parametre olarak alıyoruz fonksiyona ve o closure sayesinde veriyi return etmiş oluyoruz.
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
    
    // asenkron çalışacak(@escaping ve completion kullanmalıyız) ve IMAGE çekecek.
    func fetchPhoto(from url: URL, completion: @escaping (UIImage?) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        dataTask.resume()
    }
}
