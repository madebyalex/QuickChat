//
//  WelcomeVC.swift
//  QuickChat
//
//  Created by Alexander on 24.08.2020.
//  Copyright © 2020 Alexander Nuzhnyi. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {
    @IBOutlet weak var introLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        introLabel.text = ""
        
        let introText = "Welcome to"
        var charIndex = 1
        
        for letter in introText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * Double(charIndex), repeats: false) { (timer) in
                self.introLabel.text?.append(letter)
            }
            
            charIndex += 1
        }
    }
    
}

