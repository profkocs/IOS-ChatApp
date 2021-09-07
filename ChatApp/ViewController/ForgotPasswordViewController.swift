//
//  ForgotPasswordViewController.swift
//  ChatApp
//
//  Created by Burak on 26.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    var code:Code?
    
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldPasswordConfirm: UITextField!
    @IBOutlet weak var labelPassword: UILabel!
    
    private let network = NetworkConnection()
    
    private let spinner = Spinner()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Network connection processes
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
        
        showSpinner()
        
        let resetPassword = createResetPasswordModel()
        
        startServiceProcess(resetPassword:resetPassword)
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
    
    
    func createResetPasswordModel() -> ResetPassword{
        
        
        let email = self.code?.email
        let code = self.code?.code
        let password = textFieldPassword.text!
        
        return ResetPassword(email: email!, code: code!, password: password)
    
    }
    

}

extension ForgotPasswordViewController {
    
    
    private func startServiceProcess(resetPassword:ResetPassword){
        
        
        let service = AuthService(restModel: code, url: URL(string:ApiURL.resetPassword.rawValue)!, method:RestMethod.post.rawValue)
        
        service.resetPassword(completionHandler: { data, errors in
            
            self.handleServiceResponse(data: data, error: errors)
            
        })
        
    }
    
    
    
    private func handleServiceResponse(data:Data?, error:[String]?) {
        
        if(data != nil && error == nil) {
            
            removeSpinner()
            
            showSigninScreen()
            
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

extension ForgotPasswordViewController{
    
    
    private func showToastMessage(message:String){
        
        DispatchQueue.main.async {
            
            Toast().showToast(message: message, viewController: self)
        }
        
    }
    
    private func setPasswordLabelText(text: String){
        
        self.labelPassword.text = text
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
    
    
    
    private func showSigninScreen(){
        
        DispatchQueue.main.async {
            
            self.performSegue(withIdentifier: SegueKeys.passwordToSignin.rawValue, sender: nil)
        }
        
        
    }
    

    
    
    
    
}
