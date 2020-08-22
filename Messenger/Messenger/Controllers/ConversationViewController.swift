//
//  ViewController.swift
//  Messenger
//
//  Created by Vũ Tựu on 8/22/20.
//  Copyright © 2020 Vũ Tựu. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController {
     override func viewDidLoad() {
           super.viewDidLoad()
           view.backgroundColor = .red
       }
       
       override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
            
           
           let isLogged_in = UserDefaults.standard.bool(forKey: "logged_in")
           
           if !isLogged_in {
               let vc = LoginViewController()
               let nav = UINavigationController(rootViewController: vc)
               nav.modalPresentationStyle = .fullScreen
               present(nav, animated: false)
           }
           
       }
}

