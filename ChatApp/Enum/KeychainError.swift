//
//  KeychainError.swift
//  ChatApp
//
//  Created by Burak on 19.06.2021.
//  Copyright © 2021 profkocs. All rights reserved.
//

import Foundation
enum KeychainError: Error {
    // Attempted read for an item that does not exist.
    case itemNotFound
    
    // Attempted save to override an existing item.
    // Use update instead of save to update existing items
    case duplicateItem
    
    // A read of an item in any format other than Data
    case invalidItemFormat
    
    // Any operation result status than errSecSuccess
    case unexpectedStatus(OSStatus)
}
