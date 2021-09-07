//
//  NetworkConnection.swift
//  ChatApp
//
//  Created by Burak on 18.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import Foundation
import Network
class NetworkConnection{
    
    var connection:Bool = false{
        
        didSet{
            
            self.binder()
        }
        
    }
    
    var binder: () -> Void = {}
    
    private let monitor = NWPathMonitor()
    
    init(){
        
        monitor.pathUpdateHandler = { pathUpdateHandler in
            
            if pathUpdateHandler.status == .satisfied {
                
                self.connection = true
                print("Internet connection is on.")
                
            } else {
                
                self.connection = false
                print("Internet connection is off.")
            }
        }
        
        
    }
    
    func startMonitor(queue:DispatchQueue){
        
        self.monitor.start(queue: queue)
    }
    
    
    
    
}
