//
//  Email.swift
//  ChatApp
//
//  Created by Burak on 25.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import Foundation
struct Email:Codable{
    
    var email:String
    
    init(email:String) {
        
        self.email = email
    }
    
}
extension Email{
    
    func isEmailValid() -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = self.email as NSString
            let results = regex.matches(in: self.email, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    
}
extension Email:RestProtocol{
    
    func getEncodedModel() -> Data? {
        
        do{
            
            return try JSONEncoder().encode(self)
            
        } catch {
            
            return nil
        }
    }
    
    
    
    
}
