//
//  AuthService.swift
//  ChatApp
//
//  Created by Burak on 24.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import Foundation
class AuthService: RestService{
    
    private var restModel:RestProtocol?
    
    private var url:URL
    
    private var method:String
    
    private var body:Data?
    
    init(restModel:RestProtocol?, url:URL, method:String){
        
        self.restModel = restModel
        
        self.url = url
        
        self.method = method
        
        self.body = restModel != nil ? restModel!.getEncodedModel() : nil
        
    }
    
    func signIn(completionHandler:@escaping (Data?, [String]?)->()){
        
        setRequest(url:url, body: body, method: method)
        
        self.startService(completionHandler: { data, errors in
            
            print("AuthService Got Response")
            completionHandler(data,errors)
        })
        
    }
    
    func sendMail(completionHandler:@escaping (Data?, [String]?)->()){
        
        setRequest(url:url, body: body, method: method)
        
        self.startService(completionHandler: { data, errors in
            
            print("AuthService Got Response")
            completionHandler(data,errors)
        })
        
        
    }
    
    func checkCode(completionHandler:@escaping (Data?, [String]?)->()){
        
        setRequest(url:url, body: body, method: method)
        
        self.startService(completionHandler: { data, errors in
            
            print("AuthService Got Response")
            completionHandler(data,errors)
        })
        
        
    }
    
    func resetPassword(completionHandler:@escaping (Data?, [String]?)->()){
        
        setRequest(url:url, body: body, method: method)
        
        self.startService(completionHandler: { data, errors in
            
            print("AuthService Got Response")
            completionHandler(data,errors)
        })
        
        
    }
    
    func checkEmail(completionHandler:@escaping (Data?, [String]?)->()){
        
        setRequest(url:url, body: body, method: method)
        
        self.startService(completionHandler: { data, errors in
            
            print("AuthService Got Response")
            completionHandler(data,errors)
        })
        
    }
    
    func checkUsername(completionHandler:@escaping (Data?, [String]?)->()){
        
        setRequest(url:url, body: body, method: method)
        
        self.startService(completionHandler: { data, errors in
            
            print("AuthService Got Response")
            completionHandler(data,errors)
        })
        
    }
    
    func signup(completionHandler:@escaping (Data?, [String]?)->()){
        
        setRequest(url:url, body: body, method: method)
        
        self.startService(completionHandler: { data, errors in
            
            print("AuthService Got Response")
            completionHandler(data,errors)
        })
        
    }
    
    
    

    
}

extension AuthService{
    

    private func setRequest(url:URL, body:Data?, method:String){
        
        
        self.request = URLRequest(url: url)
        self.request?.httpBody = body
        self.request?.httpMethod = method
        request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
    }
    
}
