//
//  ViewController.swift
//  ChatApp
//
//  Created by Burak on 18.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelNetworkConnection: UILabel!
    
    private var networkConnection:Bool = false {
        
        didSet{
            
            guard self.networkConnection else {
                
                showNetworkLabel()
                return
            }
            
            
            removeNetworkLabel()
            
            // Token Control
            checkToken()
            
            
        }
        
    }
    
    private let network = NetworkConnection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Network connection processes
        bindToNetwork()
        
        startMonitoring(queue: DispatchQueue(label: QueueLabel.network_monitor_label.rawValue))
        
    }
    
    // Network Connection
   
    private func bindToNetwork(){
        
        network.binder = {
            
            self.networkConnection = self.network.connection
            
        }
        
    }
    
    private func startMonitoring(queue:DispatchQueue){
        
        network.startMonitor(queue: queue)
        
    }
    
    // Token Control
    
    private func checkToken(){
        
        guard (Token().getToken() != nil) else {
            
            showSigninScreen()
            return
        }
        
        showHomeScreen()
        
    }
    
    
    
    // UI
    
    private func showNetworkLabel(){
        
        DispatchQueue.main.async {
            
            self.labelNetworkConnection.text = NSLocalizedString(LocalizableKeys.network_off.rawValue, comment: "")
        
        }
        
    }
    
    private func removeNetworkLabel(){
        
        DispatchQueue.main.async {
            
            self.labelNetworkConnection.text = ""
            
        }
        
    }

    
    private func showSigninScreen(){
        
        DispatchQueue.main.async {
            
            self.performSegue(withIdentifier: SegueKeys.splashToSignin.rawValue, sender: nil)
        }
        
        
    }
    
    
    private func showHomeScreen(){
        
        DispatchQueue.main.async {
            
            self.performSegue(withIdentifier: SegueKeys.splashToHome.rawValue, sender: nil)
        }
        
    }
    
    

}

