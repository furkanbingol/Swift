//
//  ViewController.swift
//  MusicAnimation
//
//  Created by Furkan Bingöl on 5.03.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var musicNameLabel: UILabel!
    @IBOutlet weak var musicArtistLabel: UILabel!
    @IBOutlet weak var reverseBackgroundView: UIView!
    @IBOutlet weak var playPauseBackgroundView: UIView!
    @IBOutlet weak var forwardBackgroundView: UIView!
    
    @IBOutlet weak var reverseButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    @IBOutlet weak var sliderBar: UISlider!
    
    
    // MARK: - Properties
    var musics = [Music]()
    
    var selectedMusicIndex = 0
    
    // Müziğin çalma durumu
    var isPlaying: Bool = false {
        didSet {
            if isPlaying {
                playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
            } else {
                playPauseButton.setImage(UIImage(named: "play"), for: .normal)
            }
        }
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillMusics()
        firstAppearance()
    }
    
    
    // MARK: - Functions
    
    func fillMusics() {
        musics = [
            Music(name: "Bir Derdim Var", artist: "mor ve ötesi", image: UIImage(named: "01.png")!),
            Music(name: "Dibine Kadar", artist: "Duman", image: UIImage(named: "02.png")!),
            Music(name: "Sen Ağlama", artist: "Badem", image: UIImage(named: "03.png")!),
            Music(name: "Islak Islak", artist: "Barış Akarsu", image: UIImage(named: "04.png")!),
            Music(name: "NKBİ", artist: "Güneş", image: UIImage(named: "05.png")!),
            Music(name: "Deli", artist: "mor ve ötesi", image: UIImage(named: "06.png")!),
            Music(name: "Sarılırım Birine", artist: "Adamlar", image: UIImage(named: "07.png")!),
            Music(name: "Sakince Yoruldum", artist: "Kendimden Hallice", image: UIImage(named: "08.png")!)
        ]
        
        // Bu işlemden önce, Project Targets'dan Bundle'a eklenecek dosyaları ekledim.
        guard let url1 = Bundle.main.url(forResource: "bir_derdim_var", withExtension: "mp3"),
              let url2 = Bundle.main.url(forResource: "dibine_kadar", withExtension: "mp3"),
              let url3 = Bundle.main.url(forResource: "sen_aglama", withExtension: "mp3"),
              let url4 = Bundle.main.url(forResource: "islak_islak", withExtension: "mp3"),
              let url5 = Bundle.main.url(forResource: "nkbi", withExtension: "mp3"),
              let url6 = Bundle.main.url(forResource: "deli", withExtension: "mp3"),
              let url7 = Bundle.main.url(forResource: "sarilirim_birine", withExtension: "mp3"),
              let url8 = Bundle.main.url(forResource: "sakince_yoruldum", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            musics[0].sound = try AVAudioPlayer(contentsOf: url1, fileTypeHint: AVFileType.mp3.rawValue)
            musics[1].sound = try AVAudioPlayer(contentsOf: url2, fileTypeHint: AVFileType.mp3.rawValue)
            musics[2].sound = try AVAudioPlayer(contentsOf: url3, fileTypeHint: AVFileType.mp3.rawValue)
            musics[3].sound = try AVAudioPlayer(contentsOf: url4, fileTypeHint: AVFileType.mp3.rawValue)
            musics[4].sound = try AVAudioPlayer(contentsOf: url5, fileTypeHint: AVFileType.mp3.rawValue)
            musics[5].sound = try AVAudioPlayer(contentsOf: url6, fileTypeHint: AVFileType.mp3.rawValue)
            musics[6].sound = try AVAudioPlayer(contentsOf: url7, fileTypeHint: AVFileType.mp3.rawValue)
            musics[7].sound = try AVAudioPlayer(contentsOf: url8, fileTypeHint: AVFileType.mp3.rawValue)
            
        } catch {
            print("error")
        }
        
    }
    
    
    func firstAppearance() {
        imageView.image = musics[selectedMusicIndex].image
        musicNameLabel.text = musics[selectedMusicIndex].name
        musicArtistLabel.text = musics[selectedMusicIndex].artist
        
        reverseBackgroundView.layer.cornerRadius = 37.5
        reverseBackgroundView.clipsToBounds = true
        reverseBackgroundView.alpha = 0   // .isHidden yerine bunu da kullanabiliriz.
        
        playPauseBackgroundView.layer.cornerRadius = 37.5
        playPauseBackgroundView.clipsToBounds = true
        playPauseBackgroundView.alpha = 0
        
        forwardBackgroundView.layer.cornerRadius = 37.5
        forwardBackgroundView.clipsToBounds = true
        forwardBackgroundView.alpha = 0
                
        UIView.animate(withDuration: 0.2) {
            self.imageView.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }
    }
    
    
    func whichBackground(_ sender: UIButton) -> UIView {
        var background = UIView()
        
        switch sender {
        case reverseButton:
            background = reverseBackgroundView
        case playPauseButton:
            background = playPauseBackgroundView
        case forwardButton:
            background = forwardBackgroundView
        default:
            break
        }
        
        return background
    }
    
    
    // MARK: - Actions
    
    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
        
        if isPlaying {    // Müzik çalıyorken, bu butona tıklarsak..
            UIView.animate(withDuration: 0.5) {
                self.imageView.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)   // Boyutu %85'e düşür.
            }
            musics[selectedMusicIndex].sound.stop()
        } else {     // Müzik çalmıyorken, bu butona tıklarsak..
            UIView.animate(withDuration: 0.5) {
                self.imageView.transform = .identity   // ilk durumuna döndür, büyük haline.
            }
            musics[selectedMusicIndex].sound.play()
        }
        isPlaying = !isPlaying
    }
    
    
    @IBAction func touchDown(_ sender: UIButton) {   // Parmak ile tıkladığı an (parmak ekran üzerinde hala)
        let buttonBackgroundView = whichBackground(sender)
        
        UIView.animate(withDuration: 0.25) {
            buttonBackgroundView.alpha = 0.3     // Tıklanılan butonun background'ını biraz görünür hale getiriyoruz.
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)      // Butonun boyutunu %80'e küçülttük.
        }
        
    }
    
    
    @IBAction func touchUpInside(_ sender: UIButton) {     // Parmak içindeyken, kaldırdığım an
        let buttonBackgroundView = whichBackground(sender)
        
        UIView.animate(withDuration: 0.4) {
            buttonBackgroundView.alpha = 0
            buttonBackgroundView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)  // %20 büyüttük butonun arkaplanındaki view'ı
            sender.transform = .identity    // ilk durumuna döndür.
        } completion: { _ in
            buttonBackgroundView.transform = .identity
        }

        imageView.image = musics[selectedMusicIndex].image
        musicNameLabel.text = musics[selectedMusicIndex].name
        musicArtistLabel.text = musics[selectedMusicIndex].artist
    }
    
    @IBAction func reverseButtonTapped(_ sender: UIButton) {
        if isPlaying {
            musics[selectedMusicIndex].sound.pause()
        }
        musics[selectedMusicIndex].sound.currentTime = 0   // Bir önceki müzik
        
        if selectedMusicIndex == 0 {
            selectedMusicIndex = musics.count-1
        } else {
            selectedMusicIndex -= 1
        }
        
        if isPlaying {
            musics[selectedMusicIndex].sound.play()
        }
    }
    
    @IBAction func forwardButtonTapped(_ sender: UIButton) {
        if isPlaying {
            musics[selectedMusicIndex].sound.pause()
        }
        musics[selectedMusicIndex].sound.currentTime = 0   // Bir önceki müzik
        
        if selectedMusicIndex == musics.count-1 {
            selectedMusicIndex = 0
        } else {
            selectedMusicIndex += 1
        }
        
        if isPlaying {
            musics[selectedMusicIndex].sound.play()
        }
    }
    
    
    @IBAction func sliderBarChanged(_ sender: UISlider) {
        print(sliderBar.value)
    }
    
}

