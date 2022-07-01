//
//  ChatAppUser.swift
//  Messenger
//
//  Created by Binaya on 28/06/2022.
//

import Foundation

struct ChatAppUser {
    
    let firstName: String
    let lastName: String
    let email: String
    var safeEmail: String {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
//    let profilePictureUrl: String
    
}
