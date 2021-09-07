//
//  Username.swift
//  ChatApp
//
//  Created by Burak on 27.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import Foundation
struct Username:Codable {
    
    var username:String
    
    init(username:String){
        
        self.username = username
    }
}
extension Username{
    
    func isUsernameValid()->Bool{
        
        guard username.count >= 2 else{
         
            return false
        }
        
        return true
    }
    
}
extension Username:RestProtocol{
    
    func getEncodedModel() -> Data? {
        
        do{
            
            return try JSONEncoder().encode(self)
            
        } catch {
            
            return nil
        }
    }

    
}
