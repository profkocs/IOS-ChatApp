//
//  ApiURL.swift
//  ChatApp
//
//  Created by Burak on 24.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import Foundation
enum ApiURL:String {
    
    case signin = "https://kampuschatdeneme.herokuapp.com/api/Auth/CreateToken"
    case sendMail = "https://kampuschatdeneme.herokuapp.com/api/Security/SendSecurityCode?email="
    case checkCode = "https://kampuschatdeneme.herokuapp.com/api/Security/ConfirmEmail"
    case resetPassword = "https://kampuschatdeneme.herokuapp.com/api/Security/ResetPasswordByCode"
    case checkEmail = "s"
    case checkUsername = "d"
    case signup = "a"
}
