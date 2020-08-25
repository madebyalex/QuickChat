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
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
