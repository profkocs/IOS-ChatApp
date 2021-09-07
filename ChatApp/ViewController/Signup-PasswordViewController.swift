//
//  Signup-PasswordViewController.swift
//  ChatApp
//
//  Created by Burak on 27.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import UIKit

class Signup_PasswordViewController: UIViewController {

    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var labelPassword: UILabel!
    
    @IBOutlet weak var textFieldPasswordConfirm: UITextField!
    
    private let network = NetworkConnection()
    
    private let spinner = Spinner()
    
    var email:Email?
    var username:Username?
    
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
        
        guard (createPasswordModel() != nil) else {
            
            return
        }
        
        showIdentityScreen()
        
    }
    
    func isNetworkConnected() -> Bool{
        
        return network.connection
    }
    
    func createPasswordModel()-> Password?{
        
        let password = Password(password: textFieldPassword.text!, passwordConfirm: textFieldPasswordConfirm.text!)
        
        guard password.isPasswordValid() else {
            
            let message = NSLocalizedString(LocalizableKeys.invalid_password.rawValue, comment: "")
            setPasswordLabelText(text: message)
            
            return nil
        }
        
        guard password.isPasswordsMatched() else {
            
            let message = NSLocalizedString(LocalizableKeys.passwords_not_matched.rawValue, comment: "")
            setPasswordLabelText(text: message)
            
            return nil
        }
        
        setPasswordLabelText(text: "")
        return password
        
    }
    
    
    
}



extension Signup_PasswordViewController{
    
    
    private func showToastMessage(message:String){
        
        DispatchQueue.main.async {
            
            Toast().showToast(message: message, viewController: self)
        }
        
    }
    
    private func setPasswordLabelText(text: String){
        
        self.labelPassword.text = text
    }
    
    
    private func showIdentityScreen(){
        
        DispatchQueue.main.async {
            
            self.performSegue(withIdentifier: SegueKeys.passwordToIdentity.rawValue, sender: nil)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identityScreen = segue.destination as? Signup_IdentityViewController {
            
            identityScreen.email = self.email
            identityScreen.username = self.username
            identityScreen.password = createPasswordModel()
            
        }
        
    }
    
    
    
    
    
    
}
