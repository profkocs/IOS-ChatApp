//
//  TestViewController.swift
//  ChatApp
//
//  Created by Burak on 24.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import UIKit


open class TestViewController: UIViewController {

    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
       
        //testRestManager()
        //testRestService()
        testAuthService()
        
    }
    
    
    func testRestManager(){
        
        var httpResponse:HTTPURLResponse?
        let url = URL(string: "https://kampuschatdeneme.herokuapp.com/api/SignUp/GetCities/id?1")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let manager = RestManager(request: request)
        
        manager.startTask(completionHandler: { _, response, _ in
            
            httpResponse = response as? HTTPURLResponse
            
            if(httpResponse?.statusCode == 200){
                
                print("Status Succeded")
            
            }else{
                
                print("Status Failed")
            }
            
            
        })
    
    }
    
    func testRestService(){
        
        
        let url = URL(string: "https://kampuschatdeneme.herokuapp.com/api/SignUp/GetCities/id?id=100")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let service = RestService()
        
        service.request = request
        
        service.startService(completionHandler: { data, errors in
            
            print("Service Done")
            
            if (data != nil && errors == nil){
                
                print("Success")
                
            } else if (errors != nil && data == nil){
                
                for error in errors!{
                    
                    print(error)
                }
                
                
            }
            
        })
        
        
    }
    
    func testAuthService(){
        
        let model = Credential(username: "burakkocs", password: "123456")
        
        let service = AuthService(restModel: model, url: URL(string: ApiURL.signin.rawValue)!, method:RestMethod.post.rawValue)
        
        service.signIn(completionHandler: { data, errors in

            if(data == nil && errors == nil){
                print("yeah")
            }
            
            if(data != nil) {
                
                print("Success")
            }
            
            if(errors != nil) {
                
                print(errors)
                
                
            }
            
            
        })
        
    }
    
    
    
    @IBAction func actionDeneme(_ sender: Any) {
        
        print("yes")
        
    }
    
    
    func startServiceProcess(credential:Credential){
        
        
        let service = AuthService(restModel: credential, url: URL(string: ApiURL.signin.rawValue)!, method: RestMethod.post.rawValue)
        
        service.signIn(completionHandler: { data, errors in
            
            print("Üst sınıf")
            
        })
        
    }
    
    

}
