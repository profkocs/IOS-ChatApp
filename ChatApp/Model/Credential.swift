//
//  Credential.swift
//  ChatApp
//
//  Created by Burak on 20.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import Foundation
struct Credential:Codable{
    
    var username:String
    var password:String
    
    init(username:String, password:String){
        
        self.username = username
        self.password = password
        
    }
    
    
}

extension Credential: RestProtocol{
    
    func getEncodedModel() -> Data? {
        
        do{
            
            return try JSONEncoder().encode(self)
            
        } catch {
            
            return nil
        }
        
    }
    
}
