//
//  ViewController.swift
//  Timer
//
//  Created by Furkan Bingöl on 23.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    var timer = Timer()
    var counter = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.text = "Time: \(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(myTimerFunc), userInfo: nil, repeats: true)
                                              //1 sn                           @objc fonksiyonu
    }

    @objc func myTimerFunc() {
        counter -= 1
        timeLabel.text = "Time: \(counter)"
        
        if (counter < 0){
            timer.invalidate()     //timer'ı sonlandırır
            timeLabel.text = "Time's over!"
        }
    }
    
    @IBAction func buttonClick(_ sender: Any) {
        print("Button clicked")
    }
    
}

