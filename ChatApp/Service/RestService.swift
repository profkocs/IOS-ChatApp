//
//  RestService.swift
//  ChatApp
//
//  Created by Burak on 24.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import Foundation
import SwiftyJSON
open class RestService{
    
    
    var request:URLRequest?
    private var manager:RestManager?
    
    private var data:Data?
    private var response:URLResponse?
    private var error:Error?
    
    private var errors:[String]? = []
    
    private func setManager(){
        
        manager = RestManager(request: self.request!)
        
    }
    
    internal func startService(completionHandler:@escaping (Data?, [String]?)->()){
        
        setManager()
        
        manager?.startTask(completionHandler: { data, response, error in

            self.data = data
            self.response = response
            self.error = error
            
            print("Service Got Response")
            self.prepareResponse()
            
            completionHandler(self.data, self.errors)
            
        })
        

    }
    
    

}

extension RestService{
    
    
    private func prepareResponse(){
        
        let httpResponse = response as! HTTPURLResponse
        
        switch httpResponse.statusCode {
            
        case 200...299:
            
            // Success
            print("Task Succeded")
            self.errors = nil
            
        case 400...499 :
            
            // Failed
            print("Task Failed")
            print(httpResponse.statusCode)
            extractErrors()
            self.data = nil
            
        case 500...599 :
            
            // Server Errors
            print("Server Error")
            self.data = nil
            setDefaultErrorMessage()
            
        default:
            break
        }
    }
    
    private func extractErrors(){
        
        do {
            
            var json = try! JSON(data: self.data!)
            
            for error in json["error"][RestResponseKeys.errors.rawValue] {
                
                let message = error.1.stringValue
                
                setErrorsItem(message: message)
                
            }
            
        }
        
    
    }
    
    private func setDefaultErrorMessage(){
        
        let message = NSLocalizedString(LocalizableKeys.something_wrong.rawValue, comment: "")
        
        setErrorsItem(message: message)
        
    }
    
    private func setErrorsItem(message:String){
        
        self.errors?.append(message)
        
    }
    
    
    
}
