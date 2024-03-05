//
//  PrefsManager.swift
//  The Favour
//
//  Created by Atta khan on 26/06/2023.
//

import Foundation


class PrefsManager: NSObject {
    
    class var shared: PrefsManager {
        struct Static {
            static let instance = PrefsManager()
        }
      
        return Static.instance
    }
    
    
    private let defaults = UserDefaults.standard
    private let keyIsWalkThrough = "isWalkThrough"
    private let keyFavorType = "favorType"
    private let keyUsername = "username"
    private let keyFCM = "fcm_key"
      
    var isWalkThrough : Bool {
        set {
            defaults.setValue(newValue, forKey: keyIsWalkThrough)
        }
        get {
            return defaults.bool(forKey: keyIsWalkThrough)
        }
    }
    
    
    
    var favorType: String {
        set {
            defaults.setValue(newValue, forKey: keyFavorType)
        }
        get {
            return defaults.string(forKey: keyFavorType) ?? ""
        }
    }
    
    var username: String {
        set {
            defaults.setValue(newValue, forKey: keyUsername)
        }
        get {
            return defaults.string(forKey: keyUsername) ?? ""
        }
    }
    
    
    var fcmKey: String {
        set {
            defaults.setValue(newValue, forKey: keyFCM)
        }
        get {
            return defaults.string(forKey: keyFCM) ?? ""
        }
    }
    

}
