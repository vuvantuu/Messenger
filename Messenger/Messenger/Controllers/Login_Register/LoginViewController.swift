//
//  LoginViewController.swift
//  Messenger
//
//  Created by Vũ Tựu on 8/22/20.
//  Copyright © 2020 Vũ Tựu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
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
        return emailTF
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log in"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
        
        //add subView
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width-size)/2, y: 20, width: size, height: size)
        emailField.frame = CGRect(x: 30, y: imageView.bottom + 10, width: scrollView.width - 60, height: 52)
    }
    @objc func didTapRegister (){
        let vc = RegisterController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
}
