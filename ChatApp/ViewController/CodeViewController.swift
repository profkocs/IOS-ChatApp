//
//  CodeViewController.swift
//  ChatApp
//
//  Created by Burak on 26.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import UIKit

class CodeViewController: UIViewController {

    
    
    @IBOutlet weak var textFieldCode: UITextField!
    
    @IBOutlet weak var labelCode: UILabel!
    
    private let network = NetworkConnection()
    
    private let spinner = Spinner()
    
    var email:Email?
    
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
        
        guard let code = createCodeModel() else {
            
            return
        }
        
        showSpinner()
        
        startServiceProcess(code:code)
        
    }
    
    
    func isNetworkConnected() -> Bool{
        
        return network.connection
    }
    
    func createCodeModel()-> Code?{
        
        let code = Code(email: (self.email?.email)!, code: textFieldCode.text!)
        
        guard code.isCodeValid() else {
            
            let message = NSLocalizedString(LocalizableKeys.invalid_code.rawValue, comment: "")
            setCodeLabelText(text: message)
            
            return nil
        }
        
        setCodeLabelText(text: "")
        return code
        
    }
    
    

}

extension CodeViewController {
    
    
    private func startServiceProcess(code:Code){
        
        
        let service = AuthService(restModel: code, url: URL(string:ApiURL.checkCode.rawValue)!, method:RestMethod.post.rawValue)
        
        service.checkCode(completionHandler: { data, errors in
            
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

extension CodeViewController{
    
    
    private func showToastMessage(message:String){
        
        DispatchQueue.main.async {
            
            Toast().showToast(message: message, viewController: self)
        }
        
    }
    
    private func setCodeLabelText(text: String){
        
        self.labelCode.text = text
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
            
            self.performSegue(withIdentifier: SegueKeys.codeToPassword.rawValue, sender: nil)
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let passwordScreen = segue.destination as? ForgotPasswordViewController {
            
            passwordScreen.code = createCodeModel()
            
        }
        

    }
    
    
    
    
}
