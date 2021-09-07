//
//  ResetPassword.swift
//  ChatApp
//
//  Created by Burak on 26.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import Foundation
struct ResetPassword:Codable{
    
    var email:String
    var code:String
    var password:String
    
    init(email:String, code:String, password:String){
        
        self.email = email
        self.code = code
        self.password = password
        
    }
    
}
extension ResetPassword:RestProtocol{
    
    func getEncodedModel() -> Data? {
        
        do{
            
            return try JSONEncoder().encode(self)
            
        } catch {
            
            return nil
        }
    }
    
    
}
