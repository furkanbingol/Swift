//
//  main.swift
//  MusicianClass
//
//  Created by Furkan Bingöl on 26.01.2023.
//

import Foundation

let user = Musicians(name: "Furkan", age: 22, instrument: "Piano", type: .Pianist)
print(user.name)
print(user.type)
user.sing()

let user2 = SuperMusician(name: "xyz", age: 22, instrument: "Guitar", type: .LeadGuitar)
user2.sing()   //overrided method


/*
Access Modifiers(Levels)
------------------------
 #Yukarıdan aşağıya AÇIKLIK-ERİŞİM seviyesi artar!
 
 1) private       --> hangi sınıfta tanımlıysa, sadece o sınıfta kullanılır.
 2) fileprivate   --> dosya bazlı kullanım sağlar. Sınıftan ziyade, o dosyaya erişim izni verir.
 3) internal      --> DEFAULT access modifierdır.
 4) public
 5) open
*/
