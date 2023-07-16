//
//  ViewController.swift
//  P02-GameGallery
//
//  Created by Furkan Bingöl on 24.01.2023.
//

/*
 protocol 'stubs' == protocol 'functions'
 UITableViewDelegate and UITableViewDataSource --> Protocol
 UIViewController --> Class
*/

import UIKit

//inheritance
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var games = [String]()
    var gamesImages = [UIImage]()
    var gamesType = [String]()
    var gamesDetail = [String]()
    
    var chosenGame = ""
    var chosenGameImage = UIImage()
    var chosenGameDetail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Background
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bg1")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        for i in 1...8{
            var game = ""
            var gameImage = ""
            var gameType = ""
            var gameDetail = ""
            switch i {
                case 1:
                    game = "Call of Duty"
                    gameImage = "callofduty.png"
                    gameType = "FPS"
                    gameDetail = "Call of Duty is a first-person shooter video game franchise published by Activision. Starting out in 2003, it first focused on games set in World War II. Over time, the series has seen games set in the midst of the Cold War, futuristic worlds, and the modern day. The games were first developed by Infinity Ward, then also by Treyarch and Sledgehammer Games. Several spin-off and handheld games were made by other developers. The most recent title, Call of Duty: Modern Warfare II, was released on October 28, 2022."
                case 2:
                    game = "Elden Ring"
                    gameImage = "eldenring.png"
                    gameType = "RPG"
                    gameDetail = "Elden Ring is a 2022 action role-playing game developed by FromSoftware and published by Bandai Namco Entertainment. Directed by Hidetaka Miyazaki with worldbuilding provided by fantasy writer George R. R. Martin, it was released for PlayStation 4, PlayStation 5, Windows, Xbox One, and Xbox Series X/S on February 25. In the game, players control a customizable player character on a journey to repair the titular Elden Ring and become the new Elden Lord. Elden Ring is presented through a third-person perspective, with players freely roaming its interactive open world."
                case 3:
                    game = "God of War"
                    gameImage = "godofwar.png"
                    gameType = "Action-Adventure"
                    gameDetail = "God of War is an action-adventure game franchise created by David Jaffe at Sony's Santa Monica Studio. It began in 2005 on the PlayStation 2 (PS2) video game console and has become a flagship series for PlayStation, consisting of nine installments across multiple platforms. Based on ancient mythologies, the story follows Kratos, a Spartan warrior and later the Greek God of War, who was tricked into killing his family by his former master, the original Greek God of War Ares. This sets off a series of events that leads to wars with the different mythological pantheons."
                case 4:
                    game = "Gta 5"
                    gameImage = "gta5.png"
                    gameType = "Action-Adventure"
                    gameDetail = "Grand Theft Auto V is a 2013 action-adventure game developed by Rockstar North and published by Rockstar Games. It is the seventh main entry in the Grand Theft Auto series, following 2008's Grand Theft Auto IV, and the fifteenth instalment overall. Set within the fictional state of San Andreas, based on Southern California, the single-player story follows three protagonists—retired bank robber Michael De Santa, street gangster Franklin Clinton, and drug dealer and gunrunner Trevor Philips—and their attempts to commit heists while under pressure from a corrupt government agency and powerful criminals."
                case 5:
                    game = "Red Dead Redemption 2"
                    gameImage = "rdr2.png"
                    gameType = "Action-Adventure"
                    gameDetail = "Red Dead Redemption 2 is a 2018 action-adventure game developed and published by Rockstar Games. The game is the third entry in the Red Dead series and a prequel to the 2010 game Red Dead Redemption. The story is set in a fictionalized representation of the United States in 1899 and follows the exploits of outlaw Arthur Morgan, a member of the Van der Linde gang, who must deal with the decline of the Wild West whilst attempting to survive against government forces, rival gangs, and other adversaries. The game is presented through first- and third-person perspectives."
                case 6:
                    game = "Skyrim"
                    gameImage = "skyrim.png"
                    gameType = "RPG"
                    gameDetail = "The Elder Scrolls V: Skyrim is an action role-playing video game developed by Bethesda Game Studios and published by Bethesda Softworks. It is the fifth main installment in The Elder Scrolls series, following 2006's The Elder Scrolls IV: Oblivion, and was released worldwide for Microsoft Windows, PlayStation 3, and Xbox 360 on November 11, 2011. The game is set 200 years after the events of Oblivion, and takes place in Skyrim, the northernmost province of Tamriel."
                case 7:
                    game = "The Last of Us"
                    gameImage = "thelastofus.png"
                    gameType = "Action-Adventure"
                    gameDetail = "The Last of Us is a 2013 action-adventure game developed by Naughty Dog and published by Sony Computer Entertainment. Players control Joel, a smuggler tasked with escorting a teenage girl, Ellie, across a post-apocalyptic United States. The Last of Us is played from a third-person perspective. Players use firearms and improvised weapons and can use stealth to defend against hostile humans and cannibalistic creatures infected by a mutated fungus in the genus Cordyceps. In the online multiplayer mode, up to eight players engage in cooperative and competitive gameplay."
                case 8:
                    game = "Witcher 3"
                    gameImage = "witcher3.png"
                    gameType = "RPG"
                    gameDetail = "The Witcher 3: Wild Hunt is a 2015 action role-playing game developed and published by CD Projekt. It is the sequel to the 2011 game The Witcher 2: Assassins of Kings and the third game in The Witcher video game series, played in an open world with a third-person perspective. The games follow The Witcher series of fantasy novels written by Andrzej Sapkowski. The game takes place in a fictional fantasy world based on Slavic mythology. Players control Geralt of Rivia, a monster slayer for hire known as a Witcher, and search for his adopted daughter."
                default:
                    print("Error!")
            }
            games.append(game)
            gamesImages.append(UIImage(named: gameImage)!)
            gamesType.append(gameType)
            gamesDetail.append(gameDetail)
        }
        
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count   //number of rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
        --- KULLANIM ---
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()   //içerik ayarlayıcısı
        content.text = "TableView"
        content.secondaryText = "Test"
        cell.contentConfiguration = content
        */
        
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = games[indexPath.row]                 //indexPath.row --> O dizi(games), hangi sırada ise(index), TableView o sıra ile görüntü gösterir.
        content.secondaryText = gamesType[indexPath.row]
        content.textProperties.font = UIFont.systemFont(ofSize: 22)  //yazı fontunu 22 yapar
        
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenGame = games[indexPath.row]
        chosenGameImage = gamesImages[indexPath.row]
        chosenGameDetail = gamesDetail[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80   //cell'ler arası mesafeyi ayarlar
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){    //kullanıcı cell silecekse
            self.games.remove(at: indexPath.row)
            self.gamesImages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    //Diğer Segue'ye GEÇMEDEN ÖNCE yapılacaklar
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toDetailsVC") {
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.selectedGame = chosenGame
            destinationVC.selectedGameImage = chosenGameImage
            destinationVC.selectedGameDetail = chosenGameDetail
        }
    }

}

