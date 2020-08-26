//
//  ChatVC.swift
//  QuickChat
//
//  Created by Alexander on 24.08.2020.
//  Copyright © 2020 Alexander Nuzhnyi. All rights reserved.
//

import UIKit
import Firebase

class ChatVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages: [Message] = [Message(sender: "office@google.com", body: "Hi there!"), Message(sender: "hello@alexander.works", body: "Hello, how are you doing?"), Message(sender: "office@google.com", body: "All is good. And you? 😉")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
//        tableView.delegate = self
        self.navigationItem.title = K.appName
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let messagePlaceholder = messageTextField.placeholder ?? ""
        
        let placeholderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6413473887)
        
        messageTextField.attributedPlaceholder = NSAttributedString(string: messagePlaceholder, attributes: [NSAttributedString.Key.foregroundColor : placeholderColor])
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}

extension ChatVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = messages[indexPath.row].body
        
        return cell
    }

}

//extension ChatVC: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//    }
//}

