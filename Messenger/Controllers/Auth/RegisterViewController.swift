//
//  RegisterViewController.swift
//  Messenger
//
//  Created by Binaya on 20/06/2022.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    // MARK: - Properties
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let profilePicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.layer.masksToBounds = true //Important to make it circular by clipping the overflowing image.
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "First Name"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        return textField
    }()
    
    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Last Name"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        return textField
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
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
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
        title = "Register"
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
            
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width / 4
        profilePicImageView.frame = CGRect(x: (scrollView.width - size) / 2, y: 20, width: size, height: size)
        profilePicImageView.layer.cornerRadius = profilePicImageView.width / 2 
        firstNameTextField.frame = CGRect(x: 30, y: profilePicImageView.bottom + 25, width: scrollView.width - 60, height: 52)
        lastNameTextField.frame = CGRect(x: 30, y: firstNameTextField.bottom + 15, width: scrollView.width - 60, height: 52)
        emailTextField.frame = CGRect(x: 30, y: lastNameTextField.bottom + 15, width: scrollView.width - 60, height: 52)
        passwordTextField.frame = CGRect(x: 30, y: emailTextField.bottom + 15 , width: scrollView.width - 60, height: 52)
        registerButton.frame = CGRect(x: 30, y: passwordTextField.bottom + 20, width: scrollView.width - 60, height: 50)
    }

    // MARK: - Methods
    private func setup() {
        //Textfield delegates
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        //Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(profilePicImageView)
        scrollView.addSubview(firstNameTextField)
        scrollView.addSubview(lastNameTextField)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(registerButton)
        //ProfilePic tap gesture
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfilePic))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        profilePicImageView.addGestureRecognizer(gesture)
        profilePicImageView.isUserInteractionEnabled = true
    }
    
    @objc private func didTapProfilePic() {
        presentPhotoSelectionOptionsActionSheet()
    }
    
    func presentPhotoSelectionOptionsActionSheet() {
        let photoSelectionOptionActionSheetController = UIAlertController(title: "Upload profile picture", message: "Choose the preferred method to upload a profile picture.", preferredStyle: .actionSheet)
        photoSelectionOptionActionSheetController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        photoSelectionOptionActionSheetController.addAction(UIAlertAction(title: "Take a photo ", style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        }))
        photoSelectionOptionActionSheetController.addAction(UIAlertAction(title: "Choose a photo", style: .default, handler: { [weak self] _ in
            self?.presentPhotosLibrary()
        }))
        present(photoSelectionOptionActionSheetController, animated: true, completion: nil)
    }
    
    private func presentCamera() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    private func presentPhotosLibrary() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc private func registerButtonTapped() {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !password.isEmpty, email.isValidEmail, password.count >= 6 else {
             showErrorAlert(with: "Error", and: "Please fill the textfields with valid information to register .")
            return
        }
        // Firebase registration
        print("Firebase Registration!")
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self]  authDataResult, error in
            guard let authDataResult = authDataResult, error == nil else {
                self?.showErrorAlert(with: "Registration Error", and: "Error registering the user.")
                return
            }
            print("Registration success with the new user: \(authDataResult.user)")
        }
    }
    
}

// MARK: - UITextFieldDelegate extension
extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTextField {
            lastNameTextField.becomeFirstResponder()
        } else if textField == lastNameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            registerButtonTapped()
        }
         return true
    }
    
}

// MARK: - UIImagePickerControllerDelegate extension
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let selectedCroppedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profilePicImageView.image = selectedCroppedImage
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
