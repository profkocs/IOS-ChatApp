//
//  Toast.swift
//  ChatApp
//
//  Created by Burak on 20.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import Foundation
import UIKit
class Toast{
    
    
    func showToast(message: String,viewController:UIViewController) {
        
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.red
        toastLabel.textColor = .white
        toastLabel.font = UIFont.systemFont(ofSize: 15)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        let maxWidthPercentage: CGFloat = 0.8
        let maxTitleSize = CGSize(width: viewController.view.bounds.size.width * maxWidthPercentage, height: viewController.view.bounds.size.height * maxWidthPercentage)
        var titleSize = toastLabel.sizeThatFits(maxTitleSize)
        titleSize.width += 20
        titleSize.height += 10
        toastLabel.frame = CGRect(x: 50, y: viewController.view.frame.size.height - 100, width: viewController.view.frame.size.width-100, height: titleSize.height+25)
        
        viewController.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 3, delay: 0.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
    
}
