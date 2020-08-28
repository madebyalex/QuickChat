//
//  MessageCell.swift
//  QuickChat
//
//  Created by Alexander on 26.08.2020.
//  Copyright © 2020 Alexander Nuzhnyi. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftArrow: UIImageView!
    @IBOutlet weak var rightArrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Separate corner radius for views
//        let path = UIBezierPath(roundedRect:messageBubble.bounds, byRoundingCorners:[.topLeft, .bottomLeft], cornerRadii: CGSize(width: 6, height: 6))
//        let maskLayer = CAShapeLayer()
//
//        maskLayer.path = path.cgPath
//        messageBubble.layer.mask = maskLayer
        
//        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 4
        messageBubble.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
