//
//  Database.swift
//  Messenger
//
//  Created by Vũ Tựu on 8/24/20.
//  Copyright © 2020 Vũ Tựu. All rights reserved.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager{
    static let shared =  DatabaseManager()
    
    private let database = Database.database().reference()
    
   
}
//MARK: - Account Mgmt
extension DatabaseManager{
    
    
    public func userExists(with email: String,
                           completion: @escaping((Bool) -> Void)){
        database.child(email).observeSingleEvent(of: .value) { snapshot in
            guard let foundEmail = snapshot.value as? String else{
                completion(false)
                return
            }
            completion(true)
        }
        
    }
    //insert new user to database
    public func insertUser(with user: ChatAppUser){
           database.child(user.emailAddress).setValue([
               "first_name": user.firstName,
               "last_name": user.lastName
           ])
       }
}
struct ChatAppUser{
    let firstName: String
    let lastName: String
    let emailAddress: String
//    let profilePictureUrl: String
}