//
//  Signup-IdentityViewController.swift
//  ChatApp
//
//  Created by Burak on 27.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import UIKit

class Signup_IdentityViewController: UIViewController {

    var email:Email?
    var username:Username?
    var password:Password?
    
    @IBOutlet weak var textFieldFullname: UITextField!
    
    @IBOutlet weak var labelFullname: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionDone(_ sender: Any) {
        
    }
    
}
