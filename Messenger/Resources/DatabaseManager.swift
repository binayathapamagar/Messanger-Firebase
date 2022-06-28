//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Binaya on 28/06/2022.
//

import Foundation
import FirebaseDatabase

// Creating a final class because we do not want this singleton class to be subclassed.
final class DatabaseManager {
    
    // MARK: - Singleton
    static let shared = DatabaseManager()
    
    // MARK: - Properties
    private let database = Database.database().reference() //Only this singleton class will have reference to the database.
    
}

// MARK: - DatabaseManager extension
extension DatabaseManager {
    
    // MARK: - Methods
    // NOTE: NOSQL db works using JSON. The child of the database refers a key of the key-value pair.

    /// Ensures that the email is unique in the Firebase Realtime database.
    /// Returns false if user's email does not exist in the database and false if otherwise.
    /// Note: It has a completion handler as the database method is asynchronous.
    public func isEmailUnique(with email: String, completion: @escaping ((Bool) -> Void)) {
         
    }
    
    /// Creates a new user in the Firebase Realtime database with the ChatAppUser object.
    public func createUser(with user: ChatAppUser) {
        //Email is unique.
        database.child(user.email).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
    
}
