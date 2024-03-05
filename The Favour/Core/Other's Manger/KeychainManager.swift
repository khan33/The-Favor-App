//
//  KeychainManager.swift
//  The Favour
//
//  Created by Atta khan on 24/05/2023.
//

import Foundation
import KeychainSwift

struct KeychainManager {
    
    private init() { }
    
    private static let keychain = KeychainSwift()
        
    static func saveAuthToken(_ token: String) {
        keychain.set(token, forKey: "auth_token")
    }
    
    static func getAuthToken() -> String? {
        return keychain.get("auth_token")
    }
    
    static func performLogout() {
        keychain.delete("auth_token")
    }
}
