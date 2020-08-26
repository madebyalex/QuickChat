//
//  Constants.swift
//  QuickChat
//
//  Created by Alexander on 25.08.2020.
//  Copyright © 2020 Alexander Nuzhnyi. All rights reserved.
//

struct K {
    static let appName = "⚡️ QuickChat"
    static let welcomeMessage = "Welcome to"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSeque = "RegisterToChat"
    static let loginSeque = "LoginToChat"
    
    struct BrandColors {
        static let primary = "Primary"
        static let primaryLightest = "PrimaryLightest"
        static let dark = "Dark"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
