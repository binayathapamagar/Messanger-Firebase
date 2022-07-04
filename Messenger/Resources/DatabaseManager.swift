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
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
         //Firebase database allows us to observe value changes on any entry in our NoSQL db by specifying the child that we want to observe for and the type of observation that we want. We only want to observe a single event for this method which is to query the database once.
        database.child(safeEmail).observeSingleEvent(of: .value) { snapshot in
            guard (snapshot.value as? String) != nil else {
                completion(false)
                return
            }
            completion(true) //Returning true since the email already exists.
        }
    }
    
    /// Creates a new user in the Firebase Realtime database with the ChatAppUser object.
    public func createUser(with user: ChatAppUser) {
        //Email has to be unique.
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
    
}
