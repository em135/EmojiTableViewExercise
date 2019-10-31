//
//  ViewController.swift
//  TableViewExercise
//
//  Created by Emil Nielsen on 31/10/2019.
//  Copyright © 2019 Emil Nielsen. All rights reserved.
//

import UIKit

class EmojiViewController: UIViewController {

    private var emojiManager: EmojiManager!
    private var emojies: [Emoji]!

    @IBOutlet weak var emojiTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        emojiManager = EmojiManager()
        emojiManager.createEmojies()
        emojies = emojiManager.emojies
        
        // The table view does not own its data, it must get this data from a data source (EmojiViewController)
        emojiTableView.dataSource = self
        
        // The table view must be able to notify the EmojiViewController that something happened, e.g. a cell was selected
        emojiTableView.delegate = self
    }
}

extension EmojiViewController: UITableViewDataSource {
    // Determines how many rows the table view should contain
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojies.count
    }

    // Configure the cell that will be shown at a particular location in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let emoji = emojies[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        cell.emojiLabel.text = emoji.title
        cell.titleLabel.text = emoji.description
        return cell
    }
}

extension EmojiViewController: UITableViewDelegate {
    // This function gets executed when a cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let emoji = emojies[indexPath.item]
        let alert = UIAlertController(title: emoji.title, message: emoji.description, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
