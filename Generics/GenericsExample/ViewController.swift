//
//  ViewController.swift
//  GenericsExample
//
//  Created by Furkan Bingöl on 7.06.2023.
//

import UIKit


struct Fruit: Codable {
    let name: String
    let color: String
    let identifier: String
    let imageName: String
}

struct Car: Codable {
    let name: String
    let model: String
    let identifier: String
    let imageName: String
}

struct Recipes: Codable {
    let name: String
    let recipeType: String
    let identifier: String
    let imageName: String
}


class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        APICaller.shared.performAPICALL(url: "https://exampleAPI.com/getCars", expectingReturnType: Car.self) { result in
            switch result {
                case .success(let car):
                    print(car.model)
                case .failure(let error):
                    print(error)
            }
        }
        
        APICaller.shared.performAPICALL(url: "https://exampleAPI.com/getFruits", expectingReturnType: Fruit.self) { result in
            switch result {
                case .success(let fruit):
                    print(fruit.color)
                case .failure(let error):
                    print(error)
            }
        }
    }
        
    // "Generics" kullanmazsak, getFruits'e benzer aynı kodları tekrar tekrar yazmamız gerekecek.
    // Yani getFruits() gibi, getCar() ve getRecipes() yazmamız gerekecekti.
    // Yani her bir modele fetchlemek için ayrı ayrı fonksiyonlar yazmamız gerekecekti.
    // Generics(<>) yapısı kullanarak bunu TEK FONKSIYONA indirgeyebiliriz.
    // Genericsin DEZAVANTAJI olarak şunu söyleyebiliriz ---> Projeye complexity katar!
    
}


class APICaller {
    static let shared = APICaller()
    
    // Using generics!
    public func performAPICALL<T: Codable>(url: String, expectingReturnType: T.Type, completion: @escaping ((Result<T, Error>) -> Void)) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            var decodedResult: T?
            do {
                decodedResult = try JSONDecoder().decode(T.self, from: data)
            } catch {
                decodedResult = nil
                print("error is \(error)")
            }
            
            guard let result = decodedResult else {
                // call failure case
                return
            }
            
            completion(.success(result))
        }
        
        task.resume()
    }
    
    /*
    public func getFruits() {
        let task = URLSession.shared.dataTask(with: URL(string: "foo")!) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            let fruit: Fruit?
            
            do {
                fruit = try JSONDecoder().decode(Fruit.self,
                                                 from: data)
            } catch {
                fruit = nil
                print(error)
            }
        }
     
        task.resume()
    }
    
    public func getCar() {
        let task = URLSession.shared.dataTask(with: URL(string: "foo")!) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            let car: Car?
            
            do {
                car = try JSONDecoder().decode(Car.self,
                                               from: data)
            } catch {
                car = nil
                print(error)
            }
        }
        
        task.resume()
    }
    */
}

