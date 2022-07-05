//
//  ProfileViewController.swift
//  Messenger
//
//  Created by Binaya on 20/06/2022.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    // MARK: - Properties
    let profileVCData = ["Log Out"]
    
    // MARK: - @IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Methods
    private func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "profileCell")
    }

}

// MARK: - UITableViewDataSource extension
extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileVCData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        cell.textLabel?.text = profileVCData[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        return cell
    }
    
}

// MARK: - UITableViewDelegate extension
extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        alertWithOKActionCancel(message: "Are you sure you want to log out?", title: "Log Out", style: .actionSheet, okTitle: "Logout", cancelTitle: "Cancel") { [weak self] in
            guard let strongSelf = self else {
                return
            }
            do {
                // Send to login page.
                try FirebaseAuth.Auth.auth().signOut()
                let loginViewController = LoginViewController()
                let navigationController = UINavigationController(rootViewController: loginViewController)
                navigationController.modalPresentationStyle = .fullScreen
                strongSelf.present(navigationController, animated: true)
            } catch {
                strongSelf.showErrorAlert(with: "Firebase Error!", and: "Error signing out the user.")
            }
        }
    }
    
}
