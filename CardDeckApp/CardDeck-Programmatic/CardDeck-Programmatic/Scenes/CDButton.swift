//
//  CDButton.swift
//  CardDeck-Programmatic
//
//  Created by Furkan Bingöl on 4.07.2023.
//

import UIKit

final class CDButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Custom init
    init(backgroundColor: UIColor, title: String, systemImageName: String) {
        super.init(frame: .zero)
        
        configuration = .tinted()
        configuration?.title = title
        configuration?.baseForegroundColor = backgroundColor
        configuration?.baseBackgroundColor = backgroundColor
        configuration?.cornerStyle = .medium
        configuration?.image = UIImage(systemName: systemImageName)
        configuration?.imagePadding = 5
        translatesAutoresizingMaskIntoConstraints = false
        
        // self.backgroundColor = backgroundColor
        // setTitle(title, for: .normal)
        // configure()
    }
    
    
    private func configure() {
        layer.cornerRadius = 8
        titleLabel?.font = .systemFont(ofSize: 19, weight: .bold)
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false     // tamic = false --> USE AUTOLAYOUT(Programatically)
    }
    
}
