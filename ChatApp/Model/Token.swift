//
//  Token.swift
//  ChatApp
//
//  Created by Burak on 18.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import Foundation
import SwiftyJSON
struct Token:Codable{
    
    var user_id:Int?
    var accessToken:String?
    var refreshToken:String?
    var accessTokenExpiration:String?
    var refreshTokenExpiration:String?
    
    init(user_id:Int, accessToken:String, refreshToken:String, accessTokenExpiration:String, refreshTokenExpiration:String){
        
        
        self.user_id = user_id
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.accessTokenExpiration = accessTokenExpiration
        self.refreshTokenExpiration = refreshTokenExpiration
        
    }
    
    
}


extension Token{
    
    init(){}
    
    func getToken()-> Token?{
        
        guard let data = getData() else{
            
            return nil
        }

        print("Token is available.")
        return decodeToken(data:data)

        
    }
    
    func saveToken(){
        
        guard let encodedToken = encodeToken() else {
            return
        }
        
        saveData(data: encodedToken)
        
        
    }
    
    mutating func setToken(data:Data){
        
        self = JsonParse(data: data)
        
    }
    
}

extension Token {
    
    private func getData()->Data?{
        
        do {
            
            let data = try KeychainHelper.shared.read(service: KeychainIdentifier.tokenService.rawValue, account: KeychainIdentifier.account.rawValue)
            
            return data
            
        } catch  {
            
            return nil
        }
        
    }
    
    private func saveData(data:Data){
        
        do {
            
            try KeychainHelper.shared.save(data: data, service: KeychainIdentifier.tokenService.rawValue, account: KeychainIdentifier.account.rawValue)
            
            print("Token is saved.")
            
        } catch  {
            print("Token couldn't saved.")
            // Do nothing...
        }
        
    }
    
    
}

extension Token {
    
    func decodeToken(data:Data)->Token?{
        
        do{
            
            return try JSONDecoder().decode(Token.self, from: data)
            
        } catch {
            
            return nil
        }
        
        
    }
    
    func encodeToken()-> Data?{
        
        do{
            
            return try JSONEncoder().encode(self)
            
        } catch {
            
            return nil
        }
        
    }
    
    func JsonParse(data:Data) -> Token {
        
        let data = JSON(data)
        let json = data["data"]
        
        let user_id = json[RestResponseKeys.user_id.rawValue].intValue
        let accessToken = json[RestResponseKeys.access_token.rawValue].stringValue
        let accessTokenExpiration = json[RestResponseKeys.access_token_expiration.rawValue].stringValue
        let refreshToken = json[RestResponseKeys.refresh_token.rawValue].stringValue
        let refreshTokenExpiration = json[RestResponseKeys.refresh_token_expiration.rawValue].stringValue
        
        
        return Token(user_id: user_id, accessToken: accessToken, refreshToken: refreshToken, accessTokenExpiration: accessTokenExpiration, refreshTokenExpiration: refreshTokenExpiration)
        
    }
    
    
}
