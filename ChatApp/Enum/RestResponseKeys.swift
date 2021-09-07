//
//  RestResponseKeys.swift
//  ChatApp
//
//  Created by Burak on 20.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import Foundation
enum RestResponseKeys:String{

    case user_id = "userId"
    case access_token = "accessToken"
    case refresh_token = "refreshToken"
    case access_token_expiration = "accessToken_Expiration"
    case refresh_token_expiration = "refreshToken_Expiration"


    case errors = "errors"


}
