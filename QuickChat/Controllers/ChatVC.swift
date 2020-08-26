//
//  ChatVC.swift
//  QuickChat
//
//  Created by Alexander on 24.08.2020.
//  Copyright © 2020 Alexander Nuzhnyi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore


class ChatVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = [Message(sender: "office@google.com", body: "Hi there!"), Message(sender: "hello@alexander.works", body: "Hello, how are you doing?"), Message(sender: "office@google.com", body: "All is good. And you? 😉")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        self.navigationItem.title = K.appName
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        
        // Customizing the Search field
//        let transpColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
//        messageTextField.layer.borderColor = (transpColor as! CGColor)
        
        messageTextField.layer.cornerRadius = 0
        messageTextField.layer.borderWidth = 0.0
        
        let messagePlaceholder = messageTextField.placeholder ?? ""
        let placeholderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6413473887)
        
        messageTextField.attributedPlaceholder = NSAttributedString(string: messagePlaceholder, attributes: [NSAttributedString.Key.foregroundColor : placeholderColor])
        
        // Registering the message nib
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
    }
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField: messageSender, K.FStore.bodyField: messageBody]) {(error) in
                if let e = error {
                    print("There was an issue saving data to Firestore, \(e)")
                } else {
                    print("Successfully saved data")
                }
            }
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        cell.messageLabel.text = messages[indexPath.row].body
        
        return cell
    }

}

