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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        introLabel.text = ""
        
        let introText = K.welcomeMessage
        var charIndex = 1
        
        for letter in introText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * Double(charIndex), repeats: false) { (timer) in
                self.introLabel.text?.append(letter)
            }
            
            charIndex += 1
        }
    }
    
}

