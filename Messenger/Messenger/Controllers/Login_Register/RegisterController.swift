//
//  LoginViewController.swift
//  Messenger
//
//  Created by Vũ Tựu on 8/22/20.
//  Copyright © 2020 Vũ Tựu. All rights reserved.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class RegisterController: UIViewController {
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private let loginButton: UIButton = {
        let logBtn = UIButton()
        logBtn.setTitle("Register", for: .normal)
        logBtn.layer.cornerRadius = 12
        logBtn.layer.masksToBounds = true
        logBtn.backgroundColor = .systemGreen
        logBtn.setTitleColor(.white, for: .normal)
        
        
        logBtn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return logBtn
    }()
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.clipsToBounds = true
        return sv
    }()
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.circle")
        iv.tintColor = .gray
        iv.contentMode = .scaleAspectFit
        iv.layer.masksToBounds = true
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.lightGray.cgColor
        return iv
    }()
    private let emailField: UITextField = {
        let emailTF = UITextField()
        emailTF.autocapitalizationType = .none
        emailTF.autocorrectionType = .no
        emailTF.returnKeyType = .continue
        emailTF.layer.cornerRadius = 12
        emailTF.layer.borderWidth = 1
        emailTF.layer.borderColor = UIColor.lightGray.cgColor
        emailTF.placeholder = "Email andress..."
        emailTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        emailTF.leftViewMode = .always
        emailTF.backgroundColor = .white
        return emailTF
    }()
    private let passField: UITextField = {
        let passTF = UITextField()
        passTF.autocapitalizationType = .none
        passTF.autocorrectionType = .no
        passTF.returnKeyType = .continue
        passTF.layer.cornerRadius = 12
        passTF.layer.borderWidth = 1
        passTF.layer.borderColor = UIColor.lightGray.cgColor
        passTF.placeholder = "Password field..."
        passTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        passTF.leftViewMode = .always
        passTF.backgroundColor = .white
        passTF.isSecureTextEntry = true
        return passTF
        
    }()
    private let firstName: UITextField = {
        let emailTF = UITextField()
        emailTF.autocapitalizationType = .none
        emailTF.autocorrectionType = .no
        emailTF.returnKeyType = .continue
        emailTF.layer.cornerRadius = 12
        emailTF.layer.borderWidth = 1
        emailTF.layer.borderColor = UIColor.lightGray.cgColor
        emailTF.placeholder = "firtName ..."
        emailTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        emailTF.leftViewMode = .always
        emailTF.backgroundColor = .white
        return emailTF
    }()
    private let lastName: UITextField = {
        let emailTF = UITextField()
        emailTF.autocapitalizationType = .none
        emailTF.autocorrectionType = .no
        emailTF.returnKeyType = .continue
        emailTF.layer.cornerRadius = 12
        emailTF.layer.borderWidth = 1
        emailTF.layer.borderColor = UIColor.lightGray.cgColor
        emailTF.placeholder = "lastName ..."
        emailTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        emailTF.leftViewMode = .always
        emailTF.backgroundColor = .white
        return emailTF
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passField.delegate = self
        title = "sign In"
        view.backgroundColor = .white
        
        loginButton.addTarget(self, action: #selector(logBtnTap), for: .touchUpInside)
        //add subView
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(firstName)
        scrollView.addSubview(lastName)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didtapchangeProfilePic))
        imageView.addGestureRecognizer(gesture)
        
        
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
    }
    @objc func didtapchangeProfilePic(){
        presentPhotoActionSheet()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        
        
        imageView.frame = CGRect(x: (scrollView.width-size)/2, y: 20, width: size, height: size)
        imageView.layer.cornerRadius = imageView.width/2.0
        firstName.frame =  CGRect(x: 30, y: imageView.bottom + 10, width: scrollView.width - 60, height: 52)
        lastName.frame =  CGRect(x: 30, y: firstName.bottom + 10, width: scrollView.width - 60, height: 52)
        emailField.frame = CGRect(x: 30, y: lastName.bottom + 10, width: scrollView.width - 60, height: 52)
        passField.frame = CGRect(x: 30, y: emailField.bottom + 10, width: scrollView.width - 60, height: 52)
        loginButton.frame = CGRect(x: 30, y: passField.bottom + 10, width: scrollView.width - 60, height: 52)
    }
    @objc func didTapRegister (){
        let vc = RegisterController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func logBtnTap(){
        emailField.resignFirstResponder()
        passField.resignFirstResponder()
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
        
        guard let firstName = firstName.text,
            let lastName = lastName.text,
            let email = emailField.text,
            let password = passField.text,
            !email.isEmpty,
            !password.isEmpty,
            !firstName.isEmpty,
            !lastName.isEmpty,
            password.count >= 6 else {
                alertLoginError()
                return
        }
        
        spinner.show(in: view)
        //Firebase register
        DatabaseManager.shared.userExists(with: email, completion: { [weak self] exists in
           
            
            guard let strongSelf = self else{
                
                return
            }
            
            DispatchQueue.main.async {
                strongSelf.spinner.dismiss()
            }
            guard !exists else{
                strongSelf.alertLoginError(message: "look like a user account for that email already exists")
                return
            }
            
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in
                
                guard  authResult != nil, error == nil else {
                    print("Create a user with email: \(email)")
                    return
                }
                DatabaseManager.shared.insertUser(with: ChatAppUser(firstName: firstName, lastName: lastName, emailAddress: email))
                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            })
        })
    }
    func alertLoginError(message : String = "please add infomation to regist an account"){
        let alert  = UIAlertController(title: "Woops", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismis", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
}
extension RegisterController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passField.becomeFirstResponder()
        }
        else if textField == passField{
            logBtnTap()
        }
        return true
    }
}
extension RegisterController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Profile Picture", message: "choose one pic to set up your profile", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take a photo", style: .default, handler: { [weak self] _ in
            self?.showCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose a photo", style: .default, handler:{ [weak self] _ in
            self?.selectImagePiker()
        }))
        
        present(actionSheet, animated: true)
    }
    func showCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated:  true)
    }
    func selectImagePiker(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated:  true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        self.imageView.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

