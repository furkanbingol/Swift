//
//  CardSelectionViewController.swift
//  CardDeck-Storyboard
//
//  Created by Furkan Bingöl on 11.06.2023.
//

import UIKit

class CardSelectionViewController: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet var buttons: [UIButton]!      // IBOutlet 'Collection' (includes buttons)
    
    
    // MARK: - Properties
    var cards = Deck.allCards
    var timer = Timer()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addCornerRadius()
        
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    
    // MARK: - Functions
    private func addCornerRadius() {
        for button in buttons {
            button.layer.cornerRadius = 8
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.12,
                                     target: self,
                                     selector: #selector(showRandomImage),
                                     userInfo: nil,
                                     repeats: true)
        
    }
    
    @objc func showRandomImage() {
        guard let randomCard = cards.randomElement() else {
            cardImageView.image = UIImage(named: "AS")
            return
        }
        cardImageView.image = randomCard
    }
    
    
    
    // MARK: - Actions
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        timer.invalidate()
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        timer.invalidate()    // for previous timer
        startTimer()
    }
        
}

