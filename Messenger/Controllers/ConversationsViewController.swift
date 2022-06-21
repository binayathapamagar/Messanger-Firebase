//
//  ViewController.swift
//  Messenger
//
//  Created by Binaya on 20/06/2022.
//

import UIKit

class ConversationsViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - @IBOutlets
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkIfUserIsLoggedIn()
    }
    

    // MARK: - Methods
    private func setup() {
        
    }
    
    private func checkIfUserIsLoggedIn() {
        let userLoggedIn = UserDefaults.standard.bool(forKey: "userLoggedIn")
        if !userLoggedIn {
            // Send to login page.
            let loginViewController = LoginViewController()
            let navigationController = UINavigationController(rootViewController: loginViewController)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: false )
        }
    }

}

