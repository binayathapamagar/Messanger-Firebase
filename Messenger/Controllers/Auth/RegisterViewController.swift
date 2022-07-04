//
//  RegisterViewController.swift
//  Messenger
//
//  Created by Binaya on 20/06/2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

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
        imageView.tintColor = UIColor(red: 0.27, green: 0.37, blue: 0.61, alpha: 1.00)
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
        textField.attributedPlaceholder = NSAttributedString(
            string: "First Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1.00)
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
        textField.attributedPlaceholder = NSAttributedString(
            string: "Last Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1.00)
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
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.27, green: 0.37, blue: 0.61, alpha: 1.00)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
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
        setupProfilePicImageView()
        setupRegisterButton()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "Register"
    }
    
    private func setupSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(profilePicImageView)
        scrollView.addSubview(firstNameTextField)
        scrollView.addSubview(lastNameTextField)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(registerButton)
    }
    
    private func setupSubviewsLayout() {
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
    
    private func setupNavBar() {
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemBlue
        ]
        navigationController?.navigationBar.tintColor = .systemBlue
    }
    
    private func setupTextFields() {
        [firstNameTextField, lastNameTextField, emailTextField, passwordTextField].forEach { textField in
            textField.delegate = self
            textField.textColor = .systemBackground
        }
    }
    
    private func setupProfilePicImageView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfilePic))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        profilePicImageView.addGestureRecognizer(gesture)
        profilePicImageView.isUserInteractionEnabled = true
    }
    
    @objc private func didTapProfilePic() {
        presentPhotoSelectionOptionsActionSheet()
    }
    
    private func setupRegisterButton() {
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    @objc private func registerButtonTapped() {
        resignTextFieldFirstResponder()
        guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !password.isEmpty, email.isValidEmail, password.count >= 6 else {
             showErrorAlert(with: "Error", and: "Please fill the textfields with valid information to register .")
            return
        }
        print("Firebase Registration!")
        //NOTE: The email is being used as the child for the database insertion. So we can check if an user exists through the email.
        DatabaseManager.shared.isEmailUnique(with: email) { [weak self] userEmailAlreadyExists in
            guard let strongSelf = self else {
                print("Self is nil!")
                return
            }
            guard !userEmailAlreadyExists else {
                strongSelf.showErrorAlert(with: "Registration Error", and: "Email provided already exists!")
                return
            }
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
                guard let authDataResult = authDataResult, error == nil else {
                    self?.showErrorAlert(with: "Registration Error", and: "Error registering the user.")
                    return
                }
                print("Registration success with the new user: \(authDataResult.user)")
                let newUser = ChatAppUser(firstName: firstName, lastName: lastName, email: email)
                DatabaseManager.shared.createUser(with: newUser)
                strongSelf.navigationController?.dismiss(animated: true, completion: nil) //Firebase automatically logs the user in upon a successful registration.
            }
        }
    }
    
    private func resignTextFieldFirstResponder() {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    private func presentPhotoSelectionOptionsActionSheet() {
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
