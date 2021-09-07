//
//  HomeViewController.swift
//  ChatApp
//
//  Created by Burak on 25.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var k = KeychainHelper()
        
        do {try k.deletePassword(service: KeychainIdentifier.tokenService.rawValue, account: KeychainIdentifier.account.rawValue) } catch {}
    }
    

   

}
