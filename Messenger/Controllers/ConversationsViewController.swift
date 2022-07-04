//
//  ViewController.swift
//  Messenger
//
//  Created by Binaya on 20/06/2022.
//

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - @IBOutlets
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateUserLoggedInStatus()
    }
    

    // MARK: - Methods
    private func setup() {
        
    }
    
    private func validateUserLoggedInStatus() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            // Send to login page.
            let loginViewController = LoginViewController()
            let navigationController = UINavigationController(rootViewController: loginViewController)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: false )
        } 
    }

}

