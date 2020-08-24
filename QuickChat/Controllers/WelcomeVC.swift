//
//  WelcomeVC.swift
//  QuickChat
//
//  Created by Alexander on 24.08.2020.
//  Copyright © 2020 Alexander Nuzhnyi. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeVC: UIViewController {
    @IBOutlet weak var mainLogo: UIImageView!
    @IBOutlet weak var introLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
//            self.mainLogo.fadeIn(2)
//        }
        
        introLabel.text = "Welcome to"
//        introLabel.charInterval = 0.15
//        introLabel.onTypingAnimationFinished = {
//            self.mainLogo.fadeIn(0.6)
//        }
    }
}

extension UIView {
  func fadeTo(_ alpha: CGFloat, duration: TimeInterval = 0.3) {
    DispatchQueue.main.async {
      UIView.animate(withDuration: duration) {
        self.alpha = alpha
      }
    }
  }

  func fadeIn(_ duration: TimeInterval = 0.3) {
    fadeTo(1.0, duration: duration)
  }

  func fadeOut(_ duration: TimeInterval = 0.3) {
    fadeTo(0.0, duration: duration)
  }
}

