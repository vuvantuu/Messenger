//
//  ViewController.swift
//  MessageChat
//
//  Created by Vũ Tựu on 8/24/20.
//  Copyright © 2020 Vũ Tựu. All rights reserved.
//

import UIKit
import FirebaseAuth
class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         view.backgroundColor = .red
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
    }
    private func validateAuth()
    {
        print("ConversationView>>>> ok")
        let islogin = UserDefaults.standard.bool(forKey: "logged_in")
        
        if !islogin{
//        if FirebaseAuth.Auth.auth().currentUser == nil {
            print("<<<>>>>")
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }

}

