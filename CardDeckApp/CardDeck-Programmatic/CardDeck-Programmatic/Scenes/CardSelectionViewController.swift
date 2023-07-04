//
//  CardSelectionViewController.swift
//  CardDeck-Programmatic
//
//  Created by Furkan Bingöl on 4.07.2023.
//

import UIKit

final class CardSelectionViewController: UIViewController {

    private let cardImageView = UIImageView()
    private let stopButton = CDButton(backgroundColor: .systemRed, title: "Stop!", systemImageName: "stop.circle")
    private let resetButton = CDButton(backgroundColor: .systemGreen, title: "Reset", systemImageName: "arrow.clockwise.circle")
    private let rulesButton = CDButton(backgroundColor: .systemBlue, title: "Rules", systemImageName: "list.bullet")
    
    private let cardDeck: [UIImage] = Deck.allCards
    private var timer = Timer()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        startTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    
    // MARK: - Functions
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.2,
                                     target: self,
                                     selector: #selector(showRandomCard),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureCardImageView()
        configureStopButton()
        configureResetButton()
        configureRulesButton()
    }
    
    
    private func configureCardImageView() {
        view.addSubview(cardImageView)
        cardImageView.translatesAutoresizingMaskIntoConstraints = false    // tamic = false --> use AUTOLAYOUT
        cardImageView.image = UIImage(named: "AS")
        
        // Programatic constraints
        NSLayoutConstraint.activate([
            cardImageView.widthAnchor.constraint(equalToConstant: 250),
            cardImageView.heightAnchor.constraint(equalToConstant: 350),
            cardImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100)
        ])
    }
    
    private func configureStopButton() {
        view.addSubview(stopButton)
        stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            stopButton.widthAnchor.constraint(equalToConstant: 260),
            stopButton.heightAnchor.constraint(equalToConstant: 50),
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 30)
        ])
    }
    
    private func configureResetButton() {
        view.addSubview(resetButton)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            resetButton.widthAnchor.constraint(equalToConstant: 115),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            resetButton.leadingAnchor.constraint(equalTo: stopButton.leadingAnchor),
            resetButton.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: 20)
        ])
    }
    
    private func configureRulesButton() {
        view.addSubview(rulesButton)
        rulesButton.addTarget(self, action: #selector(presentRulesVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            rulesButton.widthAnchor.constraint(equalToConstant: 115),
            rulesButton.heightAnchor.constraint(equalToConstant: 50),
            rulesButton.trailingAnchor.constraint(equalTo: stopButton.trailingAnchor),
            rulesButton.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: 20)
        ])
    }
    
    
    // MARK: - Actions
    @objc private func presentRulesVC() {
        present(RulesViewController(), animated: true)
    }
    
    @objc private func stopButtonTapped() {
        timer.invalidate()
    }
    
    @objc private func resetButtonTapped() {
        timer.invalidate()
        startTimer()
    }
    
    @objc private func showRandomCard() {
        cardImageView.image = cardDeck.randomElement()
    }
    
}
