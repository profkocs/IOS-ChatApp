//
//  Code.swift
//  ChatApp
//
//  Created by Burak on 26.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import Foundation
struct Code:Codable{
    
    var email:String
    var code:String
    
    init(email:String, code:String){
        
        self.email = email
        self.code = code
    }
    
    
}
extension Code{
    
    
    func isCodeValid() -> Bool{
        
        guard code.count == 6 else {
            
            return false
        }
        
        return true
        
    }
    
    
}

extension Code:RestProtocol{
    
    
    func getEncodedModel() -> Data? {
        
        do{
            
            return try JSONEncoder().encode(self)
            
        } catch {
            
            return nil
        }
    }
    
    
}
