//
//  RestManager.swift
//  ChatApp
//
//  Created by Burak on 24.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import Foundation
class RestManager{
    
    private var task: URLSessionDataTask?
    
    private var request: URLRequest
    
    init(request:URLRequest){
    
        self.request = request
    }
    
    
    func stopTask(){
        
        task!.cancel()
    }
    
    func startTask(completionHandler: @escaping (Data?, URLResponse?, Error?)->()){
        
        task =  URLSession.shared.dataTask(with:request) { (data, response, error) in
            
            print("Task Finished")
            completionHandler(data,response,error)
        }
        
        task!.resume()
    }
    
}
