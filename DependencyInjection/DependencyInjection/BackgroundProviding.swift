//
//  BackgroundProviding.swift
//  DependencyInjection
//
//  Created by Furkan Bingöl on 14.07.2023.
//

import UIKit

// BackgroundProviding: Class
// BackgroundProvider: Protocol
class BackgroundProviding: BackgroundProvider {
    
    var backgroundColor: UIColor {    // Computed Property
        let backgroundColors: [UIColor] = [.systemGroupedBackground,
                                           .systemGray,
                                           .systemMint,
                                           .systemRed,
                                           .systemBlue,
                                           .systemYellow,
                                           .systemGreen]
        return backgroundColors.randomElement()!
    }
    
}
