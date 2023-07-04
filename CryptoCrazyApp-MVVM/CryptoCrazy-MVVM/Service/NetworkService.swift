//
//  NetworkService.swift
//  CryptoCrazy-MVVM
//
//  Created by Furkan Bingöl on 21.06.2023.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    
    private init() { }
    
    func downloadCurrencies(completion: @escaping ([CryptoCurrency]?) -> Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else {
            print("URL incorrect!")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            if let cryptoList = try? JSONDecoder().decode([CryptoCurrency].self, from: data) {
                completion(cryptoList)
            } else {
                print("Decoding error!")
                completion(nil)
            }
        }
        
        task.resume()
        
    }
    
    
}
