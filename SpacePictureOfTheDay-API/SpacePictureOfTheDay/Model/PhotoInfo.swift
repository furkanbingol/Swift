//
//  PhotoInfo.swift
//  SpacePictureOfTheDay
//
//  Created by Furkan Bingöl on 7.03.2023.
//

import Foundation

struct PhotoInfo: Codable {
    var title: String
    var description: String
    var url: URL
    var copyright: String?
    
    // Hazır bir enum - Eğer tanımlamış olduğumuz değişkenlerin isimleri, JSON'daki key'lerden farklı ise,
    // o zaman CodingKeys enum'ını tanımlayarak her bir değişkenimizin JSON karşılığındaki adını belirtmemiz gerekiyor.
    enum CodingKeys: String, CodingKey {
        case title = "title"      // sağ tarafındaki kısım, JSON karşılığı olacak.
        case description = "explanation"
        case url = "url"
        case copyright = "copyright"
    }
}
