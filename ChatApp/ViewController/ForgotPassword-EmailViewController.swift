//
//  ForgotPassword-EmailViewController.swift
//  ChatApp
//
//  Created by Burak on 25.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import UIKit

class ForgotPassword_EmailViewController:UIViewController{

    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var labelEmail: UILabel!
    
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
        
        guard let email = createEmailModel() else {
        
            return
        }
        
        showSpinner()
        
        startServiceProcess(email: email)
    }
    

    func isNetworkConnected() -> Bool{
        
        return network.connection
    }
    
    func createEmailModel()-> Email?{
        
        let email = Email(email: textFieldEmail.text!)
        
        guard email.isEmailValid() else {
            
            let message = NSLocalizedString(LocalizableKeys.invalid_email.rawValue, comment: "")
            setEmailLabelText(text: message)
            
            return nil
        }
        
        setEmailLabelText(text: "")
        return email
        
    }
    
}

extension ForgotPassword_EmailViewController {
    
    
    private func startServiceProcess(email:Email){
        
        let url = ApiURL.sendMail.rawValue + email.email
        
        let service = AuthService(restModel: nil, url: URL(string:url)!, method:RestMethod.post.rawValue)
        
        service.sendMail(completionHandler: { data, errors in
            
            self.handleServiceResponse(data: data, error: errors)
            
        })
        
    }
    

    
    private func handleServiceResponse(data:Data?, error:[String]?) {
        
        if(data != nil && error == nil) {
            
            removeSpinner()
            
            showCodeScreen()
            
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

extension ForgotPassword_EmailViewController{
    
    
    private func showToastMessage(message:String){
        
        DispatchQueue.main.async {
            
            Toast().showToast(message: message, viewController: self)
        }
        
    }
    
    private func setEmailLabelText(text: String){
        
        self.labelEmail.text = text
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
    
    
    
    private func showCodeScreen(){
        
        DispatchQueue.main.async {
            
            self.performSegue(withIdentifier: SegueKeys.emailToCode.rawValue, sender: nil)
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let codeScreen = segue.destination as? CodeViewController {
            
            codeScreen.email = createEmailModel()
            
        }
        
    }
    
    
    
    
}
