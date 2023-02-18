//
//  EmojiTableViewController.swift
//  UITableView
//
//  Created by Furkan Bingöl on 18.02.2023.
//

import UIKit

// VC'miz normal bir VC olsaydı, UITableViewDataSource && UITableViewDelegate protokollerini kabul etmeliydi.
// Fakat bizim kullandığımız View Controller zaten TableViewController. Zaten bu protokolleri conform ediyor. O yüzden gerek yok.
class EmojiTableViewController: UITableViewController {

    // MARK: - Properties
    var emojis: [Emoji] = [
        Emoji(symbol: "😀", name: "Grinning Face",
              description: "A typical smiley face.", usage: "happiness"),
        Emoji(symbol: "😕", name: "Confused Face",
              description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
        Emoji(symbol: "😍", name: "Heart Eyes",
              description: "A smiley face with hearts for eyes.",
              usage: "love of something; attractive"),
        Emoji(symbol: "👮", name: "Police Officer",
              description: "A police officer wearing a blue cap with a gold badge.",
              usage: "person of authority"),
        Emoji(symbol: "🐢", name: "Turtle",
              description: "A cute turtle.",
              usage: "Something slow"),
        Emoji(symbol: "🐘", name: "Elephant",
              description: "A gray elephant.",
              usage: "good memory"),
        Emoji(symbol: "🍝", name: "Spaghetti",
              description: "A plate of spaghetti.",
              usage: "spaghetti"),
        Emoji(symbol: "🎲", name: "Die",
              description: "A single die.",
              usage: "taking a risk, chance; game"),
        Emoji(symbol: "⛺️", name: "Tent",
              description: "A small tent.",
              usage: "camping"),
        Emoji(symbol: "📚", name: "Stack of Books",
              description: "Three colored books stacked on each other.",
              usage: "homework, studying"),
        Emoji(symbol: "💔", name: "Broken Heart",
              description: "A red, broken heart.",
              usage: "extreme sadness"),
        Emoji(symbol: "💤", name: "Snore",
              description: "Three blue \'z\'s.",
              usage: "tired, sleepiness"),
        Emoji(symbol: "🏁", name: "Checkered Flag",
              description: "A black-and-white checkered flag.",
              usage: "completion")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let editingMode = tableView.isEditing     // 'O an' TableView'ın edit modda olup olmadığı bilgisini verir. (true/false)
        
        tableView.setEditing(!editingMode, animated: true)   //TableView'ın editing moda girmesini ve çıkmasını sağlar.
    }
    

    // MARK: - Table view data source

    // Section Sayısı (Row'ları barındıran yapılara 'Section' denir. Bir tableView'da birden fazla Section olabilir.)
    override func numberOfSections(in tableView: UITableView) -> Int {
        // 1 section varsa bu fonksiyonu yazmak zorunda değiliz.
        // Çünkü: Varsayılan section sayısı zaten 1'dir.
        return 1
    }


    // Satır Sayısı
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Her section için 1 kez çalışıyor. Örneğin 4 section'a sahip bir tableView varsa, bu fonksiyon her section için
        // 1 kez olmak üzere toplam 4 kez çalışacaktır. 'section' parametresi, o an çizilmekte olan section bilgisini verir.
        
        return emojis.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Bir cell, ne zamanki ekrana gelecek; 'cellForRowAt' ile çizilir.
        // Bu fonksiyonun kaç kez çalışacağı belli değildir.
        // indexPath --> O an çizilmekte olan hücrenin konum bilgisi.
        let emoji = emojis[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath)      //init gibi fakat init kullanamayız. Çünkü her cell için memory'de yer açmak istemiyoruz. Gözükenler için yer açıyoruz. Bu yüzden -> 'dequeueReusableCell' kullanıyoruz.
        
        // Hücreyi, data ile doldurmak
        cell.textLabel?.text = "\(emoji.symbol) - \(emoji.name)"     //Title
        cell.detailTextLabel?.text = emoji.description               //Subtitle
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        
        return cell
    }
    
    // Cell'ler arası mesafeyi ayarlar
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    
    // MARK: - Table view delegate (optional)
    
    // Kullanıcı, bir hücreyi seçtiği zaman çalışan fonksiyon
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEmoji = emojis[indexPath.row]
        print("\(indexPath.row) --> \(selectedEmoji.symbol)")
    }
    
    
    // Kullanıcı, cell'leri kendi aralarında yer değiştirebilir. Değiştirdiği sırada çalışan fonksiyon.
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        // sourceIndexPath: Sırası değiştirilmek istenen hücrenin indexPath'i
        // destinationIndexPath: Gidilmesi istenilen konum
        
        // ÖNEMLİ: array sırası, tableView hücre sırası ile her zaman aynı kalması gerekir.
        let movedEmoji = emojis.remove(at: sourceIndexPath.row)   //hem siler, hem o elemanı döndürür.
        emojis.insert(movedEmoji, at: destinationIndexPath.row)
        
        // TableView reload etmemiz gerekli, yeniden çizim için
        tableView.reloadData()
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

}
