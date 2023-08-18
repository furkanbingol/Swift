//
//  APICaller.swift
//  APIKit
//
//  Created by Furkan Bingöl on 18.08.2023.
//

import Foundation

// "Public" yapmamızın sebebi, bu class ve içindeki propertyleri, diğer modüllerde kullanacak olmamız.
// Diğer modüllerin bu targettaki şeyleri görebilmesi için, "public" olarak tanımlamalıyız.
public class APICaller {
    public static let shared = APICaller()
    private init() { }
    
    public func fetchCourseNames(completion: @escaping ([String]) -> Void) {
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/index.php") else {
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data,
                  error == nil else {
                completion([])
                return
            }
            
            do {
                guard let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String : String]] else {
                    completion([])
                    return
                }
                let names = response.compactMap({ $0["name"] })
                completion(names)
            } catch {
                completion([])
            }
        }
        
        task.resume()
    }
}
