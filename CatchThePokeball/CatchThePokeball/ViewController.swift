//
//  ViewController.swift
//  CatchThePokeball
//
//  Created by Furkan Bingöl on 24.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var imageView9: UIImageView!
    @IBOutlet weak var imageView10: UIImageView!
    @IBOutlet weak var imageView11: UIImageView!
    @IBOutlet weak var imageView12: UIImageView!
    
    
    var imageArray = [UIImageView]()
    var selected : UIImageView?
    
    var counter = 10
    var score = 0
    var highscore = 0
    var timer = Timer()
    var hideTimer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Gradient Background
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.yellow.cgColor, UIColor.orange.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        
        timeLabel.text = "Time: \(counter)"
        scoreLabel.text = "Score: \(score)"
        
        for i in 1...12{
            let iv = self.value(forKey: "imageView\(i)") as! UIImageView   //casting
            imageArray.append(iv)
            imageArray[i-1].isUserInteractionEnabled = true
            imageArray[i-1].isHidden = true
        }
        
        //initialize GestureRecognizers
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(addScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(addScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(addScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(addScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(addScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(addScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(addScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(addScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(addScore))
        let recognizer10 = UITapGestureRecognizer(target: self, action: #selector(addScore))
        let recognizer11 = UITapGestureRecognizer(target: self, action: #selector(addScore))
        let recognizer12 = UITapGestureRecognizer(target: self, action: #selector(addScore))
        
        imageArray[0].addGestureRecognizer(recognizer1)
        imageArray[1].addGestureRecognizer(recognizer2)
        imageArray[2].addGestureRecognizer(recognizer3)
        imageArray[3].addGestureRecognizer(recognizer4)
        imageArray[4].addGestureRecognizer(recognizer5)
        imageArray[5].addGestureRecognizer(recognizer6)
        imageArray[6].addGestureRecognizer(recognizer7)
        imageArray[7].addGestureRecognizer(recognizer8)
        imageArray[8].addGestureRecognizer(recognizer9)
        imageArray[9].addGestureRecognizer(recognizer10)
        imageArray[10].addGestureRecognizer(recognizer11)
        imageArray[11].addGestureRecognizer(recognizer12)
        
        //Highscore Check
        let highestScore = UserDefaults.standard.object(forKey: "highest")
      
        if let hS = highestScore as? Int {
            highscore = hS
            highscoreLabel.text = "Highscore: \(highscore)"
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(game), userInfo: nil, repeats: true)
    }
    
    
    @objc func countdown() {
        counter -= 1
        timeLabel.text = "Time: \(counter)"
        
        if(counter < 0){
            timer.invalidate()
            hideTimer.invalidate()
            timeLabel.text = "Time is over!"
            
            for i in 1...12{
                imageArray[i-1].isUserInteractionEnabled = false
                imageArray[i-1].isHidden = true
            }
            
            //Save highscore (UserDefaults)
            if(score > highscore){
                highscore = score
                highscoreLabel.text = "Highscore: \(highscore)"
                UserDefaults.standard.set(highscore, forKey: "highest")
            }
            
            //Alert
            let alert = UIAlertController(title: "Time is Over!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let yesButton = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) { UIAlertAction in
                //replay
                
                self.score = 0    //self. dememizin sebebi --> bu blok içinde 'local bir score' degiskeni olusturma ihtimalimiz oldugu icin
                self.counter = 10
                self.timeLabel.text = "Time: \(self.counter)"
                self.scoreLabel.text = "Score: \(self.score)"
                
                for i in 1...12{
                    self.imageArray[i-1].isUserInteractionEnabled = true
                    self.imageArray[i-1].isHidden = true
                }
                //timer'ları tekrar çalıştırıyoruz
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(self.game), userInfo: nil, repeats: true)
            }
            let noButton = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel)
            alert.addAction(yesButton)
            alert.addAction(noButton)
            self.present(alert, animated: true)
        }
    }
    
    
    //game progress
    @objc func game() {
        selected?.isHidden = true
        imageArray.shuffle()       //for random select
        selected = imageArray[0]
        selected?.isHidden = false
    }
    
    
    //score increase when clicked selected image
    @objc func addScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }

}

