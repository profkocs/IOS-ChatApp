//
//  Password.swift
//  ChatApp
//
//  Created by Burak on 26.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import Foundation
struct Password {
    
    var password:String
    var passwordConfirm:String
    
    init(password:String, passwordConfirm:String){
        
        self.password = password
        self.passwordConfirm = passwordConfirm
        
    }
    
    
}

extension Password{
    
    func isPasswordValid() -> Bool{
        
        guard password.count >= 6 && password.count <= 15 else {
            
            return false
        }
        
        return true
    }
    
    func isPasswordsMatched() -> Bool{
        
        guard password == passwordConfirm else {
            
            return false
        }

        return true
    }
    
    
}

