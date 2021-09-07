//
//  Identity.swift
//  ChatApp
//
//  Created by Burak on 27.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import Foundation
struct Identity:Codable {
    
    var fullname:String
    var username:String
    var email:String
    var password:String
    
    init(fullname:String, username:String, email:String, password:String){
        
        self.fullname = fullname
        self.username = username
        self.email = email
        self.password = password
        
    }
    
    
}
extension Identity{
    
    
    func isFullnameValid()->Bool{
        
        guard fullname.count >= 2 else {
            
            return false
        }
        
        return true
        
    }
    
    
}
extension Identity:RestProtocol{
    
    func getEncodedModel() -> Data? {
        
        do{
            
            return try JSONEncoder().encode(self)
            
        } catch {
            
            return nil
        }
    }
    
    
    
}
