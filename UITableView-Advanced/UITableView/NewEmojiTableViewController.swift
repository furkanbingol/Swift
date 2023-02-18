//
//  NewEmojiTableViewController.swift
//  UITableView
//
//  Created by Furkan Bingöl on 18.02.2023.
//

import UIKit

class NewEmojiTableViewController: UITableViewController {
    
    // MARK: - UI Elements
    @IBOutlet weak var symbolLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextField!
    @IBOutlet weak var usageLabel: UITextField!
    
    var newEmoji: Emoji?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let emoji = newEmoji {
            symbolLabel.text = emoji.symbol
            nameLabel.text = emoji.name
            descriptionLabel.text = emoji.description
            usageLabel.text = emoji.usage
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Yalnızca 'saveUnwind' ise çalışmaya devam etmeli.
        guard segue.identifier == "saveUnwind" else { return }
        
        // Kullanıcının girdiği bilgileri newEmoji nesnesinde topladık.
        if let symbol = symbolLabel.text, let name = nameLabel.text, let desc = descriptionLabel.text, let usage = usageLabel.text {
            newEmoji = Emoji(symbol: symbol, name: name, description: desc, usage: usage)
        }
    }
    
}
