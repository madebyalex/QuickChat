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
    
    var messages: [Message] = []
    
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
        
        loadMessages()
        
    }
    
    func loadMessages() {
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
                
            self.messages = []

            if let e = error {
                print("There was an issue retrieving data from Firestore. \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let message = Message(sender: messageSender, body: messageBody)
                            self.messages.append(message)
                            
                            
                            // Retrieve existing messages in the main thread
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField: messageSender, K.FStore.bodyField: messageBody, K.FStore.dateField: Date().timeIntervalSince1970]) {(error) in
                if let e = error {
                    print("There was an issue saving data to Firestore, \(e)")
                } else {
                    print("Successfully saved data")
                    
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
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
        
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        cell.messageLabel.text = message.body
        
        // This is a message from the current user
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.leftArrow.isHidden = true
            cell.rightArrow.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.primary)
            cell.messageLabel.textColor = .white
        }
        
        // This is a message from another user
        else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.leftArrow.isHidden = false
            cell.rightArrow.isHidden = true
            cell.messageBubble.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.7529411765, blue: 0.1764705882, alpha: 0.2)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.dark)
        }
        
        
        
        return cell
    }

}

