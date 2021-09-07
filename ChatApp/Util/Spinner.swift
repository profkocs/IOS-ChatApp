//
//  Spinner.swift
//  ChatApp
//
//  Created by Burak on 20.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import Foundation
import UIKit
class Spinner: UIViewController {
    
    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    var child:UIViewController? = nil
    
    override func loadView() {
        
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    func showSpinner(viewController:UIViewController){
        
        child = self
        
        // add the spinner view controller
        viewController.addChild(child!)
        child?.view.frame = viewController.view.frame
        
        viewController.view.addSubview(child!.view)
        child?.didMove(toParent: viewController)
        
    }
    
    func disableSpinner(){
        
        child?.willMove(toParent: nil)
        child?.view.removeFromSuperview()
        child?.removeFromParent()
    }
    
    
    
    /*
     // wait two seconds to simulate some work happening
     DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
     // then remove the spinner view controller
     child.willMove(toParent: nil)
     child.view.removeFromSuperview()
     child.removeFromParent()
     }
     */
    
}
