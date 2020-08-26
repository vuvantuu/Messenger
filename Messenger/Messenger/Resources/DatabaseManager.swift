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
    
    static func safeEmail(emailAddress: String) -> String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
   
}
//MARK: - Account Mgmt
extension DatabaseManager{
    
    
    public func userExists(with email: String,
                           completion: @escaping((Bool) -> Void)){
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        database.child(safeEmail).observeSingleEvent(of: .value,with: {snapshot in
            guard let foundEmail = snapshot.value as? String else{
                completion(false)
                return
            }
            completion(true)
        })
        
    }
    //insert new user to database
    public func insertUser(with user: ChatAppUser, completion: @escaping (Bool) -> Void){
           database.child(user.safeEmail).setValue([
               "first_name": user.firstName,
               "last_name": user.lastName
            ], withCompletionBlock: { error, _ in
                guard error == nil else{
                    print("failed in write to database")
                    completion(false)
                    return
                }
                completion(true)
           })
       }
}
struct ChatAppUser{
    let firstName: String
    let lastName: String
    let emailAddress: String
    
    var safeEmail: String{
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "#", with: "-")
        return safeEmail
    }
    var profilePictureFileName: String {
        return "\(safeEmail)_profile_picture.png"
    }
}
