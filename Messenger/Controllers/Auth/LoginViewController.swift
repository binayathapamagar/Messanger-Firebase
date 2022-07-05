//
//  LoginViewController.swift
//  Messenger
//
//  Created by Binaya on 20/06/2022.
//

import UIKit
import FirebaseAuth
//import FacebookLogin - This is what they tell us to import in the documentation(Not updated) but it is wrong as we have to import FBSDKLoginKit for xcworkspace projects.
import FBSDKLoginKit

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
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1.00)
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
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1.00)
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.27, green: 0.37, blue: 0.61, alpha: 1.00)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    private let facebookLoginButton: FBLoginButton = {
        let facebookLoginButton = FBLoginButton()
        //Setting up scopes/permissions to request to Facebook to get the user's email and profile details that has the first and last name.
        facebookLoginButton.permissions = ["email", "public_profile"]
        return facebookLoginButton
    }()
    
    // MARK: - @IBOutlets
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
            
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupSubviewsLayout()
    }

    // MARK: - Methods
    private func setup() {
        setupView()
        setupSubviews()
        setupTextFields()
        setupLoginButton()
        setupFacebookLoginButton()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemBlue
        ]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(registerBarButtonTapped))
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "Login"
    }
    
    private func setupSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(logoImageView)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(facebookLoginButton)
    }
    
    private func setupSubviewsLayout() {
        scrollView.frame = view.bounds
        let size = scrollView.width / 5
        logoImageView.frame = CGRect(x: (scrollView.width - size) / 2, y: 20, width: size, height: size)
        emailTextField.frame = CGRect(x: 30, y: logoImageView.bottom + 25, width: scrollView.width - 60, height: 52)
        passwordTextField.frame = CGRect(x: 30, y: emailTextField.bottom + 15 , width: scrollView.width - 60, height: 52)
        loginButton.frame = CGRect(x: 30, y: passwordTextField.bottom + 20, width: scrollView.width - 60, height: 50)
        facebookLoginButton.frame = CGRect(x: 30, y: loginButton.bottom + 20, width: scrollView.width - 60, height: 50)
    }
    
    private func setupTextFields() {
        [emailTextField, passwordTextField].forEach { textField in
            textField.delegate = self
            textField.textColor = .systemBackground
        }
    }
    
    private func setupLoginButton() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func setupFacebookLoginButton() {
        facebookLoginButton.delegate = self
    }
    
    @objc private func registerBarButtonTapped() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    @objc private func loginButtonTapped() {
        resignTextFieldFirstResponder()
        guard let email = emailTextField.text, let password = passwordTextField.text, !email.isEmpty, !password.isEmpty, email.isValidEmail, password.count >= 6 else {
             showErrorAlert(with: "Error", and: "Please fill the textfields with valid information to login.")
            return
        }
        // Firebase login
        print("Firebase login!")
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] authDataResult, error in
            guard let strongSelf = self else {
                print("Self is nil!")
                return
            }  
            guard let authDataResult = authDataResult, error == nil else {
                self?.showErrorAlert(with: "Login Error", and: "Error logging the user in.")
                return
            }
            print("Login success with the new user: \(authDataResult.user)")
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    private func resignTextFieldFirstResponder() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
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


// MARK: - LoginButtonDelegate extension (Facebook)
extension LoginViewController: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        guard let accessToken = result?.token?.tokenString else {
            showErrorAlert(with: "Facebook login error!", and: "Access token is nil.")
            return
        }
        //We need to trade this facebook login access token with Firebase to get a Firebase auth credential. Then, we need to use this auth credential to sign the user in Firebase. Note: We also have to handle the Multi-Factor authentication (MFA) as the fb user can have the MFA setup for their account. For example: Code texts, email, call, etc. If this is not handled, Firebase will not be able to log the user in via the auth credential as there is a second layer of security.
        let authCredential = FacebookAuthProvider.credential(withAccessToken: accessToken)
        FirebaseAuth.Auth.auth().signIn(with: authCredential) { [weak self] authDataResult, error in
            guard let strongSelf = self else {
                print("Self is nil!")
                return
            }
            guard authDataResult != nil, error == nil else {
                strongSelf.showErrorAlert(with: "Facebook login error!", and: "Error logging in using facebook. Multi-factor authentication may be needed.")
                return
            }
            print("Facebook login with Firebase success! ")
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    // What facebook does behind the scenes is that if it detects that a fb user is signed in, the login button gets updated to be a logout button. In our case, it is not applicable since we are not showing the LoginViewController of FB.
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {}
    
}
