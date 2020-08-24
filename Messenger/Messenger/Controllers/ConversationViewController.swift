//
//  ViewController.swift
//  Messenger
//
//  Created by Vũ Tựu on 8/22/20.
//  Copyright © 2020 Vũ Tựu. All rights reserved.
//

import UIKit
import FirebaseAuth

class ConversationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ConversationViewController")
        if FirebaseAuth.Auth.auth().currentUser == nil {
            print("<<<>>>>")
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
        view.backgroundColor = .red
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
    }
    private func validateAuth()
    {
    
    }
}

