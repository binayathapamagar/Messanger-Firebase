//
//  LoginViewController.swift
//  Messenger
//
//  Created by Binaya on 20/06/2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    // MARK: - Properties
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "messenger")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Email"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Password"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    // MARK: - @IBOutlets
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Login"
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
            
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width / 5
        logoImageView.frame = CGRect(x: (scrollView.width - size) / 2, y: 20, width: size, height: size)
        emailTextField.frame = CGRect(x: 30, y: logoImageView.bottom + 25, width: scrollView.width - 60, height: 52)
        passwordTextField.frame = CGRect(x: 30, y: emailTextField.bottom + 15 , width: scrollView.width - 60, height: 52)
        loginButton.frame = CGRect(x: 30, y: passwordTextField.bottom + 20, width: scrollView.width - 60, height: 50)
    }

    // MARK: - Methods
    private func setup() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        //Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(logoImageView)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(loginButton)
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(registerBarButtonTapped))
    }
    
    @objc private func registerBarButtonTapped() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    @objc private func loginButtonTapped() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        guard let email = emailTextField.text, let password = passwordTextField.text, !email.isEmpty, !password.isEmpty, email.isValidEmail, password.count >= 6 else {
             showErrorAlert(with: "Error", and: "Please fill the textfields with valid information to login.")
            return
        }
        // Firebase login
        print("Firebase login!")
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] authDataResult, error in
            guard let authDataResult = authDataResult, error == nil else {
                self?.showErrorAlert(with: "Login Error", and: "Error logging the user in.")
                return
            }
            print("Login success with the new user: \(authDataResult.user)")
        }
    }
    
}

// MARK: - UITextFieldDelegate extension
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            loginButtonTapped()
        }
         return true
    }
    
}
