//
//  Signup-UsernameViewController.swift
//  ChatApp
//
//  Created by Burak on 27.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import UIKit

class Signup_UsernameViewController: UIViewController {


    @IBOutlet weak var textFieldUsername: UITextField!
    
    @IBOutlet weak var labelUsername: UILabel!
    
    private let network = NetworkConnection()
    
    private let spinner = Spinner()
    
    var email:Email?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startMonitoring(queue: DispatchQueue(label: QueueLabel.network_monitor_label.rawValue))
    }
    
    // Network Connection
    
    private func startMonitoring(queue:DispatchQueue){
        
        network.startMonitor(queue: queue)
        
    }
    
    @IBAction func actionDone(_ sender: Any) {
        
        guard isNetworkConnected() else {
            
            let message = NSLocalizedString(LocalizableKeys.network_off.rawValue, comment: "")
            showToastMessage(message:message)
            return
        }
        
        guard let username = createUsernameModel() else {
            
            return
        }
        
        showSpinner()
        
        startServiceProcess(username: username)
        
    }
    
    func isNetworkConnected() -> Bool{
        
        return network.connection
    }
    
    func createUsernameModel()-> Username?{
        
        let username = Username(username: textFieldUsername.text!)
        
        guard username.isUsernameValid() else {
            
            let message = NSLocalizedString(LocalizableKeys.invalid_username.rawValue, comment: "")
            setUsernameLabelText(text: message)
            
            return nil
        }
        
        //setUsernameLabelText(text: "")
        return username
        
    }
  

}

extension Signup_UsernameViewController {
    
    
    private func startServiceProcess(username:Username){
        
        let service = AuthService(restModel: nil, url: URL(string:ApiURL.checkUsername.rawValue)!, method:RestMethod.post.rawValue)
        
        service.checkUsername(completionHandler: { data, errors in
            
            self.handleServiceResponse(data: data, error: errors)
            
        })
        
    }
    
    
    
    private func handleServiceResponse(data:Data?, error:[String]?) {
        
        if(data != nil && error == nil) {
            
            removeSpinner()
            
            showPasswordScreen()
            
        } else if(data == nil && error != nil){
            
            setError(errors: error!)
            
        } else{
            
            let message = NSLocalizedString(LocalizableKeys.something_wrong.rawValue, comment: "")
            showToastMessage(message: message)
        }
        
        removeSpinner()
        
    }
    
    
    
    private func setError(errors:[String]){
        
        for error in errors {
            
            showToastMessage(message: error)
            return
        }
        
    }
    
    
    
}

extension Signup_UsernameViewController{
    
    
    private func showToastMessage(message:String){
        
        DispatchQueue.main.async {
            
            Toast().showToast(message: message, viewController: self)
        }
        
    }
    
    private func setUsernameLabelText(text: String){
        
        self.labelUsername.text = text
    }
    
    
    private func showSpinner(){
        
        DispatchQueue.main.async {
            
            self.spinner.showSpinner(viewController: self)
        }
        
    }
    
    private func removeSpinner(){
        
        DispatchQueue.main.async {
            
            self.spinner.disableSpinner()
        }
    }
    
    
    
    private func showPasswordScreen(){
        
        DispatchQueue.main.async {
            
            self.performSegue(withIdentifier: SegueKeys.usernameToPassword.rawValue, sender: nil)
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let passwordScreen = segue.destination as? Signup_PasswordViewController {
            
            passwordScreen.email = self.email
            passwordScreen.username = createUsernameModel()
            
        }
        
    }
    
    
    
    
}
