//
//  RulesViewController.swift
//  CardDeck-Programmatic
//
//  Created by Furkan Bingöl on 4.07.2023.
//

import UIKit

final class RulesViewController: UIViewController {

    private let titleLabel = UILabel()
    private let rulesLabel = UILabel()
    private let exerciseLabel = UILabel()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTitleLabel()
        configureRulesLabel()
        configureExerciseLabel()
    }
    
    
    // MARK: - Functions
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Rules"
        titleLabel.font = .systemFont(ofSize: 40, weight: .bold)
        titleLabel.textAlignment = .center
        
        // Label oldugu icin height constraintine gerek yok. Kendisi hesaplıyor.
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }

    private func configureRulesLabel() {
        view.addSubview(rulesLabel)
        rulesLabel.translatesAutoresizingMaskIntoConstraints = false
        rulesLabel.text = "The value of each card represents the number of exercise you do.\n\nJ = 11, Q = 12, K = 13, A = 14"
        rulesLabel.font = .systemFont(ofSize: 19, weight: .semibold)
        rulesLabel.textAlignment = .center
        rulesLabel.numberOfLines = 0
        rulesLabel.lineBreakMode = .byWordWrapping
        
        // Label oldugu icin height constraintine gerek yok. Kendisi hesaplıyor.
        NSLayoutConstraint.activate([
            rulesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            rulesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            rulesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    private func configureExerciseLabel() {
        view.addSubview(exerciseLabel)
        exerciseLabel.translatesAutoresizingMaskIntoConstraints = false
        exerciseLabel.text = """
            ♠️ = Push-ups
        
            ♥️ = Sit-up
        
            ♣️ = Burpees
        
            ♦️ = Jumping Jacks
        """
        exerciseLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        exerciseLabel.numberOfLines = 0
        
        // Label oldugu icin height constraintine gerek yok. Kendisi hesaplıyor.
        NSLayoutConstraint.activate([
            exerciseLabel.topAnchor.constraint(equalTo: rulesLabel.bottomAnchor, constant: 50),
            exerciseLabel.widthAnchor.constraint(equalToConstant: 250),
            exerciseLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}
