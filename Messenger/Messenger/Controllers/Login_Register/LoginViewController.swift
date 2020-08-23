//
//  LoginViewController.swift
//  Messenger
//
//  Created by Vũ Tựu on 8/22/20.
//  Copyright © 2020 Vũ Tựu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    private let loginButton: UIButton = {
        let logBtn = UIButton()
        logBtn.setTitle("Log In", for: .normal)
        logBtn.layer.cornerRadius = 12
        logBtn.layer.masksToBounds = true
        logBtn.backgroundColor = .link
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
        iv.image = UIImage(named: "logo")
        iv.contentMode = .scaleAspectFit
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passField.delegate = self
        title = "Log in"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
        loginButton.addTarget(self, action: #selector(logBtnTap), for: .touchUpInside)
        //add subView
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passField)
        scrollView.addSubview(loginButton)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width-size)/2, y: 20, width: size, height: size)
        emailField.frame = CGRect(x: 30, y: imageView.bottom + 10, width: scrollView.width - 60, height: 52)
        passField.frame = CGRect(x: 30, y: emailField.bottom + 10, width: scrollView.width - 60, height: 52)
        loginButton.frame = CGRect(x: 30, y: passField.bottom + 10, width: scrollView.width - 60, height: 52)
    }
    @objc func didTapRegister (){
        let vc = RegisterController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func logBtnTap(){
        print("ahyvgyudgyu")
        emailField.resignFirstResponder()
        passField.resignFirstResponder()
        guard
           let email = emailField.text,
           let password = passField.text,
           !email.isEmpty,
           !password.isEmpty,
           password.count >= 6 else {
               alertLoginError()
               return
        }
        //Firebase Log In
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] authResult, error in
                   guard let strongSelf = self else {
                       return
                   }
        })
        let user = result.user
    }
    @objc func alertLoginError(){
        let alert  = UIAlertController(title: "Woops", message: "please enter information to all field", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismis", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
}
extension LoginViewController: UITextFieldDelegate{
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
