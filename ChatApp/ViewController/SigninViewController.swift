//
//  SigninViewController.swift
//  ChatApp
//
//  Created by Burak on 19.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {

    @IBOutlet weak var textFieldUsername: UITextField!
    
    @IBOutlet weak var labelUsername: UILabel!
    
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var labelPassword: UILabel!
    
    private let network = NetworkConnection()
    
    private let spinner = Spinner()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Network connection processes
        startMonitoring(queue: DispatchQueue(label: QueueLabel.network_monitor_label.rawValue))
    }
    
    // Processes Start
    @IBAction func actionSignin(_ sender: Any) {
        
        guard isNetworkConnected() else {
            
            let message = NSLocalizedString(LocalizableKeys.network_off.rawValue, comment: "")
            showToastMessage(message:message)
            return
        }
        
        guard !(checkIfUsernameIsEmpty() && checkIfPasswordIsEmpty()) else {
            
            return
        }
        
        
        showSpinner()
         
        let credential = setCredential()
        
        startServiceProcess(credential: credential)
        
    }
    
    // Network Connection
    
    private func startMonitoring(queue:DispatchQueue){
        
        network.startMonitor(queue: queue)
        
    }
    
    private func isNetworkConnected() -> Bool{
        
        return network.connection
    }
    


    private func setCredential() -> Credential{
        
        let username = textFieldUsername.text
        let password = textFieldPassword.text
        
        return Credential(username: username!, password: password!)
    }
    
    
    private func startServiceProcess(credential:Credential){
        
    
        let service = AuthService(restModel: credential, url: URL(string: ApiURL.signin.rawValue)!, method: RestMethod.post.rawValue)
        
        service.signIn(completionHandler: { data, errors in

            self.handleServiceResponse(data: data, error: errors)
            
        })
        
    }
    

}

extension SigninViewController{
    
    private func showToastMessage(message:String){
        
        DispatchQueue.main.async {
            
            Toast().showToast(message: message, viewController: self)
        }
        
    }
    
    //
    
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
    
    //
    
    private func checkIfUsernameIsEmpty() -> Bool{
        
        let usernameLabelText = textFieldUsername.text
        
        if(usernameLabelText!.isEmpty){
            
            let message = NSLocalizedString(LocalizableKeys.empty_field.rawValue, comment: "")
            setUsernameLabelText(text: message)
            return true
        }
        
        setUsernameLabelText(text: "")
        return false
    }
    
    //
    
    private func checkIfPasswordIsEmpty() -> Bool{
        
        let passwordLabelText = textFieldPassword.text
        
        if(passwordLabelText!.isEmpty){
            
            let message = NSLocalizedString(LocalizableKeys.empty_field.rawValue, comment: "")
            setPasswordLabelText(text:message)
            return true
        }
        
        setPasswordLabelText(text:"")
        return false
        
    }
    
    
    //
    
    private func setUsernameLabelText(text: String){
        
        self.labelUsername.text = text
    }
    
    private func setPasswordLabelText(text: String){
        
        self.labelPassword.text = text
    }
    
    
    //
    
    private func showHomeScreen(){
        
        DispatchQueue.main.async {
            
            self.performSegue(withIdentifier: SegueKeys.signinToHome.rawValue, sender: nil)
        }
        
    }
    
    
}

extension SigninViewController{
    
    
    private func handleServiceResponse(data:Data?, error:[String]?) {
        
        if(data != nil && error == nil) {
            
            setToken(data:data!)
            removeSpinner()
            showHomeScreen()
            
        } else if(data == nil && error != nil){
            
            setError(errors: error!)
            
        } else{
            
            let message = NSLocalizedString(LocalizableKeys.something_wrong.rawValue, comment: "")
            showToastMessage(message: message)
        }
        
        removeSpinner()
        
    }
    
    private func setToken(data:Data){
        
        let queue = DispatchQueue(label: QueueLabel.save_token_label.rawValue)
        
        queue.async{
            
            let token = Token().JsonParse(data: data)
            token.saveToken()
            
        }
        
    }
    
    private func setError(errors:[String]){
        
        for error in errors {
            
            showToastMessage(message: error)
            return
        }
        
    }
    
    
    
}
